package route

import (
	"fmt"
	"os/exec"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

func ContainerHandeler(c *gin.Context) {
	// Extract input data from the request
	reqinput := c.PostForm("reqinput")
	output := c.PostForm("output")
	inputpolicy := c.PostForm("inputpolicy")
	outputpolicy := c.PostForm("outputpolicy")

	if reqinput == "" || output == "" || inputpolicy == "" || outputpolicy == "" {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("genval", "--mode", "container", "--reqinput", reqinput, "--output", output, "--inputputpolicy", inputpolicy, "--outputpolicy", outputpolicy)

	bc, err := cmd.CombinedOutput()
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

	cmd := exec.Command("genval", "--mode", "cue", "--reqinput", reqinput, "--resource", resource, "--policy", policies)
	bc, err := cmd.CombinedOutput()
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

	cmd := exec.Command("genval", "--mode", "k8s", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.CombinedOutput()
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

	cmd := exec.Command("genval", "--mode", "tf", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.CombinedOutput()
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

	cmd := exec.Command("genval", "--mode", "cel", "--reqinput", reqinput, "--policy", policies)
	bc, err := cmd.CombinedOutput()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bc)})

}
