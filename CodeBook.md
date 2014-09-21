CodeBook
========

the variables, the data, and any transformations or work that you performed to clean up the data called


## The Data

This project uses data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data is included in the repo and can also be downloaded as a .zip [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

From the source:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The Variables

`run_analysis.R` imports the train data from '/train/X_train.txt', '/train/y_train.txt', and '/train/subject_train.txt' into *x.train*, *y.train*, and *subject.train* respectively. It imports the test data from '/test/X_test.txt', '/test/y_test.txt', and '/test/subject_test.txt' into *x.test*, *y.test*, and *subject.test* respectively. The activity labels are imported from '/activity_labels.txt' into *activity.labels*, and the names of the measurements are imported from '/features.txt' into *features*.

## The Transformations

`run_analysis.R` does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### 1. Merges training and test data

A variable *x.all* is created that merges the data from *x.train* and *x.test* with the `rbind()` command. The columns are renamed with the labels from *features*.

### 2. Extracts only mean and std measurements

A vector *meansd* is created that uses `grep()` to find the columns that have features with "mean()" or "std()" in the name. These columns are isolated in a new data frame called *x.meansd*.

### 3. Use descriptive activity names

The activity data in *y.train* and *y.test* are combined with `rbind()` into *y.all*. This column is renamed 'activityId'. This is combined into the data frame *x.meansd* using `cbind()` into a new data fram *all.meansd*.

### 4. Labal the data set

A vector *activityType* is populated with the activity type based on the activityId. This is added as a column into *all.meansd*.

### 5. Independent Tidy Data Set

The subject data from *subject.train* and *subject.test* are combined in a vector called 'subjectId'. This is added to *all.meansd* in a data frame called *all*.

`aggregate()` is used to apply the mean of each of the measurements per activity and subject. These columns are renamed to the measurement names in *x.meansd*.

The column names are cleaned up, removing '-' and '()' and capitalizing for camel case.

This data frame is output to 'tidy_data.txt'.