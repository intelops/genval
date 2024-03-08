package oci

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"os"
	"os/exec"

	"github.com/google/go-containerregistry/pkg/authn"
	"github.com/google/go-containerregistry/pkg/name"
	"github.com/google/go-containerregistry/pkg/v1/remote"
	"github.com/sigstore/cosign/v2/cmd/cosign/cli/fulcio"
	"github.com/sigstore/cosign/v2/pkg/cosign"
	ociremote "github.com/sigstore/cosign/v2/pkg/oci/remote"
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

// var rekorURL = flag.String("rekor-url", defaultRekorURL, "specify Rekor URL")

// var defaultRekorURL = "https://rekor.sigstore.dev"

func VerifyArifact(ctx context.Context, key string, url string, co *cosign.CheckOpts) (verified bool, err error) {
	// var fulcioIntermediates *x509.CertPool
	ref, err := name.ParseReference(url)
	if err != nil {
		return false, err
	}

	_, bundleVerified, err := cosign.VerifyImageSignatures(ctx, ref, co)
	if err != nil {
		return false, err
	}
	if bundleVerified {
		log.Printf("Artifact %s verified succussfully", url)
	}
	return true, nil
}

// var rekorURL = flag.String("rekor-url", defaultRekorURL, "specify Rekor URL")
// var fulcioIntermediates *x509.CertPool
// var defaultRekorURL = "https://rekor.sigstore.dev"

func BuildCosignCheckOpts(ctx context.Context, key string) (*cosign.CheckOpts, error) {
	opts := []remote.Option{
		remote.WithAuthFromKeychain(authn.DefaultKeychain),
		remote.WithContext(ctx),
	}

	rootCerts, err := fulcio.GetRoots()
	if err != nil {
		return nil, fmt.Errorf("getting Fulcio roots: %w", err)
	}

	intermediateCerts, err := fulcio.GetIntermediates()
	if err != nil {
		return nil, fmt.Errorf("getting Fulcio intermediates: %w", err)
	}

	co := &cosign.CheckOpts{
		ClaimVerifier:      cosign.SimpleClaimVerifier,
		IntermediateCerts:  intermediateCerts,
		RootCerts:          rootCerts,
		RegistryClientOpts: []ociremote.Option{ociremote.WithRemoteOptions(opts...)},
	}

	fulcioVerified := co.SigVerifier == nil
	log.Printf("FulCio Verified: %v", fulcioVerified)

	// Check if PubKey is supplied
	if key != "" {
		pub, err := sig.LoadPublicKey(ctx, key)
		if err != nil {
			log.Errorf("Error loading Pub Key: %v", err)
			return nil, err
		}
		co.SigVerifier = pub
	}

	co.IgnoreTlog = true
	co.IgnoreSCT = true
	co.Offline = true

	return co, nil
}
