package oci

import (
	"bufio"
	"context"
	"crypto/x509"
	"flag"
	"fmt"
	"io"
	"os"
	"os/exec"

	"github.com/google/go-containerregistry/pkg/name"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/fulcio"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/options"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/rekor"
	"github.com/sigstore/cosign/v2/pkg/cosign"
	sig "github.com/sigstore/cosign/v2/pkg/signature"
	log "github.com/sirupsen/logrus"
)

// SignCosign signs an image (`imageRef`) using a cosign private key (`keyRef`)
func SignCosign(imageRef string) error {
	cosignExecutable, err := exec.LookPath("cosign")
	if err != nil {
		return fmt.Errorf("executing cosign failed: %w", err)
	}

	cosignCmd := exec.Command(cosignExecutable, []string{"sign"}...)
	cosignCmd.Env = os.Environ()
	cosignCmd.Environ()

	// use keyless mode
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

var (
	rekorURL            = flag.String("rekor-url", defaultRekorURL, "specify Rekor URL")
	defaultRekorURL     = "https://rekor.sigstore.dev"
	fulcioIntermediates *x509.CertPool
)

func VerifyArifact(ctx context.Context, url, key string) (verified bool, err error) {
	ref, err := name.ParseReference(url)
	if err != nil {
		return false, err
	}

	rc, err := rekor.NewClient(*rekorURL)
	if err != nil {
		panic(fmt.Sprintf("creating Rekor client: %v", err))
	}

	roots, err := fulcio.GetRoots()
	if err != nil {
		panic(fmt.Sprintf("getting Fulcio root certs: %v", err))
	}
	ro := options.RegistryOptions{}
	co, err := ro.ClientOpts(ctx)
	if err != nil {
		return
	}

	chopts := &cosign.CheckOpts{
		RekorClient:        rc,
		RootCerts:          roots,
		IntermediateCerts:  fulcioIntermediates,
		RegistryClientOpts: co,
		ClaimVerifier:      cosign.SimpleClaimVerifier,
	}
	// Check if PubKey is supplied
	if key != "" {
		pub, err := sig.LoadPublicKey(ctx, key)
		if err != nil {
			log.Errorf("Error loading Pub Key: %v", err)
			return false, err
		}
		chopts.SigVerifier = pub
	}

	chopts.RekorPubKeys, err = cosign.GetRekorPubs(ctx)
	if err != nil {
		log.Printf("unable to get Rekor public keys: %s", err)
		return false, err
	}
	chopts.CTLogPubKeys, err = cosign.GetCTLogPubs(ctx)
	if err != nil {
		log.Printf("unable to get CTLog public keys: %s", err)
		return false, err
	}
	sigs, bundleVerified, err := cosign.VerifyImageSignatures(context.Background(), ref, chopts)
	if err != nil {
		return false, err
	}
	if bundleVerified {
		fmt.Printf("%v Signatures forund for artifact %s and verified succussfully \n", len(sigs), url)
	}
	return true, nil
}
