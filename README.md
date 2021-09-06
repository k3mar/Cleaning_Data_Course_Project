# Cleaning_Data_Course_Project
1) The run_analysis script starts by installing the dplyr ackage and loading it.
2) The UCI HAR Dataset is downlaoded from the url link and unzipped in the current working directory.
3) The test and train data is read from the text files.
4) The datasets are then merged into one dataset.
5) Extracts the measurements related to mean and standard deviation for each measurement from the feature.txt file using the grep function aand use it to subset data frame.
6) Use the gsub function to expand  feature names and remove special characters from feature.txt file .
7) Use the renamed feature names to name the columns of the merged dataset. 
8) Use mutate along with factors fucntion to replace numerical values for activites with their full names from the activity_labels files to create final tidy dataset.
9) Use the group_by function to group dataset by subjects and activites variable.
10) The grouped dataset is applied to the summarize_all function to find the mean for each varible in the dataset.

The dataframe final_data contains the final tidy dataset.
The dataframe summarized_means contains the final data showing the average of each variable for each activity and each subject.
