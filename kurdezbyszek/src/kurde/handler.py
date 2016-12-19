from http import HTTPStatus
from http.server import BaseHTTPRequestHandler


class Handler(BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        super().__init__(request, client_address, server)

    def respond(self):
        new_target = 'http://' + self.server.get_target() + self.path
        if self.server.stdout:
            print("Target: '%s'" % new_target)
        self.send_response(HTTPStatus.TEMPORARY_REDIRECT)
        self.send_header('Location', new_target)
        self.end_headers()

    def do_OPTIONS(self):
        return self.respond()

    def do_GET(self):
        return self.respond()

    def do_HEAD(self):
        return self.respond()

    def do_POST(self):
        return self.respond()

    def do_PUT(self):
        return self.respond()

    def do_DELETE(self):
        return self.respond()

    def do_TRACE(self):
        return self.respond()

    def do_CONNECT(self):
        return self.respond()
