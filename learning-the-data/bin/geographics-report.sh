#!/usr/bin/env bash

# geographics-report.sh - given a pre-configured SQL file, query the geographics database
# usage: ./bin/geographics-report.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 28, 2019 - first cut


# do the work, and done
cat ./etc/geographics-report.sql | sqlite3 ./etc/geographics.db
exit
