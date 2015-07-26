# Project CodeBook

In this file, it is described about methods(collecting, extracting, processing) to the data. In addition, it is described details about the generated tidy dataset. 

## 0. Collecting the data
Get the following file by using download.file() function.  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

unzip this file by using unzip() function.

The files used in this project are:
+ UCI HAR Dataset/test/subject_test.txt
+ UCI HAR Dataset/test/X_test.txt
+ UCI HAR Dataset/test/y_test.txt
+ UCI HAR Dataset/train/subject_train.txt
+ UCI HAR Dataset/train/X_train.txt
+ UCI HAR Dataset/train/y_train.txt
+ UCI HAR Dataset/activity_labels.txt
+ UCI HAR Dataset/features.txt

## 1. Merges the training and the test sets to create one data set.
The unzipped files were read in read.table () function. Relationship of files and variable names are:
+ X_test : UCI HAR Dataset/test/X_test.txt
+ X_train: UCI HAR Dataset//train//X_train.txt
+ y_test: UCI HAR Dataset//test//y_test.txt
+ y_train: UCI HAR Dataset//train//y_train.txt
+ subject_test: UCI HAR Dataset//test//subject_test.txt
+ subject_train: UCI HAR Dataset//train//subject_train.txt

Generate the new dataset from each pair (test and train data) by using rbind() function. Relationship of the new dataset and original datasets are:
+ X_merge: X_test, X_train
+ y_merge: y_test, y_train
+ subject_merge:, subject_test, subject_train

Insert column names in the merged datasets by using names() function.
+ Column name of X_merge was inserted the second row of the UCI HAR Dataset // features.txt.
+ Column name of y_merge was inserted "subject".
+ Column name of subject_merge was inserted "activity".

Generate one dataset from these datasets by using cbind() function. This dataset is  named "dataset".

## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
Extract only the columns of mean and standard deviation from "dataset". The extract conditions are to include any of the following in the column names.
+ mean
+ std
+ subject
+ activity

In this condition, generate the new dataset named "dataset_mean_sd" by using grepl() function.

## 3.Uses descriptive activity names to name the activities in the data set
First, read UCI HAR Dataset//activity_labels.txt by using read.table() function. Variable name is "activity_label".
Second, set to "activity_labels" by using names() function. the first column is "activity" and second column is "activity_label".
Finally, merge two datasets("dataset_mean_sd" and "activity_labels") by using join() function that included in plyr library. The new dataset is named "dataset_mean_sd_join".

## 4. Appropriately labels the data set with descriptive variable names
Replace column names that word is abbreviated by using names() function and gsub() function.Character to be replaced is as follows:
+ beginning with "t" : "time"
+ beginning with "f" : "frequency"
+ Acc: Accelerometer
+ Gyro: Gyroscope
+ Mag: Magnitude

## 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Calculate the mean of each column from "dataset_mean_sd_join" by using aggregate() function and generate the new dataset "tidy_data". Grouped columns are "subject", "activity" and "activitiy_label" in "tidy_data" and calculated columns are from the second to 80th.
Sort "tidy_data" in ascending order based on the column name "subject" and "activity" and generate the new dataset "tidy_data_ordered".
Finally, write "tidy_data_ordered" to the file "tidy_data.txt" by using write.table() function.

## Generated final dataset

