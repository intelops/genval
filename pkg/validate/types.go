package validate

const (
	metaExt   = ".json"
	policyExt = ".rego"
)

type regoMetadata struct {
	Name        string `json:"name"`
	PolicyName  string `json:"policy_name"`
	PolicyFile  string `json:"policy_file"`
	Severity    string `json:"severity"`
	Description string `json:"description"`
	Benchmark   string `json:"benchmark"`
	Category    string `json:"category"`
}

type Metadata struct {
	Name        string `yaml:"name"`
	Description string `yaml:"description"`
	Severity    string `yaml:"severity"`
	Benchmark   string `yaml:"benchmark"`
}

type CELPolicy struct {
	APIVersion string   `yaml:"apiVersion"`
	Kind       string   `yaml:"kind"`
	Metadata   Metadata `yaml:"metadata"`
	Rule       string   `yaml:"rule"`
}

type CELPolicyFile struct {
	Policies []CELPolicy `yaml:"policies"`
}
