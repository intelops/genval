# Configuration Details

### `LLMConfig`

Defines the overall configuration structure for the Language Model.

| Field        | Type          | Description                                                            |
| ------------ | ------------- | ---------------------------------------------------------------------- |
| `apiVersion` | `string`      | Specifies the version of the API used in the configuration (optional). |
| `metadata`   | `LLMMetadata` | Contains metadata about the configuration, specifically the `name`.    |
| `llmSpec`    | `LLMSpec`     | Configuration parameters for the language model, detailed below.       |

### `LLMMetadata`

Provides metadata for each `LLMConfig` instance, primarily used for naming and identification purposes.

| Field  | Type     | Description                              |
| ------ | -------- | ---------------------------------------- |
| `name` | `string` | Unique identifier for the configuration. |

### `LLMSpec`

Defines the core settings to configure behavior and parameters of the language model.

| Field               | Type            | Description                                                                                                                  |
| ------------------- | --------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `userSystemPrompt`  | `string`        | Used only when `assistant` is set to `user`. <br> Provides context or guidelines as a prompt for the LLM (optional).         |
| `userPrompt`        | `string`        | The primary user prompt for the model to respond to.                                                                         |
| `backend`           | `string`        | Specifies the backend service used for the language model (e.g., OpenAI, Ollama).                                            |
| `assistant`         | `string`        | The assistant model being configured. <br> Currently supported assistants: [Cue, CEL, Dockerfile, Regex, Rego] (Required).   |
| `apiKey`            | `string`        | API key as environment variable (required for OpenAI models).                                                                |
| `model`             | `string`        | Identifier for the model variant, such as `GPT4` or `ollama`.                                                                |
| `output`            | `string`        | File path to save the LLM output (optional).                                                                                 |
| `maxTokens`         | `int`           | Maximum tokens to generate in a response. <br> Higher values increase response length but may also increase cost (optional). |
| `presencePenalty`   | `float32`       | Penalizes repeated topics to encourage response diversity. <br> Typical range is [0.0, 1.0] (optional).                      |
| `frequencyPenalty`  | `float32`       | Reduces word frequency repetition, aiding in response variety (optional).                                                    |
| `topP`              | `float32`       | Probability mass cutoff for nucleus sampling, affecting randomness in responses. <br> Range: [0.0, 1.0] (optional).          |
| `temperature`       | `float32`       | Controls creativity in responses; higher values yield more random outputs. <br> Common range: [0.0, 1.0] (optional).         |
| `url`               | `string`        | Endpoint URL to connect with the backend service. Useful if model is hosted locally, e.g., ollama/llama3 (optional).         |
| `keepAliveDuration` | `time.Duration` | Controls how long a model is loaded and retained in memory, specified as `time.Duration`.                                    |

---

## Example YAML Configuration

```yaml
apiVersion: genval/genai/v1beta1
metadata:
  name: test-config
requirementSpec:
  common:
    userPrompt: ./templates/inputs/genai/prompt.txt
    userSystemPrompt:
  llmSpec:
    openAIConfig:
      - model: GPT4
        assistant:
        useTheModel: true
        apiKey: OPENAI_KEY
        temperature: 0.7
        topP: 0.3
        streaming: true
        maxTokens: 2048
```
