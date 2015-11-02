#!/bin/sh

DB_NAME=indonesia
DB_USER=root
DB_PASS=root

TMP_DIR='/tmp/indonesia'
PWD_DIR=$PWD

if [ ! -d $TMP_DIR ]; then
	mkdir -p $TMP_DIR
fi

for key in 'a' 'i' 'u' 'e' 'o'; do
	echo "Fetching ${key}"
	if [ ! -f "$TMP_DIR/$DB_NAME-$key.html" ]; then
		curl http://mfdonline.bps.go.id/index.php?link=hasil_pencarian --data "pilihcari=desa&kata_kunci=${key}" > $TMP_DIR/$DB_NAME-$key.html
	fi

	echo "Parsing ${key}"
	./parse.py $TMP_DIR $DB_NAME-$key.html $key
done
unset key

# mysql -u $DB_USER --password=$DB_PASS $DB_NAME < base_db.sql
mysql $DB_NAME < base_db.sql

for area in 'provinces' 'regencies' 'districts' 'villages'; do
	echo "Combining ${area}"
	cat $TMP_DIR/$area-*.csv | sort | uniq > ../csv/$area.csv

	echo "Importing ${area}"
	mysqlimport --fields-terminated-by=, --lines-terminated-by="\r\n" -L $DB_NAME ../csv/$area.csv
done

# mysqldump -u $DB_USER --password=$DB_PASS $DB_NAME > ../mysql/$DB_NAME.sql
mysqldump $DB_NAME > ../mysql/$DB_NAME.sql

rm -rf $TMP_DIR
