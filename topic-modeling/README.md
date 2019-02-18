

# Topic modeling

This is a short tutorial on the topic of... topic modeling.


## Introduction

Succinctly put, topic modeling is an unsupervised machine learning process used to enumerate the themes in a textual corpus.

Let's unpack that definition. Machine learning is a computing technique used to make decisions. Unlike traditional computer programming complete with sets of if-then and do-while statements, machine learning ingests sample data, makes observations against it, formats the observations as a matrix, applies linear algebra against the result, identifies patterns &amp; anomalies in the data, and uses them to classify &amp; cluster the observations. Through the use of machine learning, a person can predict the weather, ascertain the authorship of a sonnet, or complete the following statement: "People like you also like..."

In the unsupervised machine learning process there are no labels for the sample data. The columns (observations) in the matrix may have values such as temperature, altitude, date, time, relative humidity, etc, but each row in the matrix has no meaningful label, but rather a meaningless identifier. On the other hand, in a supervised machine learning process each row in the matrix has one or more meaningful labels. For example, the columns might be number of leaves, height, date of blooming, and the rows are different species of plants. In a textual sense, the columns might be relative frequency of words, date of publication, and over-all readability score, where row values could be author names, genres, or genders. Labels, in supervised machine learning processes, are usually non-numeric. 

Topic modeling is an unsupervised machine learning process. It identifies sets of words which cluster around each other. Topic modeling outputs words in close proximity to other words. These "clusters" are deemed to be topics or the themes in a corpus. Because topic modeling is unsupervised -- unlabeled -- this form of machine learning is often characterized as allowing the data "to speak for itself."

Topic modeling is a good way to get a sense of the "aboutness" of a document or set of documents.





--- 
Eric Lease Morgan &lt;emorgan@nd.edu&gt;  
February 18, 2019

