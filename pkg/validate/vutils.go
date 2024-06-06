package validate

import (
	"errors"

	"github.com/joho/godotenv"
)

var envVars map[string]string

// ReadEnv reads the .env file and stores the variables in envVars
func ReadEnv() error {
	var err error
	envVars, err = godotenv.Read(".env")
	if err != nil {
		return err
	}
	return nil
}

// FetchPolicyFromRegistry fetches the policy based on the command provided
func FetchPolicyFromRegistry(cmd string) (string, error) {
	policies := map[string]string{
		"dockerfileval": envVars["DOCKERFILEPOLICIES"],
		"infrafile":     envVars["INFRAFILEPOLICIES"],
		"terraform":     envVars["TERRAFORMPOLICIES"],
	}

	policy, ok := policies[cmd]
	if !ok {
		return "", errors.New("error getting ociURL")
	}

	return policy, nil
}
