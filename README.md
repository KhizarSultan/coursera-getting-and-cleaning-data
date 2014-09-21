Getting and Cleaning Data Course Project
========================================

This repo is for the Coursera Getting and Cleaning Data course project.

This project uses data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data is included in the repo and can also be downloaded as a .zip [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The script will import this data and output a clean table of the means of specified variables for each of the subjects.

## Running run_analysis.R

1. Make sure the data is located in a directory called URI HAR Dataset. Unzipping the linked file above in the parent directory will satisfy.
2. Open R and set the project directory as the working directory.
3. Run run_analysis.R with the command `source('run_analysis.r')`

This will output a file called `tidy_data.txt` with the clean data table.

## More Information

Visit the links above and read `CodeBook.md` for more information about the data sets. `CodeBook.md` also describes the tidying process.