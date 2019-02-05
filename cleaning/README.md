# Cleaning &amp; normalizing data

Cleaning &amp; normalizing data is sometimes a necessary process done before truthful research observations can be made.

First of all, this author rarely actually uses the word "clean" to describe data because its opposite ("dirty") has unnecessary negative connotations. A better word might be "normalize" because the goal of normalizing is to reduce ambiguity &amp; increase accuracy. 

Unnormalized data falls into three categories:

  * null - data with no values
  * inconsistent - data whose values are manifested in multiple ways
  * incorrect - data whose values are untruthful

Each category is described in greater detail below.


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

Normalizing incorrect data -- data whose values are false -- is the most difficult. How is one to know the correct value is "white" when the value is labeled as "black"? How is one to know the author was born in 1960 and not 1961? Much of the data in these data sets was programmatically generated. The data was created through the use of machine learning models. Few people looked at the data and determined its over-all gender. Place names similar to "East London" were programmatically normalized to "London, UK". The only way to normalize ("corr ect") these sorts of things is to modify the original computer model(s), re-run the underlying applications, and re-generate the data. 

Normalizing incorrect data is often a matter of belief. To what degree do you trust the data is correct? To what degree do you believe the data was created with rigor? Exactly as in the world of printed books, there is an authority factor, and one has to have a certain faith the book is the most up-to-date &amp; correct. The same is true for data sets.

## "To normalize or not to normalize, that is the question"

Our world is not perfect. Nor is our data, and one needs to answer the question, "How good is good enough?" When a data set has millions of records, and a few of them (say, 1000) have incorrect values, then the error rate is minuscule. The time &amp; effort needed to correct the values is probably not worth the precision gained from the observations. This is why unnormalized OCR (optical character recognition) is often good enough when doing text mining &amp; natural language processing. The goal is often to articulate broad generalizations concerning a large corpora. "Literature of the 18th Century exhibits these characteristics... The complete works of Mr. X &amp; Ms Y ebbed &amp; flowed between this, that, and the other thing... Over time, the descriptions of men &amp; women have evolved, and these descriptions can be exhibited in the following manner..."


In short, "Don't let the perfect be the enemy of the good."

---  
Eric Lease Morgan &lt;emorgan@nd.edu&gt;   
February 5, 2019