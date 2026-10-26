package main

import (
	"log"
	"net/http"
	"time"
)

func main() {
	server := &http.Server{
		Addr:              ":8080",
		Handler:           http.FileServer(http.Dir("/var/local/larix/data")),
		ReadHeaderTimeout: 5 * time.Second,  // mitigate slowloris attacks
		IdleTimeout:       60 * time.Second, // timeout inactive keep-alive connections
	}

	log.Println("Starting larix...")
	if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatalf("Server failed: %v", err)
	}
}
