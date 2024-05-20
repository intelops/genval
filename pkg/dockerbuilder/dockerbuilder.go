package dockerbuilder

import (
	"bufio"
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
	"github.com/docker/docker/pkg/archive"
)

type ImageBuildResponseItem struct {
	Stream string `json:"stream,omitempty"`
	Aux    struct {
		ID string `json:"ID,omitempty"`
	} `json:"aux,omitempty"`
	Error       string `json:"error,omitempty"`
	ErrorDetail struct {
		Code    int    `json:"code,omitempty"`
		Message string `json:"message,omitempty"`
	} `json:"errorDetail,omitempty"`
}

// ImageBuilder builds a Docker image from a Dockerfile
func ImageBuilder(dockerfile string, tags []string, labels map[string]string, logFile string) error {
	ctx := context.Background()

	// Create a Docker client
	cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
	if err != nil {
		return err
	}
	defer cli.Close()

	// Read the Dockerfile
	tar, err := archive.TarWithOptions(dockerfile, &archive.TarOptions{})
	if err != nil {
		return err
	}

	// Build the image
	resp, err := cli.ImageBuild(
		ctx,
		tar,
		types.ImageBuildOptions{
			Context:    tar,
			Dockerfile: "Dockerfile",
			Remove:     true,
			Tags:       tags,
			Labels:     labels,
		},
	)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// need to read the response from Docker, I think otherwise the image
	// might not finish building before continuing to execute here
	// Use a scanner to read and parse the JSON messages from the build response
	scanner := bufio.NewScanner(resp.Body)
	var imageID string
	successfulTags := make(map[string]bool)
	for scanner.Scan() {
		line := scanner.Text()

		var responseItem ImageBuildResponseItem
		if err := json.Unmarshal([]byte(line), &responseItem); err != nil {
			fmt.Errorf("Error parsing build response: %v\n", err)
			continue
		}

		if responseItem.Error != "" {
			fmt.Errorf("Build error: %s\n", responseItem.Error)
			return fmt.Errorf("error parsing response: %v\n", responseItem.Error)
		}

		if responseItem.Aux.ID != "" {
			imageID = responseItem.Aux.ID
		}

		// Check for successful tag messages
		if responseItem.Stream != "" {
			for _, tag := range tags {
				if containsSuccessfulTag(responseItem.Stream, tag) {
					successfulTags[tag] = true
				}
			}
		}

	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}

	if imageID != "" {
		fmt.Errorf("Built image ID: %s\n", imageID)
	} else {
		fmt.Errorf("No image ID found in build response")
	}

	if len(successfulTags) > 0 {
		fmt.Errorf("Successfully tagged images:")
		for tag := range successfulTags {
			fmt.Printf(" - %s\n", tag)
		}
	} else {
		fmt.Errorf("no successful tags found in build response")
	}

	fmt.Println("Image built successfully!")
	return nil
}

func parseTags(tags string) []string {
	return strings.Split(tags, ",")
}

func containsSuccessfulTag(stream, tag string) bool {
	return fmt.Sprintf("Successfully tagged %s\n", tag) == stream
}
