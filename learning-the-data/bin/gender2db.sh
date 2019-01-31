#!/usr/bin/env bash

# gender2db.sh - given a pre-configured SQL file, create a database file; a front-end to gender2db.sql
# usage: ./bin/gender2db.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 27, 2019 - first cut


# change to the appropriate directory, do the work, and done
cd ./etc
cat gender2db.sql | sqlite3
exit
