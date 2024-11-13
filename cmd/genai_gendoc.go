package cmd

import (
	"github.com/spf13/cobra"
)

var gendocCmd = &cobra.Command{
	Use:   "gendoc",
	Short: "Generates code explnation document for the provided code file/files",
	Long:  `Generates Code explanation documentin markdown format for code file/files. If a user needs to generate code explanation for more than one file, user can pass in a path to the directory containing all the files to the --path flag.`,
	RunE:  runGendocCmd,
}

type gendocFlags struct {
	model    string
	endpoint string
	prompt   string
	path     string
	// assistant        string
	// userSystemPrompt string
}

var gendocArgs gendocFlags

func init() {
	gendocCmd.Flags().StringVarP(&gendocArgs.model, "model", "m", "", "Select the AI model")
	gendocCmd.Flags().StringVarP(&gendocArgs.endpoint, "endpoint", "e", "", "Endpoint for the AI model")
	gendocCmd.Flags().StringVarP(&gendocArgs.prompt, "prompt", "p", "", "Your prompt to the model")
	gendocCmd.Flags().StringVarP(&gendocArgs.path, "path", "d", "", "Path to the code file/s to generate code explanation mardown docs")

	genaiCmd.AddCommand(gendocCmd)
}

func runGendocCmd(cmd *cobra.Command, args []string) error {
	// if genaiArgs.model == "" {
	// 	genaiArgs.model = openai.GPT4o
	// }
	// var systemPrompt, userPrompt string
	// if gendocArgs.path != "" {
	// 	// spContent, err := utils.ReadFile(llm.Gendoc)
	// 	// if err != nil {
	// 	// 	return fmt.Errorf("error reading user system prompt file: %v", err)
	// 	// }
	//
	// 	systemPrompt = string(spContent)
	// 	upContent, err := utils.ReadFile(gendocArgs.path)
	// 	if err != nil {
	// 		return fmt.Errorf("error reading input path: %v", err)
	// 	}
	// 	userPrompt = string(upContent)
	// }
	//
	// ctx := context.Background()
	// resp, err := llm.GenerateCompletion(ctx, genaiArgs.model, systemPrompt, userPrompt)
	// if err != nil {
	// 	return fmt.Errorf("error generating response: %v", err)
	// }
	//
	// fmt.Println(resp.Choices[0].Message.Content)

	return nil
}
