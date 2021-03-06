# Learning the data

This directory contains scripts and supporting files enabling the reader to use &amp; understand three datasets (metadata.csv, geo.tsv, and gender.csv). The contents of this directory is all about learning the data.

The scripts &amp; supporting files fall into three groups. The first group is used to create databases:

  * [`./bin/metadata2db.sh`](./bin/metadata2db.sh) - create an SQLite database (bibliographics.db) from metadata.csv
  * [`./bin/geo2db.sh`](./bin/geo2db.sh) - create an SQLite database (geographics.db) from geo.csv
  * [`./bin/gender2db.sh`](./bin/gender2db.sh) - create an SQLite database (genders.db) from gender.csv

Be forewarned. The .csv/.tsv files must exist in the ./etc directory before the .sh scripts will work. Moreover, the .sh scripts will really only work on Linux/Macintosh computers. With minor tweaking, they can work on Windows-based computers too. (Software is never done, and if it were, then it would be called "hardware".) On the other hand, the problem to solve is not really the creation of the databases as much as understanding of their content, which is the purpose of the second group.

The second group of scripts &amp; supporting files are used to query the databases. Each script is really a front-end to a set of SQL statements directed at a specific database:

  * [`./bin/bibliographics-report.sh`](./bin/bibliographics-report.sh) - learn about the contents of bibliographics.db
  * [`./bin/geographics-report.sh`](./bin/geographics-report.sh) - learn about the contents of geographics.db
  * [`./bin/genders-report.sh`](./bin/genders-report.sh) - learn about the contents of genders.db

To make life easier and to really accomplish the goal of learning the data, each of the scripts' output have been saved to a file. At the very least, students are expected to read each of these files and become familiar with the sorts questions the datasets can answer:

  * [./etc/bibliographics-report.txt](./etc/bibliographics-report.txt)
  * [./etc/geographics-report.txt](./etc/geographics-report.txt)
  * [./etc/genders-report.txt](./etc/genders-report.txt)

After reading the .txt files, readers might want to ask themselves "What else can I learn from any of these databases, especially if I were to combine them with the others?"

To go above &amp; beyond students may want to peruse the SQL files used to do the actual work of creating the .txt files. Learning about SQL can be a good thing:

  * [`./etc/bibliographics-report.sql`](./etc/bibliographics-report.sql)
  * [`./etc/geographics-report.sql`](./etc/geographics-report.sql)
  * [`./etc/genders-report.sql`](./etc/genders-report.sql)

Finally, the databases created here (bibliographics.db, geographics.db, and genders.db) are operating system independent; the databases can be read by any computer with a program called [SQLite](https://www.sqlite.org/). Each of them have been saved in a repository:

  * [bibliographics.db](https://osf.io/smp9b/?view_only=96827ce8db844cb4ab352f07bd5ebad0)
  * [geographics.db](https://osf.io/exv78/?view_only=96827ce8db844cb4ab352f07bd5ebad0)
  * [genders.db](https://osf.io/8zgm3/?view_only=96827ce8db844cb4ab352f07bd5ebad0)

Even if you were not able to create the databases yourself, somebody else was. Consider installing SQLite, obtaining the database files, and using the scripts in this distribution to learn even more.

---
Eric Lease Morgan &lt;emorgan@nd.edu&gt;  
February 4, 2019
