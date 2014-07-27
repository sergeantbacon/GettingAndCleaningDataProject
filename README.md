Getting And Cleaning Data - Project
===================================

##Summary##
This repo contains project work for the Johns Hopkins Getting and Cleaning Data class. The aim of the project is to practice cleaning, transforming, merging, and documenting a data set.

The data set used is the Human Activity Recognition Using Smartphones Dataset (Version 1.0), published by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, and Davide Anguita at the Unversity of Genoa.

The dataset is available at the UCI Machine Learning Repository:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Running the script produces a tidy data set with the average of each variable for each activity and each subject.

##Repo Contents##
####README.md####
This file.
####run_analysis.R####
The R script used to coerce the dataset into a tidy dataset. See *Data Manipulation Explanation* below for details.
####CodeBook.md####
A codebook that describes the fields in the resultant data frame.

##Data Manipulation Explanation##
The following steps were taken to coerce the data into the resultant tidy data set. The tidy data set is arranged in a narrow fashion for ease of use further machine analysis or for converting to a database.

1. Merge the `subject`, `X`, `Y` tables for the Test and Train data sets.
2. Melt the Test and Train data frames so that each row represents one observation for one feature type.
3. Combine the Test and Train data sets.
4. Add activity labels by left joining the `activity_labels` file.
5. Add feature labels by left joining the `features` file.
6. Subset the data frame so that it contains only observations on means and standard deviations.
7. Improve the feature labels to make them more readable.
8. Create a new data frame where each row represents the average of all observations for a single subject-activity-feature set.