# Cleaning &amp; normalizing data

Cleaning &amp; normalizing data is sometimes a necessary process done before truthful research observations can be made.

First of all, this author rarely actually uses the word "clean" to describe data because its opposite ("dirty") has unnecessary negative connotations. A better word might be "normalize" because the goal of normalizing is to reduce ambiguity &amp; increase accuracy. 

Unnormalized data falls into three categories:

  * null - data with no values
  * inconsistent - data whose values are manifested in multiple ways
  * incorrect - data whose values are untruthful

Below, each category is described in greater detail.


## Null data

In the given data set, there are many examples of null data. For example, in the bibliographics (metadata) file, as many as 5800 records have no author value:

| count  | author          | 
|--------|-----------------|
| 5867   |                 |
| 203    | Scott, Walter,  |
| 192    | Conrad, Joseph, |
| 161    | James, G. P. R. |
| 156    | Oliphant,       |

This is simply not true because everything was written by someone. On the other hand, the values for each of the "unauthored" works are probably unknown. Filling in the blanks is often a tedious process requiring both subject-matter expertise &amp; thorough investigations. Similarly, the geographics (geo) data set lists many works with no over-all gender:

| count   | gender        | 
|---------|---------------|
| 2774708 | male          |
| 651403  | female        |
| 506733  | unknown       |
| 286653  |               |
| 69478   | mostly female |
| 37489   | mostly male   |
| 7242    | androg        |

In both of these cases, reducing ambiguity &amp; increasing accuracy -- normalizing -- is very expensive, although a machine learning process called classification could be employed. Classification is beyond the scope of this particular document and will be discussed later.

Sometimes data simply has no value. Take the case of alluded to nations in the geographics dataset. More than 4 million records do not allude to a nation, but such is perfectly plausible:

| count   | nation            | 
|---------|-------------------|
|4242604  |                   |
|43113    | England           |
|14956    | Britain - England | 
|5734     | India             | 
|3596     | South Africa      | 
|2718     | Scotland          | 


## Inconsistent data

Inconsistent data are strings ("words") &amp; numbers whose values are represented in any number of different ways. An easy-to-understand example is the representation of G.P.R. James's name in the bibliographics dataset. After counting &amp; tabulating the frequency of "James, G. P. R", we can see there are at least three different versions of their name:

| count | name                                      | 
|-------|-------------------------------------------|
| 161   | James, G. P. R.                           |
| 2     | James, G. P. R. (George Payne Rainsford), |
| 1     | James, G. P. R.,                          |

The values for James's name ought to be normalized into something like "James, G. P. R.".

The inverted nature of personal names brings up another point -- sorting. Presenting the names from the bibliographics data set in a sorted order is trivial, especially if you desire to have them sorted by last name. Bibliographic titles are another story. (No puns intended.) Counting &amp; tabulating the list of titles illustrates the problem:

| count | title                                | 
|-------|--------------------------------------|
| 66    | Works.                               |
| 51    | Works                                |
| 47    | The New British novelist;            |
| 45    | The Shakespeare Head edition of...   |
| 45    | The Waverley novels                  |
| 43    | The works of H. G. Wells.            |
| 35    | Men of good will / \| $c: by Jules... |
| 34    | [Works]                              |

All sorts of normalizing (every pun intended) can be done here, but they can all be boiled down to a single solution -- the creation of new data field possibly called "sort title". The values in this new field would have no leading articles ("a", "the", nor "an") and no punctuation. All the letters would be lower-cased, and all of the values would be stripped of extraneous information (like "/ | $c: by Jules"). To put it another way, the original title values could be "display titles", and the new field would be used for internal purposes. Of all the data in these data sets, the title values are the closest to "dirty", and the reasons they exist this way are rooted in the the lore of library cataloging practice.

In the geographics dataset, the "whiteness" of a work is described in four different ways: 1) null, 2) white, 3) Nonwhite, and 4) White. What is the difference between "white" &amp; "White"? Moreover, it might be a good idea to change the null values to something like "unknown":

