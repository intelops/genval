package route

import (
	"fmt"
	"os/exec"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

func K8sHandler(c *gin.Context) {
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

	cmd := exec.Command("/genval", "--mode", mode, "--reqinput", reqinput, "--policy", policies)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})

}
