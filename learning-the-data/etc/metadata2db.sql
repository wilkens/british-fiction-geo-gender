-- metadata2db.sql - read a specific CSV file and save it as an SQLite database file

-- Eric Lease Morgan <emorgan@nd.edu>
-- January 27, 2019 - first cut; ought to work for any operating system; "famous last words"


-- work in CSV mode
.mode csv

-- import the desired file and give the resulting table a cool name
.import metadata.csv bibliographics

-- echo the database's structure
.schema

-- save & done
.save bibliographics.db
.exit
