# Readme
<br>

#### CHAPTERS
###### GLOBAL: Introduction of this file and background
###### SYSTEM SPECS: Specification of system, programs and packages
###### FOLDER STRUCTURE: Overview of the folders and files
###### PROCESS: Explanation of the scripts
###### APPENDIX: Original instructions of the assignment
<br>

#### GLOBAL 
All the files are part of the elaboration for the assignment of course 3 'Getting and Cleaning Data' of 'Data Science Specialization' created by the 
John Hopkins University, offered by Coursera.   

This file is created by Maikel Jonkers at 19-09-2017. The goal of this file is to explain how all of the scripts work and how they are connected. 
Next to this file there is an other markdown-file named _Codebook.md_. This file describes the variables, the data, and any transformations or work 
that I've performed to clean up the data.  

And of course, there are the scripts in R, which are 6 different scripts (see below).

During writing of the code I had two goals:

* **Primairy**: Write the code in a way that the result provides the solution/copes with the request of the assignment.

* **Secondairy**: Learn more about different techniques of getting and cleaning data. In some cases this means trying other techniques, because I 
expect this to be usefull in the future.
  
<br>

#### SYSTEM SPECS
The script is build and tested under certain circumstances. The versions/editions of the system, programs and packages is listed below. 

|**System / program / package**     |**Version / Edition**                                              |
|-----------------------------------|-------------------------------------------------------------------|
|Laptop                             |Lenovo T560, Intel(R) Core(TM) i5-6300 CPU @ 2.40 GHz, 8 GB RAM    |
|OS                                 |Windows 7 Enterprise - Service Pack 1 - 32-Bit                     |
|R                                  |Version 3.3.2 (2016-10-31)                                         |
|R-studio                           |Version 1.0.136                                                    |
|Dplyr                              |Version 0.7.2                                                      |

<br>

#### FOLDER STRUCTURE
The UCI HAR Dataset is saved as Zip-file in the directory 'D:/NoBackup/R/Get_Clean' and then unpacked to a seperate folder 'UCI HAR Dataset' in 
the same directory. The structure of the folders with all the files is shown below: 

* **D:/NoBackup/R/Get_Clean** {folder}
    * **UCI HAR Dataset** {folder}
        * **test** {folder}
            * **Inertial Signals** {folder}
                * _body_acc_x_test.txt_
                * _body_acc_y_test.txt_
                * _body_acc_z_test.txt_
                * _body_gyro_x_test.txt_
                * _body_gyro_y_test.txt_
                * _body_gyro_z_test.txt_
                * _total_acc_x_test.txt_
                * _total_acc_y_test.txt_
                * _total_acc_z_test.txt_
            * _subject_test.txt_
            * _X_test.txt_
            * _y_test.txt_
        * **train** {folder}
            * **Inertial Signals** {folder}
                * _body_acc_x_train.txt_
                * _body_acc_y_train.txt_
                * _body_acc_z_train.txt_
                * _body_gyro_x_train.txt_
                * _body_gyro_y_train.txt_
                * _body_gyro_z_train.txt_
                * _total_acc_x_train.txt_
                * _total_acc_y_train.txt_
                * _total_acc_z_train.txt_
            * _subject_train.txt_
            * _X_train.txt_
            * _y_train.txt_
        * _activity_labels.txt_
        * _features.txt_
        * _features_info.txt_
        * _README.txt_
    * _20170918 Data Process_Get_Clean.jpg_
    * _Codebook.md_
    * _df5_tidy1.txt_
    * _df5_tidy2.txt_
    * _df5_tidy3.txt_
    * _README.md_
    * _run_analysis.R_
    * _Step1.R_
    * _Step2.R_
    * _Step3.R_
    * _Step4.R_
    * _Step5.R_
    * _UCI HAR Dataset.zip_

Note that the UCI HAR Dataset is not uploaded to the repository! 

<br>

#### PROCESS
For the assignment there are six different scripts. Each of the scripts have a description at first with author comment, input, goal and output. 
This description is kept as short as possible to keep the script readable. In the code itself there are short comments added to explain what 
the code is for/does. Each script ends with a result, which is copied in the next to maintain this data set (for following each step). 
Some remarks for the scripts are noted below:

* **run_analysis.R** : This is the main script. In this script the initiation of the working directory, packages and the sourcing of the other 
scripts is coded. The following packages are loaded:
    * tools
    * readr
    * dplyr
    * reshape2


* **Step1.R** : This script has the code for the first part: Merges the training and the test sets to create one data set.
    * The script basically has three steps: 
    
        1a. **_Read the necessary data (root-files, test-files and train-files)_**:
        In this script I've chosen to write a code that could load multiple of the same files. In my work it's a possibility that each day a 
        data set with measurements will be saved on a certain location. This code could help me to load all the files for analysis 
        (including copying the name of the original file). 
        The downside of this was that in this case, the files didn't have the same format. So I'd to read the big file again after the loop. 
        
        
        1b. **_Combine data sets (for the test-files and the train-files)_**:
        In this part I've also added a unique ID for each row (to use the join by this column)
        
        1c. **_Combine data set test and data set training to create one data set_**

