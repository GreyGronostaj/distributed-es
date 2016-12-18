import json
from sys import argv

from kurde import server

if __name__ == '__main__':
    config_file = argv[1]
    with open(config_file, encoding='utf-8') as f:
        config = json.load(f)
    server.run(**config)
