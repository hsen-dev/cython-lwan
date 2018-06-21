package main

import (
  "fmt"
  "net/http"
  //"runtime"
)

func handle_root(w http.ResponseWriter, r *http.Request) {
  fmt.Fprint(w, "Hello, World!")
}

func fibonacci(n uint32) uint32 {
  var i, a, b uint32
  a, b = 0, 1

  for i = 0; i < n; i++ {
    a, b = b, a + b
  }

  return a
}

func handle_fibonacci(w http.ResponseWriter, r *http.Request) {
  fmt.Fprintf(w, "Fibonacci(10^6) = %d (with overflow)\n", fibonacci(1000000))
}

func main() {
  //runtime.GOMAXPROCS(2)
  http.HandleFunc("/", handle_root)
  http.HandleFunc("/fibonacci", handle_fibonacci)
  fmt.Println("Serving on :8080")
  http.ListenAndServe(":8080", nil)
}
