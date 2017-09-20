###### BACKGROUND INFORMATION ######
### Author comment 
# Initial script by Maikel Jonkers (14-09-2017) as part of course 3 'Getting and Cleaning Data' of 'Data Science Specialization'
# created by John Hopkins University, offered by Coursera. This script is a elaboration of the Peer-graded Assignment (step 1 of 5).
# Next to this short description, there are two files which further explain the assignment, the process and choices I've made:
# README.md
# Codebook.md


###### FILE DESCRIPTION ######
### Input
# * The UCI HAR Dataset - A number of folders and files with sensor signals (accelerometer and gyroscope) of the smartphones 
#   (see Codebook.md for the files and variables).

### Goal
# This script will execute the first step of the assignment: 
# 1. Merges the training and the test sets to create one data set.
# This step is divided in serveral steps:
# 1a. Read necessary data (root-files, test-files and train-files)
# 1b. Combine data sets (for test-files and train-files)
# 1c. Combine data set test and training to create one data set

### Output
# During this script several variables and data sets are created (see codebook.md and readme.md for full description)
# The data set (next to input files) which will be used in the following steps is 'df1_CombineTrainTest'.


###### CODE ######
### 1a. Read necessary data (root-files, test-files and train-files)
## Read necessary Root directory Files
RootFiles <-list.files("./UCI HAR Dataset/", pattern = "\\.txt$") # collect all text-files and point at the right directory
NumRootFiles <- length(RootFiles)
for (i in 1:2) # fixed 2 because of explanatory files in root directory
{
    assign(paste("df_",file_path_sans_ext(RootFiles[i]),sep=""), # get filename without extension for naming data set
           read.csv(paste("./UCI HAR Dataset/", RootFiles[i], sep=""), sep = " ", header=FALSE)) # read file into data set
}

## Read all Test Files
TestFiles <- list.files("./UCI HAR Dataset/test", pattern = "\\.txt$") # collect all text-files and point at the right directory
NumTestFiles <- length(TestFiles)
for (i in 1:NumTestFiles)
{
    assign(paste("df_",file_path_sans_ext(TestFiles[i]),sep=""), # get filename without extension for naming data set
           read.csv(paste("./UCI HAR Dataset/test/", TestFiles[i], sep=""), sep = " ", header=FALSE)) # read file into data set
}
# 2nd file (X_test.txt) has a different format. This code is added to cope with the format (fixed widths)
assign(paste("df_",file_path_sans_ext(TestFiles[2]),sep=""), # get filename without extension for naming data set
       read_fwf(file=paste("./UCI HAR Dataset/test/", TestFiles[2], sep=""), col_types = cols(), fwf_widths(c(rep(16, 561))))) # read with fixed widths

## Read all Training Files
TrainFiles <- list.files("./UCI HAR Dataset/train", pattern = "\\.txt$") # collect all text-files and point at the right directory
NumTrainFiles <- length(TrainFiles)
for (i in 1:NumTrainFiles)
{
    assign(paste("df_",file_path_sans_ext(TrainFiles[i]),sep=""), # get filename without extension for naming data set
           read.csv(paste("./UCI HAR Dataset/train/", TrainFiles[i], sep=""), sep = " ", header=FALSE)) # read file into data set
}
# 2nd file (X_train.txt) has a different format. This code is added to cope with the format (fixed widths)
assign(paste("df_",file_path_sans_ext(TrainFiles[2]),sep=""), # get filename without extension for naming data set
       read_fwf(file=paste("./UCI HAR Dataset/train/", TrainFiles[2], sep=""), col_types = cols(), fwf_widths(c(rep(16, 561))))) # read with fixed widths


### 1b. Combine data sets (for test-files and train-files)
## Combine test data
# change columnnames
CNames <- df_features[,2]
colnames(df_X_test)<-CNames
colnames(df_y_test)<-"Activity_ID"
colnames(df_subject_test)<-"Subject_ID"

# add column with unique ID to merge by
df_y_test$ID <- paste("test row ", seq.int(nrow(df_y_test)))
df_X_test$ID <- paste("test row ", seq.int(nrow(df_X_test)))
df_subject_test$ID <- paste("test row ", seq.int(nrow(df_subject_test)))
df_subject_test <- df_subject_test[,c(2,1)] # change order to get ID in first column

# merge datasets
df_test <- full_join(df_y_test, df_X_test,by="ID")
df_test <- full_join(df_subject_test, df_test,by="ID")


## Combine training data
# change columnnames
colnames(df_X_train)<-CNames
colnames(df_y_train)<-"Activity_ID"
colnames(df_subject_train)<-"Subject_ID"

# add column with unique ID to merge by
df_y_train$ID <- paste("train row ", seq.int(nrow(df_y_train)))
df_X_train$ID <- paste("train row ", seq.int(nrow(df_X_train)))
df_subject_train$ID <- paste("train row ", seq.int(nrow(df_subject_train)))
df_subject_train <- df_subject_train[,c(2,1)] # change order to get ID in first column

# merge datasets
df_train <- full_join(df_y_train, df_X_train,by="ID")
df_train <- full_join(df_subject_train, df_train,by="ID")


### 1c. Combine data set test and training to create one data set
df1_CombineTrainTest <- rbind(df_test, df_train)
