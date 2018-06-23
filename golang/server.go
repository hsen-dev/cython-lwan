package main

import (
  "flag"
  "fmt"
  "net/http"
  "github.com/valyala/fasthttp"
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

// mainStdHTTP serves HTTP via net/http.
func mainStdHTTP() {
  //runtime.GOMAXPROCS(2)
  http.HandleFunc("/", handle_root)
  http.HandleFunc("/fibonacci", handle_fibonacci)
  fmt.Println("Serving on :8080  (net/http)")
  http.ListenAndServe(":8080", nil)
}

// ---- fast http handlers ----

func fastHandleRoot(ctx *fasthttp.RequestCtx) {
	fmt.Fprint(ctx, "Hello, World!")
}

func fastHandleFibo(ctx *fasthttp.RequestCtx) {
	fmt.Fprintf(ctx, "Fibonacci(10^6) = %d (with overflow)\n", fibonacci(1000000))
}

// mainFastHTTP serves HTTP via fasthttp.
func mainFastHTTP() {
	m := func(ctx *fasthttp.RequestCtx) {
		switch string(ctx.Path()) {
		case "/":
			fastHandleRoot(ctx)
		case "/fibonacci":
			fastHandleFibo(ctx)
		default:
			ctx.Error("not found", fasthttp.StatusNotFound)
		}
	}

	fmt.Println("Serving on :8080  (fasthttp)")
	fasthttp.ListenAndServe(":8080", m)
}




func main() {
	fast := flag.Bool("fast", true, "use fasthttp instead of net/http")
	flag.Parse()

	if *fast {
		mainFastHTTP()
	} else {
		mainStdHTTP()
	}
}
