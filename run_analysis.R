getwd()
setwd("D:/R Course/Data Science Specialisation (JHU)/Data Science Specialisation/Getting and Cleaning Data")

## Loading training data
train_data_X <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_data_Y <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
train_data_sub <- read.table ("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

## Loading test data
test_data_X <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_data_Y <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
test_data_sub <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

## Loading variable names
varnames <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

## Loading labels
act_labels <- read.table ("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

## Call 1: Merging the training and the test sets to create one data set
X_total <- rbind(train_data_X, test_data_X)
Y_total <- rbind(train_data_Y, test_data_Y)
total_sub <- rbind(train_data_sub, test_data_sub)

## Call 2: Extracting only the measurements on the mean and standard deviation for each measurement. 
varnames_sel <- varnames[grep("mean|std",varnames[,2]),]
X_total <- X_total[,varnames_sel[,1]]
View(X_total)

## Call 3: Use descriptive activity names to name the activities in the data set.
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(act_labels[,2]))
activitylabel <- Y_total[,-1]

## Call 4: Appropriately label the data set with descriptive variable names. 
colnames(X_total) <- varnames[varnames_sel[,1],2]
View(X_total)

## Call 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(total_sub) <- "Subject"
complete <- cbind(X_total, activitylabel, total_sub)

library(dplyr)
mean_complete <- complete %>% group_by(activitylabel, Subject) %>% summarize_each(funs(mean))
write.table(mean_complete, file = "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/dataset_tidy.txt", row.names = FALSE)

dataset_tidy <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/dataset_tidy.txt")
View(dataset_tidy)
