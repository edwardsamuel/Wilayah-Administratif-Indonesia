#!/bin/sh

URL="http://mfdonline.bps.go.id/index.php?link=hasil_pencarian"

DB_NAME="indonesia"

TMP_DIR="/tmp/indonesia"

areas="provinces regencies districts villages"

mkdir -p ${TMP_DIR}

for key in 'a' 'i' 'u' 'e' 'o'; do
	echo "Fetching ${key}..."
	if [ ! -f "${TMP_DIR}/${DB_NAME}-${key}.html" ]; then
		curl "$URL" --data "pilihcari=desa&kata_kunci=${key}" > ${TMP_DIR}/${DB_NAME}-${key}.html
	else
		echo "Using cached file ${TMP_DIR}/${DB_NAME}-${key}.html"
	fi

	echo "Parsing ${key}"
	./mdf_parser.py ${TMP_DIR} ${DB_NAME}-${key}.html ${key}
done
unset key

csv_files=""
for area in $areas; do
	echo "Combining ${area} into ../csv/${area}.csv"
	cat ${TMP_DIR}/${area}-*.csv | sort | uniq > ../csv/${area}.csv
	csv_files="$csv_files ../csv/${area}.csv"
done

echo "Writing MySQL dump file"

./mdf_mysql_converter.py $csv_files > ../mysql/${DB_NAME}.sql

# rm -rf $TMP_DIR

echo "Testing MySQL dump..."
echo "> Creating database"
mysql -u root -h mysql -e "CREATE DATABASE IF NOT EXISTS indonesia;"
echo "> Importing database"
mysql -u root -h mysql indonesia < ../mysql/indonesia.sql
echo "> Statistics"
mysql -u root -h mysql -t indonesia < ./statistics.sql

echo "Done."
