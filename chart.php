#!/usr/bin/env php
<?php

$binaries = scandir('./output');

$data = [];
foreach($binaries as $bin) {
	if($bin[0] == '.') {
		continue;
	}

	$parts = explode('.', $bin, 2);
	$data[$parts[0]][$parts[1]] = filesize("./output/" . $bin) / 1000000;

	uksort($data[$parts[0]], "version_compare");
}

$out = fopen('php://output', 'w');
echo "binary\t";
fputcsv($out, array_keys($data['hello']), "\t");

foreach($data as $bin => $bindata) {
	echo $bin . "\t";
	fputcsv($out, $bindata, "\t");
}
