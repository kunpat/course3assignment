This readme is written for Course #3 or "Getting and Cleaning Course" project. The project requires data to be downloaded from following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is structured with root folder containing readme.txt and other text files with information on the data variables. The measurement data is contained in folders
"test" and "train". Each containing 3 text files and one sub-folder. The file contains the data used for run_analysis. 

HOW TO RUN THE RUN_ANALYSIS.R FILE:
1. Download the data set in the zip file link above. 
2. Extract the data in a folder
3. Drop the run_analysis.R file in the "data" folder
4. Load the .R file in "R" program. 
5. Execute will yield total of 3 files. Further explanation is provided below. The screen in R will also output data. 

SECTIONS of RUN_ANALYSIS.R
1. The first section reads in all the text files. Xtrain, ytrain, Xtest, ytest, subject, features and activitylabels
2. The read data columns are renamed to prevent confusion and then using CBIND it's combined. Yielding two data sets with 563 columns each for TRAIN and TEST
3. Each section from here on is labeled as comment ---------------------Question # and title---------------------
4. First section 1, combines the data into one single data frame consisting of 563 columns (features are 561 but we combined ytrain/ytest and also the subject). The remaining 561 columns
	are all the activities(refer to activityLabels.txt in data folder for more info)
5. Next section 2, now we search for the words "mean()" and "std()" in our features data frame and get their index number. The feature data frame contains all the 561 features...which are
	also the columnsin our combined data frame. 
6. Once we get the index# for mean and std(), we pass this to CombinedData dataframe to pull out the mean and std features. 
7. Next you label each activity, this is using factor function. 
8. Next section you label all the features which are currently V1....V561. you do this by calling colnames function and assigning the feature$V2(which contains names of all the features)
9. Next you have to average each feature by Activity, Subject, and Activity AND Subject(The instructions wasn't clear so i did all three). 
10. Before you can group and find average of each variable(feature) by activity and subject you need to fix the duplicate names in our column names. you use setname(make.unique(. )) function
	which basically adds ".x" x = integer to any duplicates. 
11. I grouped the tidy data first by Activity, then by subject, and finally by Activity AND Subject. you apply summarize_all(list(mean)) function to get mean for all the variables for 561 columns. 
12. The output is in three separate text files. The activity files contains 6 rows since we average each varaible by activity. Subject data is 30 rows since total of 30 subjects were used
	and when we group by activity and subject we have total of 180 rows, since each subject is performing 6 activities each. 30 X 6 = 180 rows. 



