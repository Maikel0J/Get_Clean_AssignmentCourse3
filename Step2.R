###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (step 2 of 5).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables).
# * df1_CombineTrainTest - the data set from step 1 (see Codebook.md for description data set)

### Goal
# This script will execute the second step of the assignment: 
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

### Output
# The data set (next to original UCI HAR Dataset) which will be used in the following steps is 'df2_SubTrainTest' 
# (see Codebook.md for description data set).


###### CODE ######
### Extract measurements mean and standard deviation
df2_SubTrainTest <- df1_CombineTrainTest[, c(1:3, grep("[Mm]ean", colnames(df1_CombineTrainTest)),grep("std", colnames(df1_CombineTrainTest)))]
# df_sub_tot -> df2_SubTrainTest