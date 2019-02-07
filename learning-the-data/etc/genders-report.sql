-- genders-report.sql - a set of SQL queries used to get a feel for the genders database

-- Eric Lease Morgan <emorgan@nd.edu>
-- February 1, 2019 - first investigations


-- turn on tabs mode, just to make things pretty
.mode tabs


--
-- introduction
--

-- output some narrative
SELECT '';
SELECT "Gender reports";
SELECT "==============";
SELECT '  This is a small set of reports applied against the genders';
SELECT '  database. Their primary purpose is two-fold: 1) to give the reader';
SELECT '  an idea of what is in the database, and 2) give the reader a set';
SELECT '  of sample SQL statements for study & use. --Eric Lease Morgan';
SELECT '  <emorgan@nd.edu>, February 1, 2019.';
SELECT '';

-- echo the database's structure
SELECT "List the database's structure";
SELECT "-----------------------------";
.schema
SELECT '';

-- count the number of records
SELECT "Number of records in the dates table";
SELECT "------------------------------------";
SELECT COUNT( docid ) FROM dates;
SELECT '';

SELECT "Count & tabulate the 25 most frequent dates (years)";
SELECT "---------------------------------------------------";
SELECT COUNT( date ) AS c, date FROM dates GROUP BY date ORDER BY c DESC LIMIT 25;
SELECT '';

SELECT "Count & tabulate the 25 most frequent years from the 19th century";
SELECT "-----------------------------------------------------------------";
SELECT COUNT( date ) AS c, date FROM dates
WHERE date > 1799 AND date < 1900
GROUP BY date ORDER BY c DESC LIMIT 25;
SELECT '';

SELECT "List all the items from a given year (1802)";
SELECT "-------------------------------------------";
SELECT docid FROM dates WHERE date is 1802 ORDER BY docid ASC;
SELECT '';

SELECT "Number of records in the genders table";
SELECT "--------------------------------------";
SELECT COUNT( docid ) FROM genders;
SELECT '';

SELECT "Number of distinct records in the genders table";
SELECT "-----------------------------------------------";
SELECT COUNT( DISTINCT( docid ) ) FROM genders;
SELECT '';

SELECT "Count & tabulate genders";
SELECT "------------------------";
SELECT '   female  ' || SUM( characters ) FROM genders WHERE gender IS 'f';
SELECT '     male  ' || SUM( characters ) FROM genders WHERE gender IS 'm';
SELECT '  unknown  ' || SUM( characters ) FROM genders WHERE gender IS 'u';
SELECT '';

SELECT "Count & tabulate genders in the 19th Century";
SELECT "--------------------------------------------";
SELECT '   female   ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'f' AND ( d.date > 1799 AND d.date < 1900 ) AND g.docid IS d.docid;
SELECT '     male   ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'm' AND ( d.date > 1799 AND d.date < 1900 ) AND g.docid IS d.docid;
SELECT '  unknown   ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'u' AND ( d.date > 1799 AND d.date < 1900 ) AND g.docid IS d.docid;
SELECT '';

SELECT "Count & tabulate genders in the 20th Century";
SELECT "--------------------------------------------";
SELECT '   female  ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'f' AND ( d.date > 1899 AND d.date < 2000 ) AND g.docid IS d.docid;
SELECT '     male  ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'm' AND ( d.date > 1899 AND d.date < 2000 ) AND g.docid IS d.docid;
SELECT '  unknown  ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'u' AND ( d.date > 1899 AND d.date < 2000 ) AND g.docid IS d.docid;
SELECT '';

SELECT "Count & tabulate genders from a given item (dul1.ark+=13960=t9f48pv82)";
SELECT "----------------------------------------------------------------------";
SELECT '   female        ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'f' AND g.docid IS 'dul1.ark+=13960=t9f48pv82' AND g.docid IS d.docid;
SELECT '     male       ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'm' AND g.docid IS 'dul1.ark+=13960=t9f48pv82' AND g.docid IS d.docid;
SELECT '  unknown        ' || SUM( g.characters ) FROM genders as g, dates as d WHERE g.gender IS 'u' AND g.docid IS 'dul1.ark+=13960=t9f48pv82' AND g.docid IS d.docid;
SELECT '';

SELECT "Comparison of roles between women & men";
SELECT "---------------------------------------";
SELECT '  gender      agent       mod   patient      poss   speaking';
SELECT '   women   ' ||  SUM( agent ) ||  '   '  ||  SUM( mod ) ||  '  '  ||  SUM( patient ) ||  '  '  ||  SUM( poss ) ||  '  '  || SUM( speaking ) FROM genders WHERE gender IS 'f';
SELECT '     men  ' ||  SUM( agent ) || '  ' ||  SUM( mod ) || '  ' ||  SUM( patient ) || '  ' ||  SUM( poss ) || '  ' || SUM( speaking ) FROM genders WHERE gender IS 'm';
SELECT '';

SELECT "Comparison of roles between women & men in the 19th Century";
SELECT "-----------------------------------------------------------";
SELECT '  gender      agent       mod   patient      poss   speaking';
SELECT '   women    ' ||  SUM( g.agent ) ||  '    '  ||  SUM( g.mod ) ||  '   '  ||  SUM( g.patient ) ||  '   '  ||  SUM( g.poss ) ||  '   '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'f' AND ( d.date > 1799 AND d.date < 1900 ) AND g.docid IS d.docid;
SELECT '     men   ' ||  SUM( g.agent ) ||  '   '  ||  SUM( g.mod ) ||  '   '  ||  SUM( g.patient ) ||  '   '  ||  SUM( g.poss ) ||  '   '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'm' AND ( d.date > 1799 AND d.date < 1900 ) AND g.docid IS d.docid;
SELECT '';

SELECT "Comparison of roles between women & men in the 20th Century";
SELECT "-----------------------------------------------------------";
SELECT '  gender      agent       mod   patient      poss   speaking';
SELECT '   women   ' ||  SUM( g.agent ) ||  '   '  ||  SUM( g.mod ) ||  '  '  ||  SUM( g.patient ) ||  '  '  ||  SUM( g.poss ) ||  '  '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'f' AND ( d.date > 1899 AND d.date < 2000 ) AND g.docid IS d.docid;
SELECT '     men  ' ||  SUM( g.agent ) ||  '   '  ||  SUM( g.mod ) ||  '  '  ||  SUM( g.patient ) ||  '  '  ||  SUM( g.poss ) ||  '  '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'm' AND ( d.date > 1899 AND d.date < 2000 ) AND g.docid IS d.docid;
SELECT '';

SELECT "Comparison of roles between women & men in a given item (dul1.ark+=13960=t9f48pv82)";
SELECT "-----------------------------------------------------------------------------------";
SELECT '  gender      agent       mod   patient      poss   speaking';
SELECT '   women         ' ||  SUM( g.agent ) ||  '         '  ||  SUM( g.mod ) ||  '        '  ||  SUM( g.patient ) ||  '        '  ||  SUM( g.poss ) ||  '          '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'f' AND g.docid IS 'dul1.ark+=13960=t9f48pv82' AND g.docid IS d.docid;
SELECT '     men        ' ||  SUM( g.agent ) ||  '        '  ||  SUM( g.mod ) ||  '       '  ||  SUM( g.patient ) ||  '       '  ||  SUM( g.poss ) ||  '        '  || SUM( g.speaking ) FROM genders AS g, dates AS d
WHERE g.gender IS 'm' AND g.docid IS 'dul1.ark+=13960=t9f48pv82' AND g.docid IS d.docid;
SELECT '';

