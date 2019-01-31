#!/usr/bin/env bash

# bibliographics-report.sh - given a pre-configured SQL file, query the bibliographics database
# usage: ./bin/bibliographics-report.sh

# Eric Lease Morgan <emorgan@nd.edu>
# January 27, 2019 - first cut


# do the work, and done
cat ./etc/bibliographics-report.sql | sqlite3 ./etc/bibliographics.db
exit
