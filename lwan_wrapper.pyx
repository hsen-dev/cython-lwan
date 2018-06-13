from libc.string cimport strlen

cdef extern from "lwan/lwan.h":
  struct lwan_strbuf:
    pass
  struct lwan_value:
    char* value
  struct lwan_request:
    lwan_value original_url
  struct lwan_response:
    char *mime_type
    lwan_strbuf *buffer
  
  enum lwan_http_status:
    HTTP_OK

cdef extern from "lwan/lwan-strbuf.h":
  struct lwan_strbuf:
    pass

  bint lwan_strbuf_set_static(lwan_strbuf *s1, const char *s2, size_t sz) nogil

cdef extern from "interface.c":
  int listen_and_serve() nogil

def run():
  with nogil:
    listen_and_serve()

cdef public int handle_root(lwan_request *request, lwan_response *response) nogil:
  cdef char *message = "Hello, World!"
  response.mime_type = "text/plain"
  
  lwan_strbuf_set_static(response.buffer, message, strlen(message))
  
  return HTTP_OK
