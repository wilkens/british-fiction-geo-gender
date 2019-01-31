#!/usr/bin/env bash

# metadata2db.sh - given a pre-configured SQL file, create a database file; a front-end to metadata2db.sql
# usage: ./bin/metadata2db.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 27, 2019 - first cut


# change to the appropriate directory, do the work, and done
cd ./etc
cat metadata2db.sql | sqlite3
exit
