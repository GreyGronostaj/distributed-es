import random
from datetime import datetime

import dns.resolver


class DummyProvider(object):
    def __init__(self, pool):
        self.pool = pool

    def get(self):
        return random.choice(self.pool)


class DNSProvider(object):
    def __init__(self, host_name):
        self.host_name = host_name

    def get(self):
        answers = dns.resolver.query(self.host_name, 'A')
        random_answer = random.choice(answers)
        return str(random_answer)


class CachingDNSProvider(object):
    def __init__(self, host_name, cache_ttl, verbose=False):
        self.host_name = host_name
        self.ttl = cache_ttl
        self.verbose = verbose
        self.last_update = datetime.fromtimestamp(0)
        self.last_data = None

        if self.verbose:
            print('Cached DNS answer will last for %d seconds.' % self.ttl)

    def get(self):
        if not self.has_fresh_data():
            self.update_data()
        return self.choice_from_current()

    def has_fresh_data(self):
        return (datetime.now().timestamp() - self.last_update.timestamp()) < self.ttl

    def choice_from_current(self):
        return random.choice(self.last_data)

    def update_data(self):
        if self.verbose:
            print('Updating DNS answer cache')
        self.last_data = dns.resolver.query(self.host_name, 'A')
        self.last_update = datetime.now()
