#!/usr/bin/env bash

# genders-report.sh - given a pre-configured SQL file, query the genders database
# usage: ./bin/genders-report.sh

# Eric Lease Morgan <emorgan@nd.edu>
# February 1, 2019 - first cut


# do the work, and done
cat ./etc/genders-report.sql | sqlite3 ./etc/genders.db
exit
