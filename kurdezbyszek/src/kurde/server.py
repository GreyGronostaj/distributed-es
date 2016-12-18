from http.server import HTTPServer

from kurde.handler import Handler
from kurde.providers import DNSProvider, CachingDNSProvider


class Server(HTTPServer):
    def __init__(self, server_address, request_handler_class, target_provider, verbose: bool):
        super().__init__(server_address, request_handler_class)
        self.target_provider = target_provider
        self.stdout = verbose

    def get_target(self):
        return self.target_provider.get()


def run(lookup_name: str, cache_ttl: int = 0, verbose: bool = False) -> None:
    server_address = ('', 80)
    if cache_ttl > 0:
        provider = CachingDNSProvider(lookup_name, cache_ttl, verbose=verbose)
    else:
        provider = DNSProvider(lookup_name)
    server = Server(server_address, Handler, provider, verbose)
    server.serve_forever()
