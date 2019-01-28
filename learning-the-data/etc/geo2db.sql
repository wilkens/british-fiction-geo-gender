-- geo2db.sql - read a specific TSV file and save it as an SQLite database file

-- Eric Lease Morgan <emorgan@nd.edu>
-- January 27, 2019 - first cut; ought to work for any operating system; "famous last words"


-- work in tab-delimited mode
.mode tabs

-- import the desired file and give the resulting table a cool name
.import geo.tsv geographics

-- echo the database's structure
.schema

-- save & done
.save geographics.db
.exit