* **Step2.R** : This script has the code for the second part: Extracts only the measurements on the mean and standard deviation for each measurement.
    * There are 561 features, were 46 end with 'mean()', 7 have a angle of an 'Mean' and 33 have 'std()' in the name. So 86 features in total. 
    Selection of the features on '[Mm]ean' and 'std'.
* **Step3.R** : This script has the code for the third part: Uses descriptive activity names to name the activities in the data set.
    * This script replaces the numbers of the activity (Activity_ID) with the descriptive names and renames the label. 
* **Step4.R** : This script has the code for the fourth part: Appropriately labels the data set with descriptive variable names.
    * The script is basically three steps:
    
        4a. **_Make new dataframe for tracking and tracing_**: 
        I've chosen to make a new dataframe to copy the original labels, new labels and seperate columns for the different options
        in the research. This to make it possible to go back to the original data set (tracking and tracing) and to make a different type of tidy
        data set. 
    
        4b. **_Rename the labels of the data set_**: For each pattern a replacing or removing.
    
        4c. **_Fill the dataframe with the seperate columns_**: To make a different tidy data set (with other possibilities to search for a subset)
    
* **Step5.R** : This script has the code for the fifth part: From the data set in step 4, creates a second, independent tidy data set with the 
average of each variable for each activity and each subject.
    * In the last script I've made three different tidy data sets (with the average of per combination of Subject_ID, Activity and 
    FeaturesDescriptive): 
    
        * **_df5_tidy1_**: This gives a long small tidy data set with the columns: Subject_ID, Activity, FeaturesDescriptive and AverageValue
        
        * **_df5_tidy2_**: This gives a long, slightly wider tidy data set with the columns: Subject_ID, Activity, Calculation, MagnitudeAngle, 
        TimeFrequency, Jerk, Sensor, BodyGravity, Axis and AverageValue. Because each part of the research is mentioned in a different column, this 
        maybe more easy to read for a customer/colleague. 
        
        * **_df5_tidy3_**: This gives a short, but wide tidy data set with the columns: Subject_ID, Activity and 86 of the descriptive features as 
        seperate column (there are two ways to make this dataset, the second is added as comment).

<br>

#### APPENDIX

##### Original instructions of the assignment:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
Review criterialess 
1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate 
   all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

Getting and Cleaning Data Course Projectless 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The 
goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series 
of yes/no questions related to the project. You will be required to submit: 
1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
You should also include a README.md in the repo with your scripts. 
This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article 
(http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
activity and each subject.

Good luck!

<br>

##### Sources I've used to cope with this assignment:
* Interpret the folders 'Inertial Signals files':
    * https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/YcmUuvFLEeWfwAohgaM63Q
* To get name of file for data frame
    * https://stackoverflow.com/questions/13940478/how-do-i-rename-a-data-frame-in-a-for-loop 
* To lose the extension in the filename
    * https://stackoverflow.com/questions/29113973/getting-filename-without-extension-in-r 
* To read file with fixed width
    * https://stackoverflow.com/questions/14383710/read-fixed-width-text-file 
* To add a unique ID in a column
    * https://stackoverflow.com/questions/23518605/add-an-index-numeric-id-column-to-large-data-frame-in-r  
* To select a number of columns based upon a pattern in the labels
    * https://stackoverflow.com/questions/15666226/how-to-drop-columns-by-name-pattern-in-r #
* Excel check if certain pattern is in cell (Dutch)
    * https://support.office.com/nl-nl/article/Controleren-of-een-cel-tekst-bevat-geen-onderscheid-maken-tussen-hoofdletters-en-kleine-letters-7bb505c7-2815-4a7a-9544-57a5f0dcd551 
* Replace values by other values in data frame
    * https://stackoverflow.com/questions/15069984/replace-values-in-data-frame-based-on-other-data-frame-in-r
* Rename column
    * http://www.cookbook-r.com/Manipulating_data/Renaming_columns_in_a_data_frame/
* Create empty data frame
    * https://stackoverflow.com/questions/10689055/create-an-empty-data-frame
    * https://stackoverflow.com/questions/31702132/r-create-empty-data-frame-with-200-rows-and-no-columns
* Delete certain columns (multiple in stead of specific)
    * https://stackoverflow.com/questions/4605206/drop-data-frame-columns-by-name 
* Change order of columns
    * https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame 
* Call other R-script in main script
    * https://stackoverflow.com/questions/6456501/how-to-include-source-r-script-in-other-scripts 
    * https://stackoverflow.com/questions/25273166/combine-and-run-multiple-r-scripts-from-another-script 
* Calculate average for multiple columns
    * https://stackoverflow.com/questions/21982987/mean-per-group-in-a-data-frame  
    * https://stackoverflow.com/questions/11562656/average-data-by-group
* Markdown file
    * https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet
    * https://daringfireball.net/projects/markdown/syntax