import abc
import json

from kurde.handlers.base import BaseHandler


class APIHandler(BaseHandler):
    __metaclass__ = abc.ABCMeta

    @abc.abstractmethod
    def respond(self):
        pass

    def do_GET(self):
        path_parts = list(filter(len, self.path.split('/')))
        if len(path_parts) > 0 and path_parts[0] == '_zbyszek':
            return self.respond_api(path_parts[1:])
        else:
            super().do_GET()

    def respond_api(self, action_trail):
        if len(action_trail) == 0:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(bytes('Hello World!', encoding='utf-8'))
        else:
            handler = getattr(self, 'handle_' + action_trail[0].lower())
            return handler(action_trail[1:])

    def handle_stats(self, trail):
        self.send_response(200)
        self.end_headers()
        self.prune_history()
        result = {
            'window': self.window,
            'requests': len(self.history)
        }
        result_str = json.dumps(result)
        self.wfile.write(bytes(result_str, encoding='utf-8'))
