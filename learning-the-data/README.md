# Learning the data

This directory contains scripts and supporting files used to get to know the three datasets in question: metadata.csv, geo.tsv, and gender.csv. As of right now, there are only four scripts:

  * ./bin/metadata2db.sh - create an SQLite database (bibliographics.db) from metadata.csv
  * ./bin/geo2db.sh - create an SQLite database (geographics.db) from geo.csv
  * ./bin/gender2db.sh - create an SQLite database (genders.db) from gender.csv
  * ./bin/bibliographics-report.sh - use SQL to report on the contents of bibliographics.db

---
Eric Lease Morgan &lt;emorgan@nd.edu&gt;  
January 28, 2019
