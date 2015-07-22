# Run in R Studio on ubuntu14.10

# Befor starting the project
# Download and unzip the data file

download.file(
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
  destfile = "getdata_projectfiles_UCI HAR Dataset.zip", method = "wget")

unzip("getdata_projectfiles_UCI HAR Dataset.zip")

# 1. Merges the training and the test sets to create one data set.
# read and rbind
X_test <- read.table("UCI HAR Dataset//test//X_test.txt", header = FALSE)
X_train <- read.table("UCI HAR Dataset//train//X_train.txt", header = FALSE)
X_merge <- rbind(X_test, X_train)

y_test <- read.table("UCI HAR Dataset//test//y_test.txt", header = FALSE)
y_train <- read.table("UCI HAR Dataset//train//y_train.txt", header = FALSE)
y_merge <- rbind(y_test, y_train)

subject_test <- read.table("UCI HAR Dataset//test//subject_test.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset//train//subject_train.txt", header = FALSE)
subject_merge <- rbind(subject_test, subject_train)

# set column name(s) for each *_merge
column_names <- read.table("UCI HAR Dataset//features.txt", header = FALSE)
names(X_merge) <- column_names$V2

names(y_merge) <- c("activity")

names(subject_merge) <- c("subject")

# create one data set (cbind)
dataset <- cbind(subject_merge, X_merge, y_merge)


# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
dataset_mean_sd <- dataset[,grepl("mean|std|subject|activity", names(dataset))]


# 3.Uses descriptive activity names to name the activities in the data set
library(plyr)
activity_labels <- read.table("UCI HAR Dataset//activity_labels.txt", header = FALSE)
names(activity_labels) <- c("activity", "activity_label")
dataset_mean_sd_join <- join(dataset_mean_sd, activity_labels, by="activity", match="first")