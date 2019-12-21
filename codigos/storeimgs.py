#!/usr/bin/python3
# -*- coding: utf-8 -*-

import csv, sys, subprocess

conn_params = {'HOST':'localhost'}

def usage(argv):
	print("Usage:\n%s <csvfile>\n\tcsvfile - a csv file exported from img_file table with pgadmin" % argv[0])

def main(argv):
	with open(argv[1]) as csv_file:
		csv_reader = csv.DictReader(csv_file, delimiter=',')
		for row in csv_reader:
			raster2pgsql_ps = subprocess.Popen([
				'raster2pgsql', '-c', '-M', '-t', "auto",
				row['filepath_'],
				'img.%s' % (row['tablename_'])
			], stdout=subprocess.PIPE)

			# Connection made using conninfo parameters
			# http://www.postgresql.org/docs/9.0/static/libpq-connect.html
			psql_ps = subprocess.check_output([
				'psql',
				'password={PASSWORD} dbname={NAME} user={USER} host={HOST}'.format(**conn_params),
			], stdin=raster2pgsql_ps.stdout)
	return 0

if __name__ == '__main__':
	if len(sys.argv) != 2:
		usage(sys.argv)
		sys.exit()
	from getpass import getpass
	conn_params['NAME'] = input("Database:")
	conn_params['USER'] = input("User:")
	conn_params['PASSWORD'] = getpass()
	sys.exit(main(sys.argv))