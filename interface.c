#include <lwan/lwan.h>

extern int handle_root(struct lwan_request *request, struct lwan_response *response);

LWAN_HANDLER(root)
{
  return handle_root(request, response);
}

static int listen_and_serve(void)
{
  const struct lwan_url_map default_map[] = {
    { .prefix = "/", .handler = LWAN_HANDLER_REF(root) },
    { .prefix = NULL }
  };
  struct lwan l;

  lwan_init(&l);

  lwan_set_url_map(&l, default_map);
  lwan_main_loop(&l);

  lwan_shutdown(&l);

  return 0;
}
