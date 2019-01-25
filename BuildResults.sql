-- Build the full results table for gender project. Takes a while.
-- /usr/pgsql-9.6/bin/psql -p 5433 -f ./BuildResults.sql research

\timing
SET work_mem = '8GB';

DROP TABLE IF EXISTS gender_intermediate;
DROP TABLE IF EXISTS gender_results;

-- Create intermediate results table from existing London corpora (excluding Hathi)
CREATE TABLE gender_intermediate AS
    SELECT
	t.htid,
	t.text_string,
	t.lang,
	t.occurs,
	b.corpus,
	b.author,
	b.title,
	b.pub_date,
	b.genre,
	b.gender,
	b.white,
	b.origin_area,
	b.origin_nation
FROM
	txtdata_full t, london_corpora_publication b
WHERE
	t.htid = b.htid
    AND b.corpus != 'Hathi'
    ;
    
-- Add data from broad Hathi (not deduplicated)
INSERT INTO gender_intermediate
SELECT
	t.htid,
	t.text_string,
	t.lang,
	t.occurs,
    'Hathi' as corpus,
	b.author,
	b.title,
	b.pub_date,
    'Fiction' as genre,
	b.gender_multi AS gender,
    NULL as white,
    NULL as origin_area,
    NULL as origin_nation
FROM
	txtdata_full t, bib b
WHERE
	t.htid = b.htid
    AND b.pub_date BETWEEN 1800 AND 2010
    AND b.pub_cn = 'GB'
    AND b.fiction > 0.50
    ;

-- Build index on intermediate results
CREATE INDEX ON gender_intermediate USING btree (text_string, lang);

-- Build full results table
CREATE TABLE gender_results AS
SELECT
	i.corpus,
    i.htid,
	i.text_string,
	i.lang,
	i.occurs,
	i.author,
	i.title,
	i.pub_date,
	i.gender,
    i.genre,
    i.white,
    i.origin_area,
    i.origin_nation,
	g.place_id,
	g.formatted_address,
	g.location_type,
	g.country_long,
	g.country_short,
	g.admin_1_long,
	g.admin_1_short,
	g.admin_2,
	g.admin_3,
	g.admin_4,
	g.admin_5,
	g.locality,
	g.sublocality_1,
	g.sublocality_2,
	g.sublocality_3,
	g.neighborhood,
	g.premise,
	g.subpremise,
	g.street_number,
	g.street_address,
	g.route,
	g.post_code,
	g.natural_feature,
	g.point_of_interest,
	g.colloquial_area,
	g.continent,
	g.other,
	g.lat,
	g.lon
FROM
	gender_intermediate i, geo_regular g
WHERE
	(i.text_string, i.lang) = (g.text_string, g.lang) AND
	g.formatted_address IS NOT NULL AND
	g.ignore IS DISTINCT FROM True;

-- Update with handreview data, step 1 of 3
--  london_handreview
UPDATE gender_results r
SET
	place_id = g.place_id,
	formatted_address = g.formatted_address,
	location_type = g.location_type,
	country_long = g.country_long,
	country_short = g.country_short,
	admin_1_long = g.admin_1_long,
	admin_1_short = g.admin_1_short,
	admin_2 = g.admin_2,
	admin_3 = g.admin_3,
	admin_4 = g.admin_4,
	admin_5 = g.admin_5,
	locality = g.locality,
	sublocality_1 = g.sublocality_1,
	sublocality_2 = g.sublocality_2,
	sublocality_3 = g.sublocality_3,
	neighborhood = g.neighborhood,
	premise = g.premise,
	subpremise = g.subpremise,
	street_number = g.street_number,
	street_address = g.street_address,
	route = g.route,
	post_code = g.post_code,
	natural_feature = g.natural_feature,
	point_of_interest = g.point_of_interest,
	colloquial_area = g.colloquial_area,
	continent = g.continent,
	other = g.other,
	lat = g.lat,
	lon = g.lon
FROM
	geo g, london_handreview_regular h
WHERE
	r.text_string = h.text_string AND
	h.alias = True AND
	h.lookup_string = g.text_string AND
	g.lang = 'en' AND
	g.formatted_address IS NOT NULL;

DELETE FROM gender_results r
WHERE
	r.text_string IN
	(SELECT
		h.text_string
	FROM
		london_handreview_regular h
	WHERE
		h.ignore = True);

