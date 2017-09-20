# Codebook

## GLOBAL 
All the files are part of the elaboration for the assignment of course 3 'Getting and Cleaning Data' of 'Data Science Specialization' created by the 
John Hopkins University, offered by Coursera.   

This file is created by Maikel Jonkers at 19-09-2017. This file describes the variables, the data, and any transformations or work 
that I've performed to clean up the data. Next to this file there is an other markdown-file names readme.md. This file describes how all of the scripts work and how they are connected

And of course, there are the scripts in R, which are 6 different scripts (see below).

During writing of the code I had two goals:

* **Primairy**: Write the code in a way that the result provides the solution/copes with the request of the assignment.

* **Secondairy**: Learn more about different techniques of getting and cleaning data. In some cases this means trying other techniques, because I 
expect this to be usefull in the future.

## Variables and data sets by each script
All the variables and data sets are described in seperate chapters. First a general explanation of the dimensions and transformations is given. 
After this each chapter represents a script and for each script the variables and data sets are described. An overview of the process with the 
datasets is shown in the figure below (if the figure doesn't load, then open the file '20170918 Data Process_Get_Clean.jpg' at the Github repository).

![Process of the data sets](D:/NoBackup/R/Get_Clean/20170918 Data Process_Get_Clean.jpg "Process Data Sets")


### Forming the tidy data sets
This is a (very) short description about how to get to this format of (tidy) data set. 
In the beginning there were:

|Data set         |rows   |columns    |
|-----------------|-------|-----------|
|df_X_test        |2947   |561        |
|df_Y_train       |7352   |561        |

In total, this leads to a data set of 10299 rows and 561 columns, were the 561 columns with measurements of variables. 
The data set created in step 1 (df1_CombineTrainTest) has an equal number of rows, but 564 columns. 561 columns with measurements of variables, a column with an unique ID, a column with a subject ID and a column with a activity ID. 

In step 2 the number of columns change to 89. Because of the assignment to only select the mean and std, there are just 86 columns with measurements of variables and 3 columns with the variables unique ID, subject ID and activity ID. In short: 10299 observations of 89 variables. 

In step 3 the dimensions stay the same, only the values of the column (and the label of the column) changes (numbers replaces by descriptive value).

In step 4 the labels of the measurements change, but the dimensions stay the same. 


In step 5 there are 3 different formats for tidy data sets created. In each data set the average is calculated of the measurements for each unique combination of the subject ID and activity's. 

* df5_tidy1
    * In this tidy data set the dimensions are determined by:
        * 30 unique subject IDs
        * 6 unique activity's
        * 86 unique measurements
    30 x 6 x 86 = 15480 rows
    The number of columns is 4; Subject_ID, Activity, FeaturesDescriptive and AverageValue. The column FeaturesDescriptive is the column with the descriptive names of the features.

* df5_tidy2
    * In this tidy data set the descriptive names of the measurements are more divided over seperate columns. I've made this as an exercise. Sometimes a data set is a step in a larger process. To make a number of columns where subsetting is possible (even in other tools) can be handy. This has the same amount of rows as df5_tidy1, but 10 columns. 

* df5_tidy3 and df5_tidy4
    * The last data set is created by two methods, were the last I've edited to comment. The data is more widely formated, so that each measurement is still a seperate column. This has 180 observations (30 unique subject IDs x 6 unique activity's) and 88 colums (Subject ID, Activity and 86 measurements).

<br>

### Main script: run_analysis.R
#### Variables
|Variable       |Class              |Description                                                        |
|---------------|-------------------|-------------------------------------------------------------------|
|Oldwd          |Character          |Current working directory                                          |
|wd             |Character          |Working directory where files are stored                           |

<br>

#### Data sets
None.

<br>


### First step: Step1.R
#### Variables
|Variable       |Class              |Description                                                        |
|---------------|-------------------|-------------------------------------------------------------------|
|RootFiles      |Character          |List with all the txt-files in the folder 'UCI HAR Dataset'        |
|TestFiles      |Character          |List with all the txt-files in the folder 'UCI HAR Dataset/test'   |
|TrainFiles     |Character          |List with all the txt-files in the folder 'UCI HAR Dataset/train'  |
|NumRootFiles   |Integer            |Number of objects in variable 'RootFiles'                          |
|NumTestFiles   |Integer            |Number of objects in variable 'TestFiles'                          |
|NumTrainFiles  |Integer            |Number of objects in variable 'TrainFiles'                         |
|i              |Integer            |Counter in for-loops                                               |
|CNames         |Factor             |All the features of file 'df_features'                             |

<br>

#### Data sets