| count   | "whiteness" | 
|---------|-------------|
| 4258928 |             |
| 55838   | white       |
| 13444   | Nonwhite    |
| 5496    | White       |

Birth dates in the bibliographics database exhibit similar challenges:

| count   | birth date | 
|---------|------------|
| 32369   |            |
| 1109    | 1964.0     |
| 1084    | 1957.0     |
| 1073    | 1966.0     |
| 1068    | 1965.0     |

Everybody was born in some year, but none of those years equal "1957.0". Sure, you, as an intelligent person, understand what the data is communicating, but computers are really stupid, and they need to be given things that are as unambiguous as possible. In this case, the null values might be changed to 0, and the ".0" could be removed from all birth date values.

If used in isolation, the genders dataset is well-normalized. There are few null values, and the data intended to be used to answer research questions is well-formed. On the other hand, the key/identifier ("docid") values are exhibited in a number of different shapes. Some of them are integers. Some of them are HathiTrust identifiers (such as "dul1.ark+=13960=t9f48pv82). Some of them (very few) appear to be comma-delimited values. Again, none of these things are issues if the genders data is used in &amp; of itself. On the other hand, if a research question were asked of the genders data, and then the researcher wanted to "join" the genders data with bibliographic or geographic information, then the joining process would be difficult because the keys in the genders data does not match the keys in the other data sets. This is a case where values need to be consistent between data sets.


## Incorrect data

Normalizing incorrect data -- data whose values are false -- is the most difficult. How is one to know the correct value is "white" when the value is labeled as "black"? How is one to know the author was born in 1960 and not 1961? Much of the data in these data sets was programmatically generated. The data was created through the use of machine learning models. Few people looked at the data and determined its over-all gender. Place names similar to "East London" were programmatically normalized to "London, UK". The only way to normalize ("correct") these sorts of things is to modify the original computer model(s), re-run the underlying applications, and re-generate the data. 

Normalizing incorrect data is often a matter of belief. To what degree do you trust the data is correct? To what degree do you believe the data was created with rigor? Exactly as in the world of printed books, there is an authority factor, and one has to have a certain faith the book is the most up-to-date &amp; correct. The same is true for data sets.


## "To normalize or not to normalize, that is the question"

Our world is not perfect. Nor is our data, and one needs to answer the question, "How good is good enough?" When a data set has millions of records, and a few of them (say, 1000) have incorrect values, then the error rate is minuscule. The time &amp; effort needed to correct the values is probably not worth the precision gained from the observations. This is why unnormalized OCR (optical character recognition) is often good enough when doing text mining &amp; natural language processing. The goal is often to articulate broad generalizations concerning a large corpora. "Literature of the 18th Century exhibits these characteristics... The complete works of Mr. X &amp; Ms Y ebbed &amp; flowed between this, that, and the other thing... Over time, the descriptions of men &amp; women have evolved, and these descriptions can be exhibited in the following ways..." 

Deciding whether or not to normalize one's data is often a judgment call based on time, energy, ability and the desire for perfection. But remember, "Don't let the perfect be the enemy of the good."


## How to normalize

If you have gotten this far, then you may be asking yourself, "Okay, but how do I do the work?" Like many other things, it depends. It depends on the types of normalization you desire and the way the data is manifested.

Data with null values probably needs to be given values, especially if values exist. Determining these values can often be done manually or programmatically. A work can be read and re-read by an expert to determine its overall tone, and the tone can then be set in the data. Alternatively, a computer "model" can be created based on previously existing labeled data. New or unknown works can then be compared to the model, and a value can be generated whose certainty ranges from 0 to 1, where 0 represents no certainty, and 1 represents 100% certainty. Creating "models" is beyond the scope of this essay.

Like above, normalizing inconsistently formatted data can be done manually or programmatically. Through simple observation a person can see how James's name might be changed throughout the database to "James, G. P. R." But determining what names to change and how to change them is a daunting task. After all, there are more than 41,000 distinct names in the bibliographics data set. Yikes!

Thanks to decades old algorithms, computers can be used to automate this sort of normalization. A good example is the [Levenshtein algorithm](https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance). Levenshtein calculates a "editing" distance between two strings and then compares those distances to determine a "correct" value. If zero typographical edits exist between two strings, then the strings are considered equal. If one typographical edit exists between two strings, then the strings are deemed further "apart". After many strings are compared to many other strings, it is possible to group the distances and determine which string is correct. Levenshtein was a Soviet mathematician who articulated the algorithm in 1965. The algorithm has been implemented in at least three dozen programming languages. [1]

Once you have articulated the need to so some normalization, and after you have decided what values you want to change, you then need to do the actual editing. The way one does this work depends on the format of the data. If the data is in some delimited format (such as comma-separated values or tab-delimited values), and if the data is less than a few hundred rows long and a few dozen columns wide, then it is usually feasible to use something like a spreadsheet application to read, edit, and re-save the data. If the data is in a delimited format, but the data is larger than a few hundred rows or a few dozen columns, then using some sort of database or programming language is in order. If the data is formatted in something like an extensible mark-up language (XML) file or Javascript Object Notation (JSON) file, then the editing process will most definitely be through a programming language, and just about any one (Python, R, Perl, C, etc.) will do.

In this particular case, the datasets have been saved in a database format called [SQLite](https://sqlite.org/). [2] SQLite is a small, cross-platform, and robust relational database application. SQLite implements a standards-compliant dialect of the Structured Query Langauge (SQL). Using SQL it is almost trivial to find/replace values in a database table. For example, after installing SQLite and using it to open bibliographics.db, the following statement can be used to normalize an author name:

`UPDATE bibliographics SET author = 'James, G. P. R.' WHERE author LIKE '%James, G. P. R%';`

Similarly, if you wanted to normalize the values of white across the geographics database, then you would: 1) use SQLite to open geographics.db and then 2) issue the following two statements:

