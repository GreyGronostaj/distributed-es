import json

index_name = 'crap'

phonetic_alphabet = [
    'Alfa', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India',
    'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo',
    'Sierra', 'Tango', 'Uniform', 'Victor', 'Whiskey', 'X-ray', 'Yankee', 'Zulu'
]

alphabet_map = {word[0].lower(): word for word in phonetic_alphabet}

with open('../res/filtered.txt') as f:
    words = map(lambda line: line.strip().lower(), f.readlines())

bulk_request = []
for word in words:
    nato_word = ' '.join(map(lambda letter: alphabet_map[letter], word))
    document = {
        'word': word,
        'nato': nato_word
    }
    bulk_command = {
        'index': {
            '_index': index_name,
            '_type': index_name,
            '_id': word
        }
    }
    bulk_request.append(bulk_command)
    bulk_request.append(document)

bulk_request_strings = map(lambda doc: json.dumps(doc).strip(), bulk_request)
request_string = '\n'.join(bulk_request_strings)

with open('../res/request.txt', 'w') as f:
    f.write(request_string)
