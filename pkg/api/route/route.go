// route/container.go

package route

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/intelops/genval/cmd/modes"
)

func CallEndpoint(c *gin.Context) {
	// Extract parameters from the request body
	var requestParams struct {
		Mode         string   `json:"mode"`
		Input        string   `json:"input"`
		Output       string   `json:"output"`
		InputPolicy  string   `json:"inputpolicy"`
		OutputPolicy string   `json:"outputpolicy"`
		Resource     string   `json:"resource"`
		Policies     []string `json:"policies"`
		Verify       bool     `json:"verify"`
	}

	if err := c.BindJSON(&requestParams); err != nil {
		c.JSON(400, gin.H{"error": "Invalid request format"})
		return
	}

	// Determine the mode and call the appropriate business logic function
	switch requestParams.Mode {
	case "container":
		modes.ExecuteContainer(requestParams.Input, requestParams.Output, requestParams.InputPolicy, requestParams.OutputPolicy)
	case "cue":
		modes.ExecuteCue(requestParams.Input, requestParams.Resource, requestParams.Verify, requestParams.Policies...)
	case "k8s":
		// Call the K8s with rego mode's execution function
		modes.ExecuteK8s(requestParams.Input, requestParams.Policies...)
	case "tf":
		// Call the Tf with rego mode's execution function
		modes.ExecuteTf(requestParams.Input, requestParams.Policies...)
	case "showjson":
		// Call the showjson mode for prining the JSON representation of reqinput files
		modes.ExecuteShowJSON(requestParams.Input)
	case "cel":
		// Call cel mode for validating Kubernetes manifests with CEL
		modes.ExecuteCEL(requestParams.Input, requestParams.Policies...)
	default:
		c.JSON(400, gin.H{"error": "Invalid mode"})
		return
	}

	// Respond to the client
	c.JSON(200, gin.H{"message": fmt.Sprintf("%s endpoint processed successfully", c.Request.URL.Path)})
}
