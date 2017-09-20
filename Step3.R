###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (step 3 of 5).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables).
# * df2_SubTrainTest - the data set from step 2 (see Codebook.md for description data set)

### Goal
# This script will execute the third step of the assignment: 
# 3. Uses descriptive activity names to name the activities in the data set

### Output
# The data set (next to original UCI HAR Dataset) which will be used in the following steps is 'df3_DescrSubTrainTest'.
# (see Codebook.md for description data set).


###### CODE ######
### Collect labels and replace values/labels
df3_DescrSubTrainTest <- df2_SubTrainTest # copy data set to follow changes each step
colnames(df_activity_labels) <- c("Activity_ID", "Activity") # label columns df_activity_labels
df3_DescrSubTrainTest$Activity_ID <- df_activity_labels$Activity[match(df3_DescrSubTrainTest$Activity_ID, 
                                                                       df_activity_labels$Activity_ID)] # replace values activity
names(df3_DescrSubTrainTest)[names(df3_DescrSubTrainTest)=="Activity_ID"] <- "Activity" # rename column df3_DescrSubTrainTest
