package main

import (
	"fmt"
	"net/http"
)

// simple http-server
func main() {
	const PORT = 7070

	http.HandleFunc("/", helloHandler)
	fmt.Printf("Server running on port %d\n", PORT)
	http.ListenAndServe(fmt.Sprintf(":%d", PORT), nil)
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
}
