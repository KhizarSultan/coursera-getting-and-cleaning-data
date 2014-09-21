# Load data

x.train         <- read.table("./UCI HAR Dataset/train/X_train.txt")
x.test          <- read.table("./UCI HAR Dataset/test/X_test.txt")
y.train         <- read.table("./UCI HAR Dataset/train/y_train.txt")
y.test          <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject.train   <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject.test    <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses="character")
features        <- read.table("./UCI HAR Dataset/features.txt", colClasses="character")

# 1. Merges the training and the test sets to create one data set.

# combine activity data, rename columns
x.all <- rbind(x.train, x.test)
colnames(x.all) <- features[,2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# find all appropriate columns and isolate
meansd <- grep("(mean|std)\\(", colnames(x.all))
x.meansd <- x.all[,c(meansd)]

# 3. Uses descriptive activity names to name the activities in the data set

# combine activityId data, combine with activity data
y.all <- rbind(y.train, y.test)
colnames(y.all) <- c('activityId')
all.meansd <- cbind(y.all, x.meansd)

# 4. Appropriately labels the data set with descriptive variable names.

# create activityType column based on activityId, combine with activity data
activityType <- c()
for(i in 1:length(all.meansd[,1])){
  activityType<-c(activityType,activity.labels[all.meansd[i,1],2])
}
all.meansd <- cbind(all.meansd, activityType)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# combine subject data, rename, combine with activity data
subject.all <- rbind(subject.train, subject.test)
colnames(subject.all) <- c('subjectId')
all <- cbind(subject.all, all.meansd)

# produce means table, rename columns
tidy_data <- aggregate(all[,3] ~ subjectId+activityType, data=all, FUN="mean")
for(i in 4:(ncol(all)-1)){
  tidy_data[,i] <- aggregate( all[,i] ~ subjectId+activityType, data=all, FUN="mean")[,3]
}
colnames(tidy_data)[3:ncol(tidy_data)] <- colnames(x.meansd)

# clean up column names before output
names(tidy_data) <- gsub("\\(\\)", "", names(tidy_data))
names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
names(tidy_data) <- gsub("std", "Std", names(tidy_data))
names(tidy_data) <- gsub("-", "", names(tidy_data))

# output to tidy_data.txt
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)