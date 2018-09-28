# Getting and Cleaning Data - Course Project

This is part for final project for Coursera course 'Getting and Cleaning Data'

#Code Book.md
It contains details of the coulmns and dataset in 'tidyData.txt'
It has list of all the column names

#run_analysis.R
This is a R script in which has been used to create the tidy data set. It contains following steps. 

1. Download the dataset from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones in the working directory
2. Load the test and training data 
3. Merge all testing data columnwise
4. Merge all training data columnwise
5. Load the activity and feature info
6. Merge all the data from testing and training merged files rowwise 
7. Find the list of column numbers in which subject, activity, standard deviation or mean is stored
8. Converts the `activity` and `subject` columns into factors
9. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `tidyData.txt`.