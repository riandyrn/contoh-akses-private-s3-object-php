<?php

require '../vendor/autoload.php';

use Aws\Credentials\CredentialProvider;
use Aws\S3\S3Client;
use Aws\S3\S3UriParser;

try {
    $objectURL = 'https://ghazlabs-private.s3.ap-southeast-1.amazonaws.com/poc/meow.jpg';
    echo "<p>Object URL (private): </p><a href='" . $objectURL . "' target='_blank'>" . $objectURL ."</a>";

    $readURL = getReadURL($objectURL);
    echo "<p>Object URL with Auth: </p><a href='" . $readURL . "' target='_blank'>" . $readURL ."</a>";
} catch (Exception $e) {
    echo $e->getMessage();
}

function getReadURL(string $objectURL): string {
    // parse object url to get region, bucket, & object key
    $uriParser = new S3UriParser();
    $parseResult = $uriParser->parse($objectURL);

    // initialize credential provider
    $provider = CredentialProvider::defaultProvider();

    // initialize s3 client
    $s3Client = new S3Client([
        'region' => $parseResult["region"],
        'version' => '2006-03-01',
        'provider' => $provider
    ]);

    // construct s3 command
    $cmd = $s3Client->getCommand('GetObject', [
        'Bucket' => $parseResult["bucket"],
        'Key' => $parseResult['key']
    ]);

    // construct request
    $req = $s3Client->createPresignedRequest($cmd, "+1 minutes");

    // generate presigned url
    return (string) $req->getUri();
}