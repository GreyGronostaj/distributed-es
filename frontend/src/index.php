<?php
$phonetic_alphabet = [
    'Alfa', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India',
    'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo',
    'Sierra', 'Tango', 'Uniform', 'Victor', 'Whiskey', 'X-ray', 'Yankee', 'Zulu'
];

$es_name = getenv('es_name');

$query = trim($_POST['query'] ?? '');
$raw_response = $query
    ? file_get_contents("http://$es_name/crap/_search?q=nato:$query&pretty")
    : null;
$response = json_decode($raw_response, true);
$hits = $response['hits']['hits'] ?: [];
$results = [];
foreach ($hits as $hit) {
    $source = $hit['_source'];
    $word = $source['word'];
    $nato_word = $source['nato'];
    $results[$word] = $nato_word;
}

function highlight($phrase, $query) {
    $wrapped = "<ins>$query</ins>";
    return str_replace($query, $wrapped, $phrase);
}
?>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pokazówka</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        .jumbotron {
            margin-top: 24px;
        }

        .btn-block {
            margin: 6px 0;
        }

        ins {
            text-decoration: none;
            font-style: italic;
            color: white;
            background-color: green;
            border-radius: 0.3em;
            padding: 0 3px 0 1px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron">
                <h1>Alfabet fonetyczny NATO</h1>
                <p>... oraz najpowszechniejsze angielskie słowa zapisane za jego pomocą.</p>
                <p>(nikt nie powiedział, że to musi być użyteczne!)</p>
                <p><small class="muted">Obsłużył cię serwer <?= gethostname() ?></small></p>
            </div>
        </div>
    </div>
    <?php if ($query): ?>
        <div class="row">
            <div class="col-xs-12">
                <h1>
                    Wyszukane słowo:
                    <i><?= $query ?></i>
                </h1>
                <?php if (!count($results)): ?>
                    Niestety, brak wyników :(
                <?php else: ?>
                    <ol>
                        <?php foreach ($results as $word => $nato_word): ?>
                            <li><b><?= $word ?></b> &rarr; <?= highlight($nato_word, $query); ?></li>
                        <?php endforeach; ?>
                    </ol>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>
    <div class="row">
        <div class="col-xs-12">
            <h1>Wyszukaj swoje ulubione słowo</h1>
        </div>
        <form action="index.php" method="post">
            <?php foreach ($phonetic_alphabet as $letter): ?>
                <div class="col-xs-6 col-sm-3 col-lg-2">
                    <button type="submit" name="query" value="<?= $letter ?>" class="btn btn-primary btn-lg btn-block">
                        <?= $letter ?>
                    </button>
                </div>
            <?php endforeach; ?>
        </form>
    </div>
</div>

</body>
</html>
