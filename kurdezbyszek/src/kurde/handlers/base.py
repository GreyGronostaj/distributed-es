import abc
from datetime import datetime
from http.server import BaseHTTPRequestHandler


class BaseHandler(BaseHTTPRequestHandler):
    __metaclass__ = abc.ABCMeta

    history = []
    window = 3

    @abc.abstractmethod
    def respond(self):
        pass

    def log_and_respond(self):
        self.history.append(datetime.now())
        self.prune_history()
        self.respond()

    def prune_history(self):
        self.history = [ts for ts in self.history if datetime.now().timestamp() - ts.timestamp() <= self.window]

    def do_OPTIONS(self):
        return self.log_and_respond()

    def do_GET(self):
        return self.log_and_respond()

    def do_HEAD(self):
        return self.log_and_respond()

    def do_POST(self):
        return self.log_and_respond()

    def do_PUT(self):
        return self.log_and_respond()

    def do_DELETE(self):
        return self.log_and_respond()

    def do_TRACE(self):
        return self.log_and_respond()

    def do_CONNECT(self):
        return self.log_and_respond()