`UPDATE geographics SET white = 'white' WHERE white = 'White';`   
`UPDATE geographics SET white = 'unknown' WHERE white = '';`
   
SQL works with surgical precision, but you might need a kinder, gentler tool.

[OpenRefine](http://openrefine.org) is an alternative to spreadsheets or database applications. [3] It was originally created at Google and subsequently released as open source software. Its primary purpurpose is to read delimited data, enable a person to search &amp; browse the data, manually as well as programmatically normalize it, and save the result. OpenRefine is made for exactly the sorts of things needed here, but it is not really able to open the whole of the bibliographics, geographics, nor genders datasets. The data sets are too large.

On the other hand, it is quite possible you will not be needing the whole of each dataset. Instead, your research question maybe limited to a set of gives years, locations, genders, etc. If this is the case, then one need to extract a subset of the data from the whole data, possibly normalize it, and then do the analysis. As an example, four datasets have been created for you: 1) [london.csv](./london.csv), 2) [paris.csv](./paris.csv), 3) [new-york.csv](./new-york.csv), and 4) [rome.csv](./rome.csv). Each of these subsets was created using SQLite and the following commands:

`.mode csv`   
`.headers on`   
`.output london.csv`   
`SELECT * FROM geographics`   
`WHERE formatted_address IS 'London, UK'`  
`AND ( pub_date > 1849 AND pub_date < 1900 ) AND author > '';`

In other words, create a comma-separated file named london.csv, and include everything in the file where the address is London and published in the last half of the 19th Century and has an author value.

Each of the resulting files are small enough to be imported into a spreadsheet, but instead, open them up in OpenRefine. Use OpenRefine's 

## Links

[1] Levenshtein algorithm - https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance   
[2] SQLite - https://sqlite.org/  
[3] OpenRefine - http://openrefine.org/



---  
Eric Lease Morgan &lt;emorgan@nd.edu&gt;   
February 7, 2019