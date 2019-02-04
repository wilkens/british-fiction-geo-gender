# Cleaning &amp; normalizing data

Cleaning &amp; normalizing data is sometimes a necessary process done before truthful research observations can be made.

First of all, this author rarely actually uses the word "clean" to describe data because its opposite ("dirty") has unnecessary negative connotations. A better word might be "normalize" because the goal is to reduce ambiguity &amp; increase accuracy. 

Unnormalized data falls into three or four categories:

  * null - data with no values
  * incorrect - data whose values are untruthful
  * inconsistent - data whose values are manifested in multiple ways

## Null data

In the given data set, there are many examples of null data. For example, in the bibliographics (metadata) file, as many as 5800 records have no author value:

| count  | author          | 
|--------|-----------------|
| 5867   |                 |
| 203    | Scott, Walter,  |
| 192    | Conrad, Joseph, |
| 161    | James, G. P. R. |
| 156    | Oliphant,       |

This is simply not true because everything was written by someone. On the other hand, the values for each of the "unauthored" works are probably unknown. Filling in the blanks is often a tedious process requiring both subject-matter expertise &amp; thorough investigation. Similarly, the geographics (geo) data set lists many works with no genders:

| count   | gender        | 
|---------|---------------|
| 2774708 | male          |
| 651403  | female        |
| 506733  | unknown       |
| 286653  |               |
| 69478   | mostly female |
| 37489   | mostly male   |
| 7242    | androg        |

In both of these cases, reducing ambiguity &amp; increasing accuracy -- normalizing -- is very expensive, although a machine learning process called classification can be employed. Classification is beyond the scope of this particular section and will be discussed later.

Sometimes data simply has no value, take the case of 


---  
Eric Lease Morgan &lt;emorgan@nd.edu&gt;   
February 4, 2019