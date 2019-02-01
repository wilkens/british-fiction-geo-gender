#!/usr/bin/env bash

# make-reports.sh - a front-end to the ./bin/*-report.sh files

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# February 1, 2019 - first cut; brain-dead


echo "Making ./etc/bibliographics-report.txt." >&2
./bin/bibliographics-report.sh > ./etc/bibliographics-report.txt

echo "Making ./etc/geographics-report.txt. (Please be patient.)" >&2
./bin/geographics-report.sh > ./etc/geographics-report.txt

echo "Making ./etc/genders-report.txt." >&2
./bin/genders-report.sh > ./etc/genders-report.txt