The column names of the final dataset (the number of columns is 82) are:   
subject  
activity  
activity_label  
timeBodyAccelerometer-mean()-X  
timeBodyAccelerometer-mean()-Y  
timeBodyAccelerometer-mean()-Z  
timeBodyAccelerometer-std()-X  
timeBodyAccelerometer-std()-Y  
timeBodyAccelerometer-std()-Z  
timeGravityAccelerometer-mean()-X  
timeGravityAccelerometer-mean()-Y  
timeGravityAccelerometer-mean()-Z  
timeGravityAccelerometer-std()-X  
timeGravityAccelerometer-std()-Y  
timeGravityAccelerometer-std()-Z  
timeBodyAccelerometerJerk-mean()-X  
timeBodyAccelerometerJerk-mean()-Y  
timeBodyAccelerometerJerk-mean()-Z  
timeBodyAccelerometerJerk-std()-X  
timeBodyAccelerometerJerk-std()-Y  
timeBodyAccelerometerJerk-std()-Z  
timeBodyGyroscope-mean()-X  
timeBodyGyroscope-mean()-Y  
timeBodyGyroscope-mean()-Z  
timeBodyGyroscope-std()-X  
timeBodyGyroscope-std()-Y  
timeBodyGyroscope-std()-Z  
timeBodyGyroscopeJerk-mean()-X  
timeBodyGyroscopeJerk-mean()-Y  
timeBodyGyroscopeJerk-mean()-Z  
timeBodyGyroscopeJerk-std()-X  
timeBodyGyroscopeJerk-std()-Y  
timeBodyGyroscopeJerk-std()-Z  
timeBodyAccelerometerMagnitude-mean()  
timeBodyAccelerometerMagnitude-std()  
timeGravityAccelerometerMagnitude-mean()  
timeGravityAccelerometerMagnitude-std()  
timeBodyAccelerometerJerkMagnitude-mean()  
timeBodyAccelerometerJerkMagnitude-std()  
timeBodyGyroscopeMagnitude-mean()  
timeBodyGyroscopeMagnitude-std()  
timeBodyGyroscopeJerkMagnitude-mean()  
timeBodyGyroscopeJerkMagnitude-std()  
frequencyBodyAccelerometer-mean()-X  
frequencyBodyAccelerometer-mean()-Y  
frequencyBodyAccelerometer-mean()-Z  
frequencyBodyAccelerometer-std()-X  
frequencyBodyAccelerometer-std()-Y  
frequencyBodyAccelerometer-std()-Z  
frequencyBodyAccelerometer-meanFreq()-X  
frequencyBodyAccelerometer-meanFreq()-Y  
frequencyBodyAccelerometer-meanFreq()-Z  
frequencyBodyAccelerometerJerk-mean()-X  
frequencyBodyAccelerometerJerk-mean()-Y  
frequencyBodyAccelerometerJerk-mean()-Z  
frequencyBodyAccelerometerJerk-std()-X  
frequencyBodyAccelerometerJerk-std()-Y  
frequencyBodyAccelerometerJerk-std()-Z  
frequencyBodyAccelerometerJerk-meanFreq()-X  
frequencyBodyAccelerometerJerk-meanFreq()-Y  
frequencyBodyAccelerometerJerk-meanFreq()-Z  
frequencyBodyGyroscope-mean()-X  
frequencyBodyGyroscope-mean()-Y  
frequencyBodyGyroscope-mean()-Z  
frequencyBodyGyroscope-std()-X  
frequencyBodyGyroscope-std()-Y  
frequencyBodyGyroscope-std()-Z  
frequencyBodyGyroscope-meanFreq()-X  
frequencyBodyGyroscope-meanFreq()-Y  
frequencyBodyGyroscope-meanFreq()-Z  
frequencyBodyAccelerometerMagnitude-mean()  
frequencyBodyAccelerometerMagnitude-std()  
frequencyBodyAccelerometerMagnitude-meanFreq()  
frequencyBodyBodyAccelerometerJerkMagnitude-mean()  
frequencyBodyBodyAccelerometerJerkMagnitude-std()  
frequencyBodyBodyAccelerometerJerkMagnitude-meanFreq()  
frequencyBodyBodyGyroscopeMagnitude-mean()  
frequencyBodyBodyGyroscopeMagnitude-std()  
frequencyBodyBodyGyroscopeMagnitude-meanFreq()  
frequencyBodyBodyGyroscopeJerkMagnitude-mean()  
frequencyBodyBodyGyroscopeJerkMagnitude-std()  
frequencyBodyBodyGyroscopeJerkMagnitude-meanFreq()  




