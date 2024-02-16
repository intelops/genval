package server

import "github.com/gin-gonic/gin"

const PORT = "3030"

func InitServer() {
	router := gin.Default()
	router.Run(":" + PORT)
}
