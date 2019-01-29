-- geographics-report.sql - a set of SQL queries used to get a feel for the geographics database

-- Eric Lease Morgan <emorgan@nd.edu>
-- January 28, 2019 - first investigations


-- turn on tabs mode, just to make things pretty
.mode tabs


--
-- introduction
--

-- output some narrative
SELECT '';
SELECT "Geographics reports";
SELECT "======================";
SELECT '  This is a small set of reports applied against the geographics';
SELECT '  database. Their primary purpose is two-fold: 1) to give the reader';
SELECT '  an idea of what is in the database, and 2) give the reader a set';
SELECT '  of sample SQL statements for study & use. --Eric Lease Morgan';
SELECT '  <emorgan@nd.edu>, January 28, 2019.';
SELECT '';

-- echo the database's structure
SELECT "List the database's structure";
SELECT "-----------------------------";
.schema
SELECT '';

SELECT "Number of records (HathiTrust identifiers) in the database";
SELECT "----------------------------------------------------------";
SELECT COUNT( htid ) FROM geographics;
SELECT '';

SELECT "Number of distinct HathiTrust identifiers in the database";
SELECT "---------------------------------------------------------";
SELECT COUNT( DISTINCT( htid ) ) FROM geographics;
SELECT '';

SELECT "Number of mentioned of places in the whole corpus";
SELECT "-------------------------------------------------";
SELECT SUM( occurs ) FROM geographics;
SELECT '';

SELECT "Roughly speaking, the number of mentioned places per document";
SELECT "-------------------------------------------------------------";
SELECT SUM( occurs ) / COUNT( DISTINCT( htid ) ) FROM geographics;
SELECT '';

SELECT "Count & tabulate the 50 most frequently alluded to location types";
SELECT "-----------------------------------------------------------------";
SELECT COUNT( location_type ) AS c, location_type FROM geographics GROUP BY location_type ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently used place names";
SELECT "--------------------------------------------------------";
SELECT COUNT( formatted_address ) AS c, formatted_address FROM geographics GROUP BY formatted_address ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently alluded to nations";
SELECT "----------------------------------------------------------";
SELECT COUNT( origin_nation ) AS c, origin_nation FROM geographics GROUP BY origin_nation ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently alluded to countries";
SELECT "------------------------------------------------------------";
SELECT COUNT( country_long ) AS c, country_long FROM geographics GROUP BY country_long ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently alluded to natural features";
SELECT "-------------------------------------------------------------------";
SELECT COUNT( natural_feature ) AS c, natural_feature FROM geographics GROUP BY natural_feature ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently alluded to points of interest";
SELECT "---------------------------------------------------------------------";
SELECT COUNT( point_of_interest ) AS c, point_of_interest FROM geographics GROUP BY point_of_interest ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the genres";
SELECT "---------------------------";
SELECT COUNT( genre ) AS c, genre FROM geographics GROUP BY genre ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the genders";
SELECT "----------------------------";
SELECT COUNT( gender ) AS c, gender FROM geographics GROUP BY gender ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 'whiteness' of the corpus";
SELECT "----------------------------------------------";
SELECT COUNT( white ) AS c, white FROM geographics GROUP BY white ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 publication dates";
SELECT "-----------------------------------------";
SELECT COUNT( pub_date ) AS c, pub_date FROM geographics GROUP BY pub_date ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently mentioned premise";
SELECT "---------------------------------------------------------";
SELECT COUNT( premise ) AS c, premise FROM geographics GROUP BY premise ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently mentioned museums or libraries";
SELECT "----------------------------------------------------------------------";
SELECT COUNT( formatted_address ) AS c, formatted_address FROM geographics
WHERE location_type IS 'library' OR location_type IS 'museum'
GROUP BY formatted_address ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently mentioned cities along with their coordinates";
SELECT "-------------------------------------------------------------------------------------";
SELECT COUNT( formatted_address ) AS c, formatted_address || ' (' || lat || ' : ' || lon || ')' FROM geographics
WHERE location_type IS 'locality' GROUP BY formatted_address ORDER BY c DESC LIMIT 50;
SELECT '';

SELECT "Count & tabulate the 50 most frequently mentioned museums or libraries in London";
SELECT "--------------------------------------------------------------------------------";
SELECT COUNT( formatted_address ) AS c, formatted_address FROM geographics
WHERE locality IS 'London' AND ( location_type IS 'museum' OR location_type IS 'library' )
GROUP BY formatted_address ORDER BY c DESC LIMIT 50;
SELECT '';

