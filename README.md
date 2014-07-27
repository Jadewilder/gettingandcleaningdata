getting and cleaning data
======================
The data for this code is obtained from the UCI machine learning repository:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The purpose of the code is to generate a table of means for the mean and standard deviation of each subject and each of their activities. Below are the steps to generate the results
-----------------------------------------------------------------

Script will first install the Reshape r package if it is not already installed

A temp file will be created if it does not already exist to unpack the zip file 

The zip file will be unpacked and a folder called "UCI HAR Dataset" will be added to the working directory

The records required for the data analysis will be read into R

The the rowlabels are normalized and  the rowlabels are merged with test and training data sets as column headers

The label, test, and train datasets are given column headers to faciltate join operation - "activitycode" and "activity"

The label dataset  is joined with the merged test and train dataset- called "dataset", the new dataset is "dataset2"

The mean and standard deviation columns are extracted from dataset2 -"dataset3" (step 2 in the project requirements)

dataset3 is uses the melt funtion from the reshape package to create a dataset with 4 columns, "activity", "subject", "variable", and "value", where "variable" is the mean and standard deviation  columns from dataset3 and "value" is the repective mean or standard deviation of each variable. This is dataset4

The cast function from the reshape package is used to get the means of each variable by "subject", "activity", and "variable

The final dataset is output to the working directory in csv format with the name "final.csv"
