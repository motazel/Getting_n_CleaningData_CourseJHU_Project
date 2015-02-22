The "run_analysis.R" performs the following 5 transformation steps 

# 1.Merges the training and the test sets to create one data set.
This part first reads the Train.txt, Labels.txt (for training data) and subject data (for training) and then does the same for test data. It concatenates the data + labels + subjects using mutate. It then merges the train and test data in one data frame called "X_merged"
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
Output of this step is a filtered data frame X_merged_filtered with only features we care about (mean and standard deviation ones)
# 3.Uses descriptive activity names to name the activities in the data set
Instead of 1,2,3,4,5,6 use more descriptive activity names in the data frame X_merged_filtered
# 4.Appropriately labels the data set with descriptive variable names. 
Output of this step is a merged data frame X_merged with feature names read form "features.txt" 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Uses group_by function to summarize the cleaned up data frame and then uses write.table to write it in a file.


