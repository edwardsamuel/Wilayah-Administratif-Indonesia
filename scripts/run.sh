#!/bin/sh

DB_NAME="indonesia"
DB_HOST="mysql"
DB_USER="root"

TMP_DIR="/tmp/indonesia"

SCRIPT_DIR=`dirname $0`
CSV_DIR=`realpath ${SCRIPT_DIR}/../csv`

while getopts 'h:u:' opts; do
    case $opts in
        h) DB_HOST=$OPTARG ;;
        u) DB_USER=$OPTARG ;;
        *) error 'Unexpected argument' ;;
    esac
done

mkdir -p ${TMP_DIR}

for key in 'a' 'i' 'u' 'e' 'o'; do
	echo "Fetching ${key}..."
	if [ ! -f "${TMP_DIR}/${DB_NAME}-${key}.html" ]; then
		curl "http://mfdonline.bps.go.id/index.php?link=hasil_pencarian" --data "pilihcari=desa&kata_kunci=${key}" > ${TMP_DIR}/${DB_NAME}-${key}.html
	else
		echo "Using cached file ${TMP_DIR}/${DB_NAME}-${key}.html"
	fi

	echo "Parsing ${key}"
	$SCRIPT_DIR/mdf_parser.py ${TMP_DIR} ${DB_NAME}-${key}.html ${key}
done
unset key

for area in "provinces" "regencies" "districts" "villages"; do
	echo "Combining ${area} into ../csv/${area}.csv"
	cat ${TMP_DIR}/${area}-*.csv | sort | uniq > $CSV_DIR/${area}.csv
done

echo "Writing MySQL dump file"
$SCRIPT_DIR/mdf_mysql_converter.py $CSV_DIR/provinces.csv $CSV_DIR/regencies.csv $CSV_DIR/districts.csv $CSV_DIR/villages.csv > $SCRIPT_DIR/../mysql/$DB_NAME.sql

# rm -rf $TMP_DIR

echo "Testing MySQL dump..."
echo "> Creating database"
mysql -u $DB_USER -h $DB_HOST -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
echo "> Importing database"
mysql -u $DB_USER -h $DB_HOST $DB_NAME < $SCRIPT_DIR/../mysql/$DB_NAME.sql
echo "> Statistics"
mysql -u $DB_USER -h $DB_HOST -t $DB_NAME < $SCRIPT_DIR/statistics.sql

echo "Done."
