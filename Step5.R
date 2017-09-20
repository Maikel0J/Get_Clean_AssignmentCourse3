###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (step 5 of 5).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables).
# * df4_DescrSubTrainTest - the data set from step 4 (see Codebook.md for description data set)
# * df_features_descriptive - the dataframe for tracking and tracing and to make another type of tidy data set

### Goal
# This script will execute the third step of the assignment: 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Output
# I've made a few different formats of tidy data sets (to cope with possible questions from customers)
# * df5_tidy1
# * df5_tidy2
# * df5_tidy3
# (see Codebook.md for description data sets)


###### CODE ######
##### Create independent tidy data set with the average of each variable for each activity and each subject

# deselect standard deviation, only average or mean required towards tidy dataset 1: ID, subjectID, Activity, variable, value
df5_DescrSubTrainTest <- df4_DescrSubTrainTest # copy data set to follow changes each step

# Tidy data set format 1: Subject_ID, Activity, FeaturesDescriptive, AverageValue
vector_columns <- names(df5_DescrSubTrainTest)
df5_tidy1 <- melt(df5_DescrSubTrainTest, id=vector_columns[1:3], measure.vars=vector_columns[4:89])
names(df5_tidy1)[names(df5_tidy1)=="variable"] <- "FeaturesDescriptive" # rename column df5_DescrSubTrainTest
df5_tidy1 <- df5_tidy1 %>%  group_by(Subject_ID, Activity, FeaturesDescriptive) %>% summarize(AverageValue = mean(value))


# Tidy data set format 2: Subject_ID, Activity, Calculation, MagnitudeAngle, TimeFrequency, Jerk, Sensor, BodyGravity, Axis, AverageValue
df5_tidy2 <- inner_join(df5_tidy1, df_features_descriptive,by="FeaturesDescriptive") # Use df_features_descrpitive to get other colums
# This gives a warning (has to do with the different levels), but doesn't effect the result. 
df5_tidy2<-df5_tidy2[ , !(names(df5_tidy2) %in% c("Features","FeaturesDescriptive"))] # remove columns 
df5_tidy2 <- df5_tidy2[c("Subject_ID", "Activity", "Calculation", "MagnitudeAngle", "TimeFrequency", "Jerk", "Sensor", 
                       "BodyGravity", "Axis", "AverageValue")] # change order of columns


# Tidy data set format 3: Subject_ID, Activity, TimeBodyAccelerationMeanXaxis, etc. {average value of all 86 Features}
df5_tidy3 <- aggregate(df5_DescrSubTrainTest[, 4:89], list(df5_DescrSubTrainTest$Subject_ID, df5_DescrSubTrainTest$Activity), mean)
names(df5_tidy3)[names(df5_tidy3)=="Group.1"] <- "Subject_ID" # rename column
names(df5_tidy3)[names(df5_tidy3)=="Group.2"] <- "Activity" # rename column

# Alternative way of same format with dplyr:
#df5_tidy4 <- df5_DescrSubTrainTest[,2:89] # remove column ID
#df5_tidy4 <- df5_tidy4 %>% group_by(Subject_ID, Activity) %>% summarise_all(funs(mean(., na.rm=TRUE))) # calculate mean for all columns

#### Write tidy data set 1
# The tidy data set for uploading in the assignment at Coursera.
write.table(df5_tidy1, file="df5_tidy1.txt", sep=";", row.names=FALSE)
write.table(df5_tidy2, file="df5_tidy2.txt", sep=";", row.names=FALSE)
write.table(df5_tidy3, file="df5_tidy3.txt", sep=";", row.names=FALSE)