package oci

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"os"
	"os/exec"

	"github.com/fatih/color"
	"github.com/google/go-containerregistry/pkg/name"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/fulcio"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/options"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/rekor"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/verify"
	"github.com/sigstore/cosign/v2/pkg/cosign"
	sig "github.com/sigstore/cosign/v2/pkg/signature"
	"github.com/sigstore/sigstore/pkg/cryptoutils"
	log "github.com/sirupsen/logrus"
)

// SignCosign signs an image (`imageRef`) in Keyless mode
// https://github.com/sigstore/cosign/blob/main/KEYLESS.md.
func SignCosign(imageRef, keyRef string) error {
	cosignExecutable, err := exec.LookPath("cosign")
	if err != nil {
		return fmt.Errorf("executing cosign failed: %w", err)
	}

	cosignCmd := exec.Command(cosignExecutable, []string{"sign"}...)
	cosignCmd.Env = os.Environ()
	cosignCmd.Environ()

	if keyRef != "" {
		cosignCmd.Args = append(cosignCmd.Args, "--key", keyRef)
	}
	// Else use keyless mode
	cosignCmd.Args = append(cosignCmd.Args, "--yes")
	cosignCmd.Args = append(cosignCmd.Args, imageRef)

	err = processCosignIO(cosignCmd)
	if err != nil {
		return err
	}

	return cosignCmd.Wait()
}

func processCosignIO(cosignCmd *exec.Cmd) error {
	stdout, err := cosignCmd.StdoutPipe()
	if err != nil {
		log.Error(err, "cosign stdout pipe failed")
	}
	stderr, err := cosignCmd.StderrPipe()
	if err != nil {
		log.Error(err, "cosign stderr pipe failed")
	}

	merged := io.MultiReader(stdout, stderr)
	scanner := bufio.NewScanner(merged)

	if err := cosignCmd.Start(); err != nil {
		return fmt.Errorf("executing cosign failed: %w", err)
	}

	for scanner.Scan() {
		log.Info("cosign: " + scanner.Text())
	}
	if err := scanner.Err(); err != nil {
		log.Error(err, "cosign stdout/stderr scanner failed")
	}

	return nil
}

func VerifyArifact(ctx context.Context, url, key string) (verified bool, err error) {
	ref, err := name.ParseReference(url)
	if err != nil {
		return false, fmt.Errorf("error parsing url: %w", err)
	}

	chopts := &cosign.CheckOpts{
		ClaimVerifier: cosign.SimpleClaimVerifier,
	}

	chopts.RekorClient, err = rekor.NewClient(options.DefaultRekorURL)
	if err != nil {
		return false, fmt.Errorf("creating Rekor client: %v", err)
	}

	chopts.RootCerts, err = fulcio.GetRoots()
	if err != nil {
		return false, fmt.Errorf("getting Fulcio root certs: %v", err)
	}

	ro := options.RegistryOptions{}
	chopts.RegistryClientOpts, err = ro.ClientOpts(ctx)
	if err != nil {
		return false, err
	}

	chopts.IntermediateCerts, err = fulcio.GetIntermediates()
	if err != nil {
		return false, fmt.Errorf("unable to get Fulcio intermediate certs: %s", err)
	}

	// Check if PubKey is supplied
	if key != "" {
		pub, err := sig.LoadPublicKey(ctx, key)
		if err != nil {
			return false, fmt.Errorf("error loading Pub Key: %v", err)
		}
		chopts.SigVerifier = pub
	}
	fulcioVerified := (chopts.SigVerifier == nil)

	chopts.RekorPubKeys, err = cosign.GetRekorPubs(ctx)
	if err != nil {
		return false, fmt.Errorf("unable to get Rekor public keys: %s", err)
	}
	chopts.CTLogPubKeys, err = cosign.GetCTLogPubs(ctx)
	if err != nil {
		return false, fmt.Errorf("unable to get CTLog public keys: %s", err)
	}
	sigs, bundleVerified, _ := cosign.VerifyImageSignatures(context.Background(), ref, chopts)
	// if err != nil {
	// 	return false, fmt.Errorf("error verifying artifact signatures: %s", err)
	// }

	if bundleVerified {
		verify.PrintVerificationHeader(ctx, ref.String(), chopts, bundleVerified, fulcioVerified)
		for _, sig := range sigs {
			if cert, err := sig.Cert(); err == nil && cert != nil {
				ce := cosign.CertExtensions{Cert: cert}
				sub := ""
				if sans := cryptoutils.GetSubjectAlternateNames(cert); len(sans) > 0 {
					sub = sans[0]
				}
				color.Green("Certificate subject: %s", sub)
				if issuerURL := ce.GetIssuer(); issuerURL != "" {
					color.Green("Certificate issuer URL: %s", issuerURL)
				}

				if githubWorkflowTrigger := ce.GetCertExtensionGithubWorkflowTrigger(); githubWorkflowTrigger != "" {
					color.Green("GitHub Workflow Trigger: %s", githubWorkflowTrigger)
				}

				if githubWorkflowSha := ce.GetExtensionGithubWorkflowSha(); githubWorkflowSha != "" {
					color.Green("GitHub Workflow SHA: %s", githubWorkflowSha)
				}
				if githubWorkflowName := ce.GetCertExtensionGithubWorkflowName(); githubWorkflowName != "" {
					color.Green("GitHub Workflow Name: %s", githubWorkflowName)
				}

				if githubWorkflowRepository := ce.GetCertExtensionGithubWorkflowRepository(); githubWorkflowRepository != "" {
					color.Green("GitHub Workflow Repository: %s", githubWorkflowRepository)
				}

				if githubWorkflowRef := ce.GetCertExtensionGithubWorkflowRef(); githubWorkflowRef != "" {
					color.Green("GitHub Workflow Ref: %s", githubWorkflowRef)
				}
			}

			// p, err := sig.Payload()
			// if err != nil {
			// 	fmt.Fprintf(os.Stderr, "Error fetching payload: %v", err)
			// 	return false, err
			// }
			// fmt.Println(string(p))
		}
	}
	return true, nil
}
