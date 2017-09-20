###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (step 4 of 5).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables).
# * df3_DescrSubTrainTest - the data set from step 3 (see Codebook.md for description data set)

### Goal
# This script will execute the third step of the assignment: 
# 4. Appropriately labels the data set with descriptive variable names.
# This step is divided in serveral steps:
# 4a. Make new dataframe for tracking and tracing
# 4b. Rename the labels of the data set
# 4c. Fill the dataframe with the seperate columns


### Output
# The data sets (next to original UCI HAR Dataset) which will be used in the following steps are: 
# * 'df_features_descriptive'
# * 'df4_DescrSubTrainTest'
# (see Codebook.md for description data sets)


###### CODE ######
### Appropriately labels the data set with descriptive variable names
df4_DescrSubTrainTest <- df3_DescrSubTrainTest # copy data set to follow changes each step

# 4a. make new dataframe with current column names for tracking and tracing data to original data set
df_features_descriptive  <- data.frame(matrix(data = NA, nrow=ncol(df4_DescrSubTrainTest), ncol=9)) # empty dataframe
colnames(df_features_descriptive) <- c("Features", "FeaturesDescriptive", "Calculation", "MagnitudeAngle", "TimeFrequency", "Jerk", "Sensor", 
                                       "BodyGravity", "Axis") # add column names (including columns to make other tidy data set)
df_features_descriptive[,1] <- colnames(df4_DescrSubTrainTest) # current column names in column 'Features'

# 4b. Rename change column names in data set to descriptive variable names
names(df4_DescrSubTrainTest) <- gsub("\\(t", "Time", names(df4_DescrSubTrainTest))              # replace '(t' by 'Time' in labels
names(df4_DescrSubTrainTest) <- gsub("^t", "Time", names(df4_DescrSubTrainTest))                # labels starting with t replace 't' by 'Time'
names(df4_DescrSubTrainTest) <- gsub("Freq", "Weighted", names(df4_DescrSubTrainTest))          # replace 'Freq' by 'Weighted' in labels
names(df4_DescrSubTrainTest) <- gsub("^f", "Frequency", names(df4_DescrSubTrainTest))           # labels starting with f replace 'f' by 'Frequency' 
names(df4_DescrSubTrainTest) <- gsub("Acc", "Acceleration", names(df4_DescrSubTrainTest))       # replace 'Acc' by 'Acceleration' in labels
names(df4_DescrSubTrainTest) <- gsub("Gyro", "Rotation", names(df4_DescrSubTrainTest))          # replace 'Gyro' by 'Rotation' in labels
names(df4_DescrSubTrainTest) <- gsub("Mag", "Magnitude", names(df4_DescrSubTrainTest))          # replace 'Mag' by 'Magnitude' in labels
names(df4_DescrSubTrainTest) <- gsub("mean", "Mean", names(df4_DescrSubTrainTest))              # replace 'mean' by 'Mean' in labels
names(df4_DescrSubTrainTest) <- gsub("std", "Standarddeviation", names(df4_DescrSubTrainTest))  # replace 'std' by 'Standarddeviation' in labels
names(df4_DescrSubTrainTest) <- gsub("-", "", names(df4_DescrSubTrainTest))                     # remove all '-' in labels
names(df4_DescrSubTrainTest) <- gsub(",", "", names(df4_DescrSubTrainTest))                     # remove all ',' in labels
names(df4_DescrSubTrainTest) <- gsub("\\(|\\)", "", names(df4_DescrSubTrainTest))               # remove all '(' and ')' in labels
names(df4_DescrSubTrainTest) <- gsub("X", "Xaxis", names(df4_DescrSubTrainTest))                # replace 'X' by 'Xaxis' in labels
names(df4_DescrSubTrainTest) <- gsub("Y", "Yaxis", names(df4_DescrSubTrainTest))                # replace 'Y' by 'Yaxis' in labels
names(df4_DescrSubTrainTest) <- gsub("Z", "Zaxis", names(df4_DescrSubTrainTest))                # replace 'Z' by 'Zaxis' in labels
names(df4_DescrSubTrainTest) <- gsub("BodyBody", "Body", names(df4_DescrSubTrainTest))          # replace 'BodyBody' by 'Body' in labels
df_features_descriptive[,2] <- colnames(df4_DescrSubTrainTest) # add new column names to dataframe for tracking and tracing

# 4c. Extend dataframe with columns for second tidy data set
# All adding values by logic like: if certain text/pattern in column 'df_features_descriptive$Features', then fill defined column with value.
df_features_descriptive$Calculation[grepl("[Mm]ean", df_features_descriptive$Features)] <- "Mean"
df_features_descriptive$Calculation[grepl("meanFreq", df_features_descriptive$Features)] <- "Weighted average"
df_features_descriptive$Calculation[grepl("std", df_features_descriptive$Features)] <- "Standard Deviation"
df_features_descriptive$MagnitudeAngle[grepl("Mag", df_features_descriptive$Features)] <- "Magnitude"
df_features_descriptive$MagnitudeAngle[grepl("[Aa]ngle", df_features_descriptive$Features)] <- "Angle"
df_features_descriptive$TimeFrequency[grepl("^t", df_features_descriptive$Features)] <- "Time"
df_features_descriptive$TimeFrequency[grepl("^f", df_features_descriptive$Features)] <- "Frequency"
df_features_descriptive$Jerk[grepl("[Jj]erk", df_features_descriptive$Features)] <- "Jerk"
df_features_descriptive$Sensor[grepl("Acc", df_features_descriptive$Features)] <- "Acceleration"
df_features_descriptive$Sensor[grepl("Gyro", df_features_descriptive$Features)] <- "Rotation"
df_features_descriptive$BodyGravity[grepl("[Bb]ody", df_features_descriptive$Features)] <- "Body"
df_features_descriptive$BodyGravity[grepl("[Gg]ravity", df_features_descriptive$Features)] <- "Gravity"
df_features_descriptive$Axis[grepl("X,", df_features_descriptive$Features)|grepl("-X", df_features_descriptive$Features)] <- "X"
df_features_descriptive$Axis[grepl("Y,", df_features_descriptive$Features)|grepl("-Y", df_features_descriptive$Features)] <- "Y"
df_features_descriptive$Axis[grepl("Z,", df_features_descriptive$Features)|grepl("-Z", df_features_descriptive$Features)] <- "Z"