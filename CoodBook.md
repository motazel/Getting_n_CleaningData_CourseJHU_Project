The "run_analysis.R" performs the following 5 transformation steps 

# 1.Merge the training and the test sets to create one data set
This part reads first the Train.txt, Labels.txt (for training data) and subject data (for training) files and then does the same for the test data. It concatenates the data + labels + subjects using the mutate function. It then merges the train and test data in one data frame called "X_merged".
# 2.Extract only the measurements on the mean and standard deviation for each measurement
Output of this step is a filtered data frame X_merged_filtered with only features we care about (mean and standard deviation ones in this case)
# 3.Use descriptive activity names to name the activities in the data set
Instead of the activities being labeled by numerics: 1,2,3,4,5,6 use more descriptive activity names in the data frame X_merged_filtered
# 4.Appropriately label the data set with descriptive variable names
Output of this step is a merged data frame X_merged with feature names read from "features.txt" 
# 5.From the dataset in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
Uses group_by function to summarize the cleaned up and filtered data frame "X_merged_filtered" and then uses write.table to write it to a file "TidyDataset_Average_acrossSubject_n_Activity.txt".


