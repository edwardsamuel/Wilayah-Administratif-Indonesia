#!/usr/bin/python2

import csv
import sys
import MySQLdb

SPLIT_ROWS = 50


def copy_content(path):
    with open(path, "r") as f:
        print f.read()


def write_footer():
    with open("templates/mysql_footer.sql", "r") as f:
        print f.read()


def csv_to_list(path):
    rows = []
    with open(path, 'rb') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        for row in reader:
            rows.append(row)
    return rows


def write_insert_header(table_name):
    print "--"
    print "-- Dumping data for table `%s`" % (table_name)
    print "--"
    print ""
    print "LOCK TABLES `%s` WRITE;" % (table_name)
    print "/*!40000 ALTER TABLE `%s` DISABLE KEYS */;" % (table_name)


def write_insert_body(table_name, rows):
    counter = 0
    last_row = len(rows) - 1
    for row in rows:
        if (counter % SPLIT_ROWS == 0):
            print "INSERT INTO `%s` VALUES" % (table_name)
        if (counter == last_row or counter % SPLIT_ROWS == SPLIT_ROWS - 1):
            print("  ('%s', '%s', '%s');"
                  % (row[0], row[1], MySQLdb.escape_string(row[2])))
        else:
            print("  ('%s', '%s', '%s'),"
                  % (row[0], row[1], MySQLdb.escape_string(row[2])))
        counter += 1


def write_insert_footer(table_name):
    print "/*!40000 ALTER TABLE `%s` ENABLE KEYS */;" % (table_name)
    print "UNLOCK TABLES;"


def write_provinces(path):
    write_insert_header("provinces")

    counter = 0
    rows = csv_to_list(path)
    last_row = len(rows) - 1
    for row in rows:
        if (counter % SPLIT_ROWS == 0):
            print "INSERT INTO `provinces` VALUES"
        if (counter == last_row or counter % SPLIT_ROWS == SPLIT_ROWS - 1):
            print "  ('%s', '%s');" % (row[0], MySQLdb.escape_string(row[1]))
        else:
            print "  ('%s', '%s')," % (row[0], MySQLdb.escape_string(row[1]))
        counter += 1

    write_insert_footer("provinces")


def write_regencies(path):
    rows = csv_to_list(path)
    write_insert_header("regencies")
    write_insert_body("regencies", rows)
    write_insert_footer("regencies")


def write_districts(path):
    rows = csv_to_list(path)
    write_insert_header("districts")
    write_insert_body("districts", rows)
    write_insert_footer("districts")


def write_villages(path):
    rows = csv_to_list(path)
    write_insert_header("villages")
    write_insert_body("villages", rows)
    write_insert_footer("villages")


def main(argv):
    if (len(argv) > 0):
        copy_content("templates/mysql_header.sql")
        write_provinces(argv[0])
        write_regencies(argv[1])
        write_districts(argv[2])
        write_villages(argv[3])
        print ""
        copy_content("templates/mysql_footer.sql")
    else:
        print("usage: mdf_mysql_converter.py <provinces_csv> "
              "<regencies_csv> <districts_csv> <villages_csv>")
        sys.exit(2)


if __name__ == "__main__":
    main(sys.argv[1:])
