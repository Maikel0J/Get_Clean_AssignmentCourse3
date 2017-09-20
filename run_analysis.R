###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (main script).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables). 

### Goal
# The core of the assignment is to create a R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Output
# Each step has several data sets/variables. According to the assignment there data sets after step 4 and 5 are critical. 
# Data set after step 4 is called: ....
# Data sets (I've created 2 sets) are called: ... and ....
# Futher explainations are in README.md and Codebook.md


###### CODE ######
#### Initiation
gc()                # Clear memory R
rm(list=ls())       # Clear data
# Set Working directory
Oldwd <- getwd()
wd <- 'D:/NoBackup/R/Get_Clean'
setwd(wd)
# Load packages for this assignment
library(tools) # for use file_path_sans_ext()
library(readr) # to read large fixed width files
library(dplyr) # to merge/join and summarise data
library(reshape2) # for function melt

# To improve the readability each step is in a seperate R-script. 
if(!exists("foo", mode="function")) source("step1.R") # Step 1
if(!exists("foo", mode="function")) source("step2.R") # Step 2
if(!exists("foo", mode="function")) source("step3.R") # Step 3
if(!exists("foo", mode="function")) source("step4.R") # Step 4
if(!exists("foo", mode="function")) source("step5.R") # Step 5

# Set old working directory
setwd(Oldwd)

