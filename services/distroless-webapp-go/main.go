package main

import (
    "fmt"
    "net/http"
    "time"
)

var baseImage string
var buildTime string

func handler(w http.ResponseWriter, r *http.Request) {
    currentTime := time.Now().UTC()
    fmt.Fprintf(w, "Current time: %s\nBuilt with base image: %s\nBuild time: %s",
        currentTime.Format(time.RFC1123), baseImage, buildTime)
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Server is listening on port 4000...")
    http.ListenAndServe(":4000", nil)
}