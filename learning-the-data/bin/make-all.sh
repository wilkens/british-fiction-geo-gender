#!/usr/bin/env bash

# make-all.sh - a front-end to the other make-*.sh scripts

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# February 1, 2019 - first cut; brain-dead

# do the work
./bin/make-databases.sh
./bin/make-reports.sh
