import re

with open('../res/corpus.txt', encoding='utf-8') as f:
    corpus = [line.strip().lower() for line in f.readlines()]

filters = (
    lambda word: len(word) >= 5,
    lambda word: re.match('^[a-z]+$', word, re.IGNORECASE)
)

words = corpus
for filter_func in filters:
    words = filter(filter_func, words)

with open('../res/filtered.txt', 'w', encoding='utf-8') as f:
    f.writelines(map(lambda word: word + '\n', words))
