#!/usr/bin/env bash

# make-databases.sh - a front-end to the ./bin/*2db.sh files

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# February 1, 2019 - first cut; brain-dead


echo
echo "Making ./etc/bibliographics.db." >&2
./bin/metadata2db.sh

echo
echo "Making ./etc/geographics.db. (Please be patient.)" >&2
./bin/geo2db.sh

echo
echo "Making ./etc/genders.db. (Please be even more patient.)" >&2
./bin/gender2db.sh
