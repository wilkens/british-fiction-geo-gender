#!/usr/bin/env bash

# geo2db.sh - given a pre-configured SQL file, create a database file; a front-end to geo2db.sql
# usage: ./bin/geo2db.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 27, 2019 - first cut


# change to the appropriate directory, do the work, and done
cd ./etc
cat geo2db.sql | sqlite3
exit
