-- genders.sql - given hard-coded file names, create & fill a database

-- Eric Lease Morgan <emorgan@nd.edu>
-- (c) University of Notre Dame; distributed under a GNU Public License

-- February 1, 2019 - first cut


-- dates table
CREATE TABLE dates(

	"docid" TEXT,
	"date" TEXT
  
);

-- genders table
CREATE TABLE genders(

	"docid"      TEXT,
	"gender"     TEXT,
	"characters" INTEGER,
	"agent"      INTEGER,
	"mod"        INTEGER,
	"patient"    INTEGER,
	"poss"       INTEGER,
	"speaking"   INTEGER

);

-- import & done
.mode tabs
.import ./etc/gender-dates.tsv dates
.import ./etc/gender-genders.tsv genders
.exit