-- Update with handreview data, step 2 of 3
--  woolf_handreview
UPDATE gender_results r
SET
	place_id = g.place_id,
	formatted_address = g.formatted_address,
	location_type = g.location_type,
	country_long = g.country_long,
	country_short = g.country_short,
	admin_1_long = g.admin_1_long,
	admin_1_short = g.admin_1_short,
	admin_2 = g.admin_2,
	admin_3 = g.admin_3,
	admin_4 = g.admin_4,
	admin_5 = g.admin_5,
	locality = g.locality,
	sublocality_1 = g.sublocality_1,
	sublocality_2 = g.sublocality_2,
	sublocality_3 = g.sublocality_3,
	neighborhood = g.neighborhood,
	premise = g.premise,
	subpremise = g.subpremise,
	street_number = g.street_number,
	street_address = g.street_address,
	route = g.route,
	post_code = g.post_code,
	natural_feature = g.natural_feature,
	point_of_interest = g.point_of_interest,
	colloquial_area = g.colloquial_area,
	continent = g.continent,
	other = g.other,
	lat = g.lat,
	lon = g.lon
FROM
	geo g, woolf_handreview_regular h
WHERE
	r.text_string = h.text_string AND
	h.lookup IS NOT NULL AND
	h.lookup = g.text_string AND
	g.lang = 'en' AND
	g.formatted_address IS NOT NULL;

DELETE FROM gender_results r
WHERE
	r.text_string IN
	(SELECT
		h.text_string
	FROM
		woolf_handreview_regular h
	WHERE
		h.ignore_all = True);

-- Special case Woolf's work
DELETE FROM gender_results r
WHERE
	r.author = 'Woolf, Virginia' AND
	r.text_string IN
	(SELECT
		h.text_string
	FROM
		woolf_handreview_regular h
	WHERE
		h.ignore_woolf = True);

-- Update with handreview data, step 3 of 3
--  london_handreview_byvol
UPDATE gender_results r
SET
	place_id = g.place_id,
	formatted_address = g.formatted_address,
	location_type = g.location_type,
	country_long = g.country_long,
	country_short = g.country_short,
	admin_1_long = g.admin_1_long,
	admin_1_short = g.admin_1_short,
	admin_2 = g.admin_2,
	admin_3 = g.admin_3,
	admin_4 = g.admin_4,
	admin_5 = g.admin_5,
	locality = g.locality,
	sublocality_1 = g.sublocality_1,
	sublocality_2 = g.sublocality_2,
	sublocality_3 = g.sublocality_3,
	neighborhood = g.neighborhood,
	premise = g.premise,
	subpremise = g.subpremise,
	street_number = g.street_number,
	street_address = g.street_address,
	route = g.route,
	post_code = g.post_code,
	natural_feature = g.natural_feature,
	point_of_interest = g.point_of_interest,
	colloquial_area = g.colloquial_area,
	continent = g.continent,
	other = g.other,
	lat = g.lat,
	lon = g.lon
FROM
	geo g, london_handreview_byvol_regular h
WHERE
	r.text_string = h.text_string AND
	h.alias_to IS NOT NULL AND
	h.alias_to = g.text_string AND
	g.lang = 'en' AND
	g.formatted_address IS NOT NULL;

DELETE FROM gender_results r
USING
	london_handreview_byvol_regular h
WHERE
	r.text_string = h.text_string AND
	r.htid = h.htid AND
	h.alias_to IS NULL;

-- Add wordcount data
ALTER TABLE gender_results ADD wordcount integer;
UPDATE
	gender_results r
SET
	wordcount = w.wordcount
FROM
	wordcounts w
WHERE
	r.htid = w.htid AND
	w.wordcount > 0;
DELETE FROM gender_results
WHERE wordcount IS NULL;

-- Build indices on full results table
CREATE INDEX ON gender_results (pub_date);
CREATE INDEX ON gender_results (corpus);
CREATE INDEX ON gender_results (genre);
CREATE INDEX ON gender_results (white);
CREATE INDEX ON gender_results (origin_area);
CREATE INDEX ON gender_results (origin_nation);
CREATE INDEX ON gender_results (country_short);
CREATE INDEX ON gender_results (admin_1_short);
CREATE INDEX ON gender_results (locality);
CREATE INDEX ON gender_results (lat);
CREATE INDEX ON gender_results (lon);
CREATE INDEX ON gender_results (country_long);
CREATE INDEX ON gender_results (admin_1_long);
CREATE INDEX ON gender_results (formatted_address);
CREATE INDEX ON gender_results (text_string);
CREATE INDEX ON gender_results (htid);
VACUUM ANALYZE london_results_full_publication;
