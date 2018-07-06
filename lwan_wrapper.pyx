from libc.string cimport strlen

cdef extern from "lwan/lwan.h" nogil:
  struct lwan:
    pass

  struct lwan_request:
    pass
    
  struct lwan_response:
    char *mime_type
    lwan_strbuf *buffer
  
  enum lwan_http_status:
    HTTP_OK
  
  struct lwan_url_map:
    lwan_http_status (*handler)(lwan_request *request, lwan_response *response, void *data)
    char *prefix

  void lwan_init(lwan *l)
  void lwan_set_url_map(lwan *l, lwan_url_map *map)
  void lwan_main_loop(lwan *l)
  void lwan_shutdown(lwan *l)

  struct lwan_strbuf:
    pass

  bint lwan_strbuf_set_static(lwan_strbuf *s1, const char *s2, size_t sz)
  bint lwan_strbuf_printf(lwan_strbuf *s, const char *fmt, ...)

cdef lwan_http_status handle_root(lwan_request *request, lwan_response *response, void *data) nogil:
  cdef char *message = "Hello, World!"
  response.mime_type = "text/plain"
  
  lwan_strbuf_set_static(response.buffer, message, strlen(message))
  
  return HTTP_OK

cdef unsigned int fibonacci(unsigned int n) nogil:
  cdef unsigned int i, a, b
  a, b = 0, 1
  
  for i in range(n):
    a, b = b, a + b
  
  return a

cdef lwan_http_status handle_fibonacci(lwan_request *request, lwan_response *response, void *data) nogil:
  response.mime_type = "text/plain"
  
  lwan_strbuf_printf(response.buffer, "Fibonacci(10^6) = %u (with overflow)\n", fibonacci(1000000))
  
  return HTTP_OK

def run():
  cdef:
    lwan l
    lwan_url_map *default_map = [
      {"prefix": "/", "handler": handle_root},
      {"prefix": "/fibonacci", "handler": handle_fibonacci},
      {"prefix": NULL}
    ]
  
  with nogil:
    lwan_init(&l)
  
    lwan_set_url_map(&l, default_map)
    lwan_main_loop(&l)
  
    lwan_shutdown(&l)
