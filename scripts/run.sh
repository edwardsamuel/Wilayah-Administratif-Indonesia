#!/bin/sh

DB_NAME="indonesia"

TMP_DIR="/tmp/indonesia"

mkdir -p ${TMP_DIR}

for key in 'a' 'i' 'u' 'e' 'o'; do
	echo "Fetching ${key}..."
	if [ ! -f "${TMP_DIR}/${DB_NAME}-${key}.html" ]; then
		curl "http://mfdonline.bps.go.id/index.php?link=hasil_pencarian" --data "pilihcari=desa&kata_kunci=${key}" > ${TMP_DIR}/${DB_NAME}-${key}.html
	else
		echo "Using cached file ${TMP_DIR}/${DB_NAME}-${key}.html"
	fi

	echo "Parsing ${key}"
	./mdf_parser.py ${TMP_DIR} ${DB_NAME}-${key}.html ${key}
done
unset key

for area in "provinces" "regencies" "districts" "villages"; do
	echo "Combining ${area} into ../csv/${area}.csv"
	cat ${TMP_DIR}/${area}-*.csv | sort | uniq > ../csv/${area}.csv
done

echo "Writing MySQL dump file"
./mdf_mysql_converter.py ../csv/provinces.csv ../csv/regencies.csv ../csv/districts.csv ../csv/villages.csv > ../mysql/${DB_NAME}.sql

# rm -rf $TMP_DIR

echo "Done."