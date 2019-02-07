
This directory contains some sample data intended to be used for practice with data cleaning and analysis.

Each file is formatted as a CSV file, so it ought to easily importable into just about any database or spreadsheet program. Better yet, consider importing it into 

-- london; 24,130 records
SELECT * FROM geographics
WHERE formatted_address IS 'London, UK'
AND ( pub_date > 1849 AND pub_date < 1900 )
AND author > '';

-- paris; 9453 records
SELECT * FROM geographics
WHERE formatted_address IS 'Paris, France'
AND ( pub_date > 1849 AND pub_date < 1900 )
AND author > '';

-- new york; 5664
SELECT * FROM geographics
WHERE formatted_address IS 'New York, NY, USA'
AND ( pub_date > 1849 AND pub_date < 1900 )
AND author > '';

-- rome; 6642 records
SELECT * FROM geographics
WHERE formatted_address IS 'Rome, Italy'
AND ( pub_date > 1849 AND pub_date < 1900 )
AND author > '';

