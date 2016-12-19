import json
import os
from sys import argv

from kurde import server


def run_from_file():
    config_file = argv[1]
    try:
        with open(config_file, encoding='utf-8') as f:
            config = json.load(f)
        server.run(**config)
    except FileNotFoundError as e:
        print('Config directory listing:')
        base = os.path.dirname(config_file)
        for mid in os.walk(base):
            for fn in mid[2]:
                print('  ' + fn)
        raise e


def run_from_env():
    server.run(
        os.environ.get('lookup_name'),
        int(os.environ.get('listen_port') or 80),
        int(os.environ.get('service_port') or 80),
        int(os.environ.get('cache_ttl') or 0),
        bool(os.environ.get('verbose'))
    )


if __name__ == '__main__':
    if len(argv) > 1:
        run_from_file()
    else:
        run_from_env()
