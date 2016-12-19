from http import HTTPStatus

from kurde.handlers.api import APIHandler


class Handler(APIHandler):
    def respond(self):
        new_target = 'http://' + self.server.get_target() + self.path
        if self.server.stdout:
            print("Target: '%s'" % new_target)
        self.send_response(HTTPStatus.TEMPORARY_REDIRECT)
        self.send_header('Location', new_target)
        self.end_headers()