|Data set               |Dimension              |Class              |Description                                                                                |
|-----------------------|-----------------------|-------------------|-------------------------------------------------------------------------------------------|
|df_activity_labels     |6 obs of 2 var         |data.frame         |From UCI HAR Dataset, file "activity_labels.txt""                                          |
|df_features            |561 obs of 2 var       |data.frame         |From UCI HAR Dataset, file "features.txt"                                                  |
|df_subject_test        |2947 obs of 2 var      |data.frame         |From UCI HAR Dataset, file "subject_test.txt"                                              |
|df_X_test              |2947 obs of 562 var    |data.frame         |From UCI HAR Dataset, file "X_test.txt"                                                    |
|df_y_test              |2947 obs of 2 var      |data.frame         |From UCI HAR Dataset, file "y_test.txt"                                                    |
|df_subject_train       |7352 obs of 2 var      |data.frame         |From UCI HAR Dataset, file "subject_train.txt"                                             |
|df_X_train             |7352 obs of 562 var    |data.frame         |From UCI HAR Dataset, file "X_train.txt"                                                   |
|df_y_train             |7352 obs of 2 var      |data.frame         |From UCI HAR Dataset, file "y_train.txt"                                                   |
|df_test                |2947 obs of 564 var    |data.frame         |Combination of data sets df_features, df_subject_test, df_X_test and df_y_test (.a.)       |
|df_train               |7352 obs of 564 var    |data.frame         |Combination of data sets df_features, df_subject_train, df_X_train and df_y_train (.b.)    |
|df1_CombineTrainTest   |10299 obs of 564 var   |data.frame         |Combination of data sets df_test and df_train (.c.)                                        |
.a. For this data set the following is preformed in the script:

* Use values of column 2 from df_features as labels for df_X_test
* Add labels to df_y_test ("Activity_ID") and df_subject_test ("Subject_ID")
* Add column with unique ID to merge by for data sets df_y_test, df_X_test and df_subject_test
* Merge in two steps (by unique ID), first df_y_test and df_X_test, then merge with df_subject_test

.b. Same as (_a), but then for the train data sets

.c. Binding by row of the data sets df_test and df_train

<br>

### Second step: Step2.R
#### Variables
None.

<br>

#### Data sets
|Data set               |Dimension              |Class              |Description                                                                                |
|-----------------------|-----------------------|-------------------|-------------------------------------------------------------------------------------------|
|df2_SubTrainTest       |10299 obs of 89 var    |data.frame         |Subset of all the columns where the labels of df1_CombineTrainTest contains 'mean', 'Mean' or 'std'|

<br>

### Third step: Step3.R
#### Variables
None.

<br>

#### Data set
|Data set               |Dimension              |Class              |Description                                                                                |
|-----------------------|-----------------------|-------------------|-------------------------------------------------------------------------------------------|
|df3_DescrSubTrainTest  |10299 obs of 89 var    |data.frame         |Replace the numbers which stand for the activity by the values from data set 'df_activity_labels|
<br>

### Fourth step: Step4.R
#### Variables
None.

<br>

#### Data set
|Data set               |Dimension              |Class              |Description                                                                                |
|-----------------------|-----------------------|-------------------|-------------------------------------------------------------------------------------------|
|df_features_descriptive|89 obs of 9 var        |data.frame         |A new data.frame to copy the original labels, the transformed labels and add some new columns to make distinction between the different parts of the research (for a different format tidy data set)|
|df4_DescrSubTrainTest  |10299 obs of 89 var    |data.frame         |Rename all of the labels of the dataframe to a more descriptive names (.d.)                |
.d. The following is replaced or removed:

    Pattern     ->  Action              ->  If replaced by
    ------------------------------------------------------
    (t          ->  Replace             ->  Time               
    t           ->  Replace if starting ->  Time               
    Freq        ->  Replace             ->  Weighted
    f           ->  Replace if starting ->  Frequency          
    Acc         ->  Replace             ->  Acceleration       
    Gyro        ->  Replace             ->  Rotation           
    Mag         ->  Replace             ->  Magnitude          
    mean        ->  Replace             ->  Mean               
    std         ->  Replace             ->  Standarddeviation  
    -           ->  Delete                    
    ,           ->  Delete                     
    ( or )      ->  Delete                     
    X           ->  Replace             ->  Xaxis              
    Y           ->  Replace             ->  Yaxis              
    Z           ->  Replace             ->  Zaxis              
    BodyBody    ->  Replace             ->  Body               

<br>

### Fifth step: Step5.R
#### Variables
|Variable       |Class              |Description                                                        |
|---------------|-------------------|-------------------------------------------------------------------|
|vector_columns |Character          |Vector with all the labels of the columns to make distinct between the variables and observations. | 

<br>

#### Data set
|Data set               |Dimension              |Class              |Description                                                                    |
|-----------------------|-----------------------|-------------------|-------------------------------------------------------------------------------|
|df5_DescrSubTrainTest  |10299 obs of 89 var    |data.frame         |Same as df4_DescrSubTrainTest                                                  |
|df5_tidy1              |15480 obs of 4 var     |data.frame         |A long small tidy data set with the columns: Subject_ID, Activity, FeaturesDescriptive and AverageValue|
|df5_tidy2              |15480 obs of 10 var    |data.frame         |A long, slightly wider tidy data set with the columns: Subject_ID, Activity, Calculation, MagnitudeAngle, TimeFrequency, Jerk, Sensor, BodyGravity, Axis and AverageValue.|
|df5_tidy3              |180 obs of 88 var      |data.frame         |A short, but wide tidy data set with the columns: Subject_ID, Activity and 86 of the descriptive features as seperate column.|
|df5_tidy4              |180 obs of 88 var      |data.frame         |Same as df5_tidy3, but created with different method.                           |









