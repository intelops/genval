package route

import (
	"fmt"
	"os/exec"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

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

	// if reqinput == "" || output == "" || inputpolicy == "" || outputpolicy == "" {
	// 	c.JSON(400, gin.H{"error": "Required arguments missing"})
	// 	return
	// }
	log.Infof("Received Data: reqinput=%s, output=%s, inputpolicy=%s, outputpolicy=%s", reqinput, output, inputpolicy, outputpolicy)

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "--output", output, "--inputpolicy", inputpolicy, "--outputpolicy", outputpolicy)
	// errOutput, err := cmd.CombinedOutput()
	// if err != nil {
	// 	log.Errorf("Error executing Command: %v\nError Output: %s", err, errOutput)
	// 	c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
	// 	return
	// }
	bc, err := cmd.Output()
	// log.Printf("Command: %v", string(bc))
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})
}
func CueHandeler(c *gin.Context) {
	reqinput := c.PostForm("reqinput")
	resource := c.PostForm("resource")
	policies := c.PostForm("policy")

	if reqinput == "" || resource == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", "cue", "--reqinput", reqinput, "--resource", resource, "--policy", policies)
	bc, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})

}

func K8sHandeler(c *gin.Context) {
	reqinput := c.PostForm("reqinput")
	policies := c.PostForm("policy")

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", "k8s", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})

}

func TfHandeler(c *gin.Context) {
	reqinput := c.PostForm("reqinput")
	policies := c.PostForm("policy")

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", "tf", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})

}

func CELHandeler(c *gin.Context) {
	reqinput := c.PostForm("reqinput")
	policies := c.PostForm("policy")

	if reqinput == "" || len(policies) == 0 {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", "cel", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})

}
