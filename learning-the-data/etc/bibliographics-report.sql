-- bibliographics-report.sql - a set of SQL queries used to get a feel for the bibliographics database

-- Eric Lease Morgan <emorgan@nd.edu>
-- January 27, 2019 - first investigations


-- turn on tabs mode, just to make things pretty
.mode tabs


--
-- introduction
--

-- output some narrative
SELECT '';
SELECT "Bibliographic reports";
SELECT "======================";
SELECT '  This is a small set of reports applied against the bibliographics';
SELECT '  database. Their primary purpose is two-fold: 1) to give the reader';
SELECT '  an idea of what is in the database, and 2) give the reader a set';
SELECT '  of sample SQL statements for study & use. --Eric Lease Morgan';
SELECT '  <emorgan@nd.edu>, January 27, 2019.';
SELECT '';

-- echo the database's structure
SELECT "List the database's structure";
SELECT "-----------------------------";
.schema
SELECT '';

-- count the number of records
SELECT "Number of records in the database";
SELECT "---------------------------------";
SELECT COUNT( docid ) FROM bibliographics;
SELECT '';


--
-- about authors
--

-- number of unique author values
SELECT "Number of distict author values (names)";
SELECT "---------------------------------------";
SELECT COUNT( DISTINCT( author ) ) FROM bibliographics;
SELECT '';

-- count & tabulate authors, but list only top 50
SELECT "Counts & tabulations of the 50 most frequent author names";
SELECT "---------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics GROUP BY author ORDER BY c DESC LIMIT 50;
SELECT '';

-- count & tabulate the various versions of an author's name
SELECT "Counts & tabulations of author names similar to 'Scott, Walter'";
SELECT "---------------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics WHERE author LIKE '%Scott, Walter%' GROUP BY author ORDER BY c DESC;
SELECT '';

-- count & tabulate the various versions of an author's name
SELECT "Counts & tabulations of author names similar to 'James, G. P. R'";
SELECT "----------------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics WHERE author LIKE '%James, G. P. R%' GROUP BY author ORDER BY c DESC;
SELECT '';

-- count & tabulate the various versions of an author's name
SELECT "Counts & tabulations of author names similar to 'Bates, H. E'";
SELECT "-------------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics WHERE author LIKE '%Bates, H. E%' GROUP BY author ORDER BY c DESC;
SELECT '';

-- count & tabulate the various versions of an author's name
SELECT "Counts & tabulations of author names similar to 'Eliot, George'";
SELECT "----------------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics WHERE author LIKE '%Eliot, George%' GROUP BY author ORDER BY c DESC;
SELECT '';

-- count & tabulate the birth dates
SELECT "Counts & tabulations of birth dates";
SELECT "-----------------------------------";
SELECT COUNT( birthdate ) AS c, birthdate FROM bibliographics GROUP BY birthdate ORDER BY c DESC;
SELECT '';

-- count & tabulate the birth dates
SELECT "Counts & tabulations of author genders";
SELECT "--------------------------------------";
SELECT COUNT( authgender ) AS c, authgender FROM bibliographics GROUP BY authgender ORDER BY c DESC;
SELECT '';

-- count & tabulate the birth dates
SELECT "Counts & tabulations of 25 most prolific female authors born before 1800";
SELECT "------------------------------------------------------------------------";
SELECT COUNT( author ) AS c, author FROM bibliographics
WHERE birthdate < '1800' AND authgender IS 'f'
GROUP BY author ORDER BY c DESC LIMIT 25;
SELECT '';


--
-- about titles
--

-- number of unique title values
SELECT "Number of distinct titles";
SELECT "-------------------------";
SELECT COUNT( DISTINCT( title ) ) FROM bibliographics;
SELECT '';

-- count & tabulate titles but list only the top 50
SELECT "Counts & tabulations of the 50 most frequent titles";
SELECT "---------------------------------------------------";
SELECT COUNT( title ) AS c, title FROM bibliographics GROUP BY title ORDER BY c DESC LIMIT 50;
SELECT '';

-- count & tabulate titles but list only the top 50
SELECT "List authors & titles for a given work (Cooper's novels)";
SELECT "---------------------------------------------------";
SELECT author, title, enumcron, inferreddate FROM bibliographics WHERE title IS 'Cooper''s novels'
ORDER BY title, enumcron, inferreddate;
SELECT '';


--
-- about dates
--

-- list all dates
SELECT "All dates (years)";
SELECT "-----------------";
SELECT DISTINCT( inferreddate ) FROM bibliographics ORDER BY inferreddate;
SELECT '';

-- count & tabulate dates
SELECT "Count & tabulate all dates (years)";
SELECT "----------------------------------";
SELECT COUNT( inferreddate ) AS c, inferreddate FROM bibliographics GROUP BY inferreddate ORDER BY c DESC, inferreddate;
SELECT '';


--
-- about identifiers
--

-- list a few hathi trust identifiers
SELECT "List 25 (random) HathiTrust identifiers";
SELECT "---------------------------------------";
SELECT htid from bibliographics order by RANDOM() limit 25;
SELECT '';

SELECT "List 25 random links from the 'Trust items dated prior to 1923";
SELECT "--------------------------------------------------------------";
SELECT '  * http://hdl.handle.net/2027/' || htid
FROM bibliographics
WHERE inferreddate < 1923
ORDER BY RANDOM() LIMIT 25;
SELECT '';

SELECT "Count & tabulate all the items from each library";
SELECT "------------------------------------------------";
select COUNT( SUBSTR( htid, 1, INSTR( htid, '.' ) - 1 ) ) AS c, ( SUBSTR( htid, 1, INSTR( htid, '.' ) - 1 ) ) AS i
FROM bibliographics
GROUP BY i ORDER BY c DESC;
SELECT '';

SELECT "Count & tabulate all the items from each library dated prior to 1923";
SELECT "--------------------------------------------------------------------";
SELECT COUNT( SUBSTR( htid, 1, INSTR( htid, '.' ) - 1 ) ) AS c, ( SUBSTR( htid, 1, INSTR( htid, '.' ) - 1 ) ) AS i
FROM bibliographics
WHERE inferreddate < 1923
GROUP BY i ORDER BY c DESC;
SELECT '';


--
-- create bibliographies
--

-- works by Anthony Trollope
SELECT "A bibliography of Anthony Trollope";
SELECT "----------------------------------";
SELECT "  Number of titles: " || COUNT( title ) AS c FROM bibliographics WHERE author IS 'Trollope, Anthony,';
SELECT '';
SELECT "  * " || title || ' (' || enumcron || ') in ' || inferreddate || ' <http://hdl.handle.net/2027/' || htid || '>'
FROM bibliographics WHERE author IS 'Trollope, Anthony,'
ORDER BY title, enumcron, inferreddate DESC;
SELECT '';

-- public domain works by female authors born in the 18th Century
SELECT "Public domain works by female authors born in the 19th Century";
SELECT "--------------------------------------------------------------";
SELECT "  Number of titles: " || COUNT( title ) AS c FROM bibliographics
WHERE authgender IS 'f' AND ( birthdate > '1799' AND birthdate < '1900' ) AND inferreddate < 1923;
SELECT '';
SELECT "  * " || title || ' by ' || author || ' (' || inferreddate || ') <http://hdl.handle.net/2027/' || htid || '>
'
FROM bibliographics
WHERE authgender IS 'f' AND ( birthdate > '1799' AND birthdate < '1900' ) AND inferreddate < 1923
ORDER BY author, title, inferreddate;
SELECT '';


