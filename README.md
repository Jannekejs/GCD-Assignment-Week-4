# GCD-Assignment-Week-4

## Gets and sets working directory on computer
getwd()
setwd("D:/R Course/Data Science Specialisation (JHU)/Data Science Specialisation/Getting and Cleaning Data")

## The following codes read in the text formats of the downloaded data on "training"
train_data_X <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
train_data_Y <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
train_data_sub <- read.table ("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

## The following codes read in the text formats of the downloaded data on "test"
test_data_X <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
test_data_Y <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
test_data_sub <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

## The following code reads in the variable names of the features text file
varnames <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")

## The following code reads in the activity labels of the activity labels text file
act_labels <- read.table ("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

## The following code binds the training and test data of X, the training and test data of Y and the subject data of training and test.
X_total <- rbind(train_data_X, test_data_X)
Y_total <- rbind(train_data_Y, test_data_Y)
total_sub <- rbind(train_data_sub, test_data_sub)

## The following code only extracts the mean and standard deviation columns of the variable names data set and assigns these variable names to the merged X dataset
varnames_sel <- varnames[grep("mean|std",varnames[,2]),]
X_total <- X_total[,varnames_sel[,1]]
View(X_total)

## Activitie labels are included in the dataset by the following code
colnames(Y_total) <- "activity"
Y_total$activitylabel <- factor(Y_total$activity, labels = as.character(act_labels[,2]))
activitylabel <- Y_total[,-1]

## Appropriately labels the data set with descriptive variable names. 
colnames(X_total) <- varnames[varnames_sel[,1],2]
View(X_total)

## The following code creates a new dataset (mean_complete) with the average of each variable for each activity and each subject.
colnames(total_sub) <- "Subject"
complete <- cbind(X_total, activitylabel, total_sub)

library(dplyr)
mean_complete <- complete %>% group_by(activitylabel, Subject) %>% summarize_each(funs(mean))
write.table(mean_complete, file = "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/dataset_tidy.txt", row.names = FALSE)

dataset_tidy <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/dataset_tidy.txt")
View(dataset_tidy)
