---
title: 'Capstone: Milestone Report Instructions'
author: "Joseph Boateng"
date: "2021-03-16"
output: 
  html_document:
    toc: true
    toc_depth: 3
    keep_md: true
---


## Important Information  
It is especially important to submit this assignment before the deadline, March 29, 11:59 PM PDT, because it must be graded by others. If you submit late, there may not be enough classmates around to review your work. This makes it difficult - and in some cases, impossible - to produce a grade. Submit on time to avoid these risks.

## Instructions  
The goal of this project is just to display that you've gotten used to working with the data and that you are on track to create your prediction algorithm. Please submit a report on R Pubs (http://rpubs.com/) that explains your exploratory analysis and your goals for the eventual app and algorithm. This document should be concise and explain only the major features of the data you have identified and briefly summarize your plans for creating the prediction algorithm and Shiny app in a way that would be understandable to a non-data scientist manager. You should make use of tables and plots to illustrate important summaries of the data set. The motivation for this project is to: 1. Demonstrate that you've downloaded the data and have successfully loaded it in.2. Create a basic report of summary statistics about the data sets.3. Report any interesting findings that you amassed so far.4. Get feedback on your plans for creating a prediction algorithm and Shiny app.

##Review criteria
1. Does the link lead to an HTML page describing the exploratory analysis of the training data set?
2. Has the data scientist done basic summaries of the three files? Word counts, line counts and basic data tables?
3. Has the data scientist made basic plots, such as histograms to illustrate features of the data?
4. Was the report written in a brief, concise style, in a way that a non-data scientist manager could appreciate?





#Reads all clean data from previous get n clean exercise



## Introduction   
This project analyzes the [HC Corpora Dataset](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) with the end goal of creating a Shiny App for predicting n-grams.  This first milestone report summarizes an exploratory data analysis.

## File Summary   
Three data files sourced from blogs, news, and twitter were read into R.  The news file had hidden null characters preventing a full file read and these null characters required hand deletion with Notepad++ prior to file loading. 

|f_names |   f_size| f_lines|    n_char|  n_words| pct_n_char| pct_lines| pct_words|
|:-------|--------:|-------:|---------:|--------:|----------:|---------:|---------:|
|blogs   | 200.4242|  899288| 208361438| 37334131|       0.54|      0.27|      0.53|
|news    | 196.2775|   77259|  15683765|  2643969|       0.04|      0.02|      0.04|
|twitter | 159.3641| 2360148| 162385035| 30373583|       0.42|      0.71|      0.43|
  
Processing files of this size pushed up against R's memory limits and ran slowly. To facilitate analysis, I sampled ten percent of the lines from each file. I cleaned the sample and created n-grams. To further speed processing, I subsetted the n-grams to those that covered 90% of the sample phrases.  A fully reproducible version of this data analysis is available on [Github.](https://github.com/groupejopa/JHU-Data-Science-Capstone-/blob/main/02_Task_Script.md)

## Uni-grams  
The corpora are populated with many acronyms and abbreviations such as "rt" for re-tIet, "lol" for laugh out loud, "ic" for I see. Notably, I chose to leave the short hand "im" for I am and "dont" for don't / do not as is, hence they show up as uni-grams.  

### Uni-gram Wordcloud  
Word distribution can be summarized with a word cloud, where word size/color represents frequency. The words, "im", and "time" show up as most frequent followed by "people", "dont", "day", and "love". This is a popular visual method, but I prefer the relative frequency column plots shown below. 

![](Milestone_Report_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

### Uni-grms, By Source  
The different files - blogs, news, twitter - had different word relative frequencies. Notice that in terms of most frequent words, "rt" occurs only on twitter, "ic" and "donc" only in blogs, and "city", "percent", "county" only in news. 

![](Milestone_Report_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

## Uni-gram Distribution
Distributions were created for each set of n-grams, based on relative frequency.

![](Milestone_Report_files/figure-html/unigrams-1.png)<!-- -->


## Bi-gram Distribution
![](Milestone_Report_files/figure-html/bigrams-1.png)<!-- -->

## Tri-gram Distribution
![](Milestone_Report_files/figure-html/trigrams-1.png)<!-- -->

## Quad-gram Distribution
![](Milestone_Report_files/figure-html/quadgrams-1.png)<!-- -->

## N-gram Prediction Model

I anticipate using the n-gram tables created for bi-gram, tri-grams, and quad-grams as the basis for prediction.  The user will input a word, the model will find the bi-gram with the greatest relative frequency given that word.  Similarly, the tri-gram table will be used for making predictions from two word entries and so on.  


|word1 |word2 |word3 |word4 |     n| proportion|  coverage|
|:-----|:-----|:-----|:-----|-----:|----------:|---------:|
|NA    |NA    |NA    |NA    | 36066|   6.84e-03| 0.0068400|
|the   |end   |of    |the   |   497|   9.43e-05| 0.0069343|
|the   |rest  |of    |the   |   454|   8.61e-05| 0.0070204|
|at    |the   |end   |of    |   405|   7.68e-05| 0.0070972|
|for   |the   |first |time  |   397|   7.53e-05| 0.0071725|
|thank |you   |for   |the   |   359|   6.81e-05| 0.0072406|

Notice in the guad-gram table, that the 4-grams are separated by word and arranged by relative frequency. When the user inputs three words, the model matches those words and then finds the fourth word with the greatest relative frequency.  Cases where there is no match, or where more than three words are entered, will have random completion.

