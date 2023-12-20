// cue_handler.go

package route

import (
	"fmt"
	"io"
	"os/exec"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

func CueHandeler(c *gin.Context) {
	var requestData struct {
		Mode     string `json:"mode"`
		ReqInput string `json:"reqinput"`
		Resource string `json:"resource"`
		Policy   string `json:"policy"`
	}

	// Read the request body and print it for debugging
	requestBody, _ := io.ReadAll(c.Request.Body)
	fmt.Println("Request Body:", string(requestBody))

	if err := c.ShouldBindJSON(&requestData); err != nil {
		log.Printf("Bind ERROR: %v", err)
		c.JSON(400, gin.H{"error": "Invalid JSON dataaa"})
		return
	}
	mode := requestData.Mode
	reqinput := requestData.ReqInput
	resource := requestData.Resource
	policy := requestData.Policy

	if reqinput == "" || resource == "" || policy == "" {
		c.JSON(400, gin.H{"error": "Required arguments missing"})
		return
	}

	cmd := exec.Command("./bin/genval", "--mode", mode, "--reqinput", reqinput, "policy", policy)

	log.Printf("CMD:%v", cmd)
	bs, err := cmd.Output()
	if err != nil {
		log.Errorf("Error executing Command: %v", err)
		c.JSON(500, gin.H{"error": fmt.Sprintf("Error executing Command: %v", err)})
		return
	}

	c.JSON(200, gin.H{"result": string(bs)})
}
