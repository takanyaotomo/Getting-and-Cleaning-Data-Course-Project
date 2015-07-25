# プロジェクト　コードブック

ここでは、このプロジェクトで行った、データの収集方法、抽出方法、加工方法について記述します。さらに、生成したtidyデータについての詳細についても記述します。

## 0. データの取得
まず、データをdownload.file()関数を利用し、
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
を取得しました。
次に、取得したファイルをunzip関数で解凍しました。
解凍されたファイルのうち、プロジェクトで利用したファイルは以下のものです
UCI HAR Dataset/test/subject_test.txt
UCI HAR Dataset/test/X_test.txt
UCI HAR Dataset/test/y_test.txt
UCI HAR Dataset/train/subject_train.txt
UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/activity_labels.txt
UCI HAR Dataset/features.txt

## 1. Merges the training and the test sets to create one data set.
解凍したファイルをread.table()関数で読み込みました。ファイルと変数名の対応はいかのとおりです。

+ X_test : UCI HAR Dataset/test/X_test.txt
+ X_train: UCI HAR Dataset//train//X_train.txt
+ y_test: UCI HAR Dataset//test//y_test.txt
+ y_train: UCI HAR Dataset//train//y_train.txt
+ subject_test: UCI HAR Dataset//test//subject_test.txt
+ subject_train: UCI HAR Dataset//train//subject_train.txt

testとtrainのデータをrbind()関数を使いマージして新たな変数を作成しました。
マージ先の変数名とマージ元の変数名は以下のとおりです。

+ X_merge: X_test, X_train
+ y_merge: y_test, y_train
+ subject_merge:, subject_test, subject_train

マージしたデータにnames()関数を使って列名を挿入しました。
X_mergeの列名はUCI HAR Dataset//features.txtの中のテーブルの2列目を挿入しました。
y_mergeの列名は"subject"としました。
subject_mergeの列名は"activity"としました。

これらのデータをcbind()関数でマージし、一つのデータセットを作成しました。
変数名はdatasetとしました。


## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 

datasetから平均と標準偏差の列のみを抽出しました。抽出条件は列名に"mean", "std", "subject", "activity"を含むものとし、grepl()関数を利用しました。抽出したデータセットの変数名は"dataset_mean_sd"としまた。


## 3.Uses descriptive activity names to name the activities in the data set
ライブラリplyrを利用しました。
まず、read.table()関数で、UCI HAR Dataset//activity_labels.txtを読み込んだ。変数名は"activity_labels"としました。
次に、activity_labelsにnames()関数で列名をつけた1列名は"activity"とし、2列目は"activity_label"としました。
最後にjoin()関数を利用して2つのデータ（dataset_mean_sdとactivity_labels"）を結合し、新たなデータセットdataset_mean_sd_joinを生成しました。

## 4. Appropriately labels the data set with descriptive variable names
データセットの列名で省略されているものをnames()関数及びgsub()関数を利用して置換しました。置換した文字は以下のとおりです。
+ tで始まるもの: time
+ fで始まるもの:frequency
+ Acc: Accelerometer
+ Gyro: Gyroscope
+ Mag: Magnitude

## 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

dataset_mean_sd_joinに対しaggregate()関数を利用し、各列の平均値を計算し、新たなデータセットtidy_dataを作成しました。グループ化する列は"subject","activity","actifity_label"で、計算した列は2列目から80列目です。

tidy_dataに対してorder()関数を利用し、列名subjectとactivityを基準に昇順に並べ替え、新たなデータセットtidy_data_orderdを生成しました。

最後に、write.table()関数でデータセットtidy_data_orderedをテキストファイルtidy_data.txtに書き出しました。


## 生成したデータセット

生成したデータセットの列名は以下の82列となります。

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

