#!/usr/bin/env bash

# gender2db.sh - given a pre-configured SQL file, create a database file; a front-end to gender2db.sql
# usage: ./bin/gender2db.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 27, 2019 - first cut
# February 1, 2019 - using normalized data


# re-initialize, do the work, and done
rm ./etc/genders.db
cat ./etc/genders.sql | sqlite3 ./etc/genders.db
exit
