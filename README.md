GettingandCleaningDataProject
=============================

-----------------------------
1.List of related files
-----------------------------

  a."getdata-projectfiles-UCI HAR Dataset.zip"
  
  b."./Data" folder
  
  c."run_analysis.R"
  
  d."TidyData.csv"


a."getdata-projectfiles-UCI HAR Dataset.zip"

The script will download this file into the wd folder from this url "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones" 
The script itself unzips the file and puts it in the appropriete folder.
It contains all the data needed by the "run_analysis.R" script. 
 
b."./Data" folder

Contains all the raw data unzipped from "getdata-projectfiles-UCI HAR Dataset.zip", this data is unzipped using the "run_analysis.R" script.
The data represents data collected from the accelerometers from the Samsung Galaxy S smartphone.

c."run_analysis.R"

This is an R script containing all the code necessary to generate a the file "TidyData.csv" set from "getdata-projectfiles-UCI HAR Dataset.zip"  

d."TidyData.csv"

This is the file containing a tidy data set, is written by the "run_analysis.R" script using the files in the "./Data" folder. This file contains the mean and standard deviation of each measure for each subject in the study. Is a table with 180 rows (30 subjects * 6 activities each subject) and 68 columns (Activity and Subject ID's plus 66 means of different measurements). 

----------------------------
2.Instructions to use the "run_analysis.R" script.
----------------------------


  2.1 Check that you have a running internet connection
  
  2.2 Run the script "run_analysis.R"
  
    2.2.1 This script was created using 
    
      R x64 v3.1.0
      
      RStudio v0.98.977
      
      package: reshape2 v1.4
      
  2.3 The output of the file will be the "TidyData.csv" file.
  
----------------------------
3.What the "run_analysis.R" script will do?
----------------------------

  3.1 The first part of the code will download and unzip the file in your working directory overwritting any archive with       the same name.

  3.2 The code in lines between 4 and 22 will read the texte files for the needed files in the ".Data/test" and ".Data          /train" folders and combine the files of each folder (X_test.txt & Y_test into one table using cbind, and the same        for X_train & Y_train).
  
  3.3 On line 24 data for both Train and Test will be mixed together by row.
  
  3.4 On line 28 the previously read data from features.txt is transposed and one line is deleted by subsetting it to           match the dimensions of the dataset created in step 3.3
  
  3.5 The vector created in step 3.4 is used to assign the column names to the measurements. The 2 first column names,          that correspond to the subject and activity are named manually.
  
  3.6 On lines 35&36 the numerical values for the activities are changed into human readable ones using the key provided        in the "ActivityLabels.txt" file 
  
  3.7 In lines 40 to 43 all the variables that include "std" or "mean" (excluding "meanFreq") are selected. "MeanFreq" is       excluded according to the "features_info.txt" due to the fact that this value is not the mean of an actual measure,       it is the mean of a parameter. 
  
  3.8 In line 46 a new dataset that only contains "mean" and "std" variables is created. This dataset is created from the       subsetting of the table created in step 3.6 using the vectors created in 3.7.
  
  3.9 In lines 48 to 60 the column names of the data set are changed to be more human readable and clear according to the       tidy data principles. No spaces are used in these names but CamelCase is used in order to provide more readable           column names without introducing any extra characters.
  
  3.10 On lines 62&62 the package reshape2 is installed and loaded in order to use the melt command in the folowing             lines.
  
  3.11 In lines from 67 to 101 the previous data is broken into parts. Each of these parts contains data for all the             variables of one activity and each subject. After that the mean of each of these values is calculated. The               outcome is a table named after the activity (plus "_group" at the end) that contains the mean of each                    measurement of each subject in one activity.
  
  3.12 On line 104 the tables created in the previous step are combined row wise into the finel data set.
  
  3.13 The data set created in the previous step will be written into an archive called "TidyData.csv".
  
----------------------------  
4.General Description of the raw data and it's source.
----------------------------

4.1 Source:

    Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
    Smartlab - Non Linear Complex Systems Laboratory 
    DITEN - Universita  degli Studi di Genova, Genoa I-16145, Italy. 
    activityrecognition '@' smartlab.ws 
    www.smartlab.ws 

4.2 Data Set Information:

    The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person     performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a            smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear            acceleration and 3-axial angular velocity at a constant rate of 50Hz was captured. The experiments were                  video-recorded to label the data manually. 
    The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for           generating the training data and 30% the test data.
    The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in        fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which     has gravitational and body motion components, was separated using a Butterworth low-pass filter into body                acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a          filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating         variables from the time and frequency domain.  

  
  
  
  
  
  
  
  
  
  
  
  
  
    
  








