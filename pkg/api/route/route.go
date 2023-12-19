package route

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

type Validationresult struct {
	Message           string `json:"message"`
	Dockerfile        string `json:"dockerfile"`
	ValidationResults string `json:"validationResults"`
}

func ContainerHandeler(c *gin.Context) {
	var requestData struct {
		Mode         string `json:"mode"`
		ReqInput     string `json:"reqinput"`
		Output       string `json:"output"`
		InputPolicy  string `json:"inputpolicy"`
		OutputPolicy string `json:"outputpolicy"`
	}

	if err := c.ShouldBindJSON(&requestData); err != nil {
		c.JSON(400, gin.H{"error": "Invalid JSON data"})
		return
	}

	mode := requestData.Mode
	reqinput := requestData.ReqInput
	output := requestData.Output
	inputpolicy := requestData.InputPolicy
	outputpolicy := requestData.OutputPolicy

	if reqinput == "" || output == "" || inputpolicy == "" || outputpolicy == "" {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}
	// log.Infof("Received Data: reqinput=%s, output=%s, inputpolicy=%s, outputpolicy=%s", reqinput, output, inputpolicy, outputpolicy)

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--output", output, "--inputpolicy", inputpolicy, "--outputpolicy", outputpolicy)
	// errOutput, err := cmd.CombinedOutput()
	// if err != nil {
	// 	log.Errorf("Error executing Command: %v\nError Output: %s", err, errOutput)
	// 	c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
	// 	returnstring(bc)
	// }
	bs, err := cmd.Output()
	if err != nil {
		// log.Printf("Command: %v", string(bs))
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	// Read the generated Dockerfile content from the file on the server
	generatedDockerfile, err := os.ReadFile(output)
	if err != nil {
		log.Errorf("Error reading generated Dockerfile: %v", err)
		c.JSON(500, gin.H{"error": "Error reading generated Dockerfile"})
		return
	}
	validationResults := string(bs)
	dockerfileContent := generatedDockerfile

	response := Validationresult{
		Message:           "Dockerfile validation succeeded!",
		Dockerfile:        string(dockerfileContent),
		ValidationResults: validationResults,
	}
	// Marshal the response data to JSON and send it as the response
	responseData, err := json.Marshal(response)
	if err != nil {
		log.Errorf("Error marshaling response data: %v", err)
		c.JSON(500, gin.H{"error": "Error creating response"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"result": string(responseData)})
}

func CueHandeler(c *gin.Context) {
	var requestData struct {
		Mode     string `json:"mode"`
		ReqInput string `json:"reqinput"`
		Resource string `json:"resource"`
		Policy   string `json:"policy"`
	}

	if err := c.ShouldBindJSON(&requestData); err != nil {
		c.JSON(400, gin.H{"error": "Invalid JSON data"})
		return
	}
	mode := requestData.Mode
	reqinput := requestData.ReqInput
	resource := requestData.Resource
	policies := requestData.Policy

	if reqinput == "" || resource == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--resource", resource, "--policy", policies)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})

}

func K8sHandeler(c *gin.Context) {
	var requestData struct {
		Mode     string `json:"mode"`
		ReqInput string `json:"reqinput"`
		Policy   string `json:"policy"`
	}

	if err := c.ShouldBindJSON(&requestData); err != nil {
		c.JSON(400, gin.H{"error": "Invalid JSON data"})
		return
	}

	mode := requestData.Mode
	reqinput := requestData.ReqInput
	policies := requestData.Policy

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--policy", policies)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})

}

func TfHandeler(c *gin.Context) {
	var requestData struct {
		Mode     string `json:"mode"`
		ReqInput string `json:"reqinput"`
		Policy   string `json:"policy"`
	}

	if err := c.ShouldBindJSON(&requestData); err != nil {
		c.JSON(400, gin.H{"error": "Invalid JSON data"})
		return
	}

	mode := requestData.Mode
	reqinput := requestData.ReqInput
	policies := requestData.Policy

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--policy", policies)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})

}

func CELHandeler(c *gin.Context) {
	var requestData struct {
		Mode     string `json:"mode"`
		ReqInput string `json:"reqinput"`
		Policy   string `json:"policy"`
	}

	if err := c.ShouldBindJSON(&requestData); err != nil {
		c.JSON(400, gin.H{"error": "Invalid JSON data"})
		return
	}

	mode := requestData.Mode
	reqinput := requestData.ReqInput
	policies := requestData.Policy

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--policy", policies)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})

}
