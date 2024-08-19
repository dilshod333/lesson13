package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type PingResponse struct {
	Message string `json:"message"`
}

func PingHandler(c *gin.Context) {
	response := PingResponse{Message: "pong"}
	c.JSON(http.StatusOK, response)
}

func main() {
	r := gin.Default()

	r.GET("/ping", PingHandler)

	r.Run(":8080")
}
