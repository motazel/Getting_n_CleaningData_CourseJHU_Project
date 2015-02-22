## You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#first clean up workspace
rm(list = ls())

library(plyr)
library(dplyr)
# 7352 entries in train data
# 2947 entries in test data
setwd("C:\\Users\\motazel\\OneDrive\\Documents\\Courses\\DataScienceJHUCoursera\\DataCleaning_Course\\Project\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")


# 1.Merges the training and the test sets to create one data set.
X_Train <- read.table("train\\X_train.txt")
Labels_Train <- read.table("train\\y_train.txt")
Subject_Train <- read.table("train\\subject_train.txt")
X_Test  <- read.table("test\\X_test.txt")
Labels_Test <- read.table("test\\y_test.txt")
Subject_Test <- read.table("test\\subject_test.txt")

X_Train_With_Labels <- mutate(X_Train,Labels_Train[,1])
X_Test_With_Labels <- mutate(X_Test,Labels_Test[,1])
X_Train_With_Labels_n_Subjects <- mutate(X_Train_With_Labels,Subject_Train[,1])
X_Test_With_Labels_n_Subjects <- mutate(X_Test_With_Labels,Subject_Test[,1])



X_merged <- data.frame(matrix(0, ncol = ncol(X_Train_With_Labels_n_Subjects), nrow = nrow(X_Train_With_Labels_n_Subjects)+nrow(X_Test_With_Labels_n_Subjects)))
X_merged[1:nrow(X_Train_With_Labels_n_Subjects),] = X_Train_With_Labels_n_Subjects
num_TrainingSamples = nrow(X_Train_With_Labels_n_Subjects)
num_TestingSamples = nrow(X_Test_With_Labels_n_Subjects)
num_AllSamples = num_TrainingSamples + num_TestingSamples
StartingROwAfterTraining = num_TrainingSamples+1
X_merged[StartingROwAfterTraining:num_AllSamples,] = X_Test_With_Labels_n_Subjects





# 3.Use descriptive activity names to name the activities in the data set
Activity_Names <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
ActivityColumnIndex = 562
index = X_merged[,ActivityColumnIndex]
#str(index)
#num [1:10299] 5 5 5 5 5 5 5 5 5 5 ...
activity_name_to_put_inDF = Activity_Names[index,2]
X_merged[,ActivityColumnIndex] = activity_name_to_put_inDF

SubjectColumnIndex = 563
#now add activity and subject column
colnames(X_merged)[ActivityColumnIndex] = "Activity_Name"
colnames(X_merged)[SubjectColumnIndex] = "Subject"


# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# I am assuming here that we need features that either contain the string "mean" or "std" in their names for the 561 features
# I will do this step after step 4 as it makes processing a bit easier (which should not affect the results)





# 4.Appropriately labels the data set with descriptive variable names. 
# read fetaure names and add names to the merged data frame X_merged
Feature_Names <- read.table("features.txt", stringsAsFactors = FALSE)
#give names to data frame X_merged
colnames(X_merged)[1:561] = Feature_Names$V2

# Now perform step 2. "Extracts only the measurements on the mean and standard deviation for each measurement."
# add as well the activity_name and subject columns
LogicalVector_Mean_STD_features = grepl("mean|std|Activity_Name|Subject",colnames(X_merged))
# get indeces where there are features including either "mean" or "std"
indeces_of_Importance = which(LogicalVector_Mean_STD_features)
X_merged_filtered = X_merged[,indeces_of_Importance]





# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyDataset_Average_acrossSubject_n_Activity = ddply(X_merged_filtered,.(Activity_Name,Subject),numcolwise(mean,na.rm = TRUE))
write.table(TidyDataset_Average_acrossSubject_n_Activity, file = "TidyDataset_Average_acrossSubject_n_Activity.txt", row.name=FALSE)




