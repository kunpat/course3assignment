setwd("Data Analysis/Coursera/course3/assignment/data")
#library
library(dplyr)
library(tidyr)
#read in all the data from text files and store them as data frame
Xtestdata_subject <- read.csv("test/subject_test.txt", header = FALSE)
Xtraindata_subject <- read.csv("train/subject_train.txt", header = FALSE)
Xtrain <- read.csv("train/X_train.txt", sep = "", header = FALSE)#xtrain data read in
ytrain <- read.csv("train/y_train.txt", sep = "", header = FALSE) #ytrain data readin
ytest <- read.csv("test/y_test.txt", sep = "",header = FALSE)#ytest data read in
Xtest <- read.csv("test/X_test.txt", sep = "",header = FALSE)#Xtest data read in
features <- read.csv("features.txt", sep = "", header=FALSE)#features description read in
activityLabels <- read.csv("activity_labels.txt", sep = "", header=FALSE) #activity labels read in

#to merge data into one single data frame you have to merge train and test into its own data frame. each data frame 
#will have 3 columns....xtrain, ytrain or "y", and subject. 
#we will relable ytest, ytrain, xtrainSubject, and XtestSubject to prevent confusion
colnames(ytrain) <- "y"
colnames(ytest) <- "y"
colnames(Xtraindata_subject) <- "subject"
colnames (Xtestdata_subject) <- "subject"
TrainDataFrame <- cbind(Xtrain,ytrain, Xtraindata_subject)
TestDataFrame <- cbind(Xtest, ytest, Xtestdata_subject)

#---------------------------------1 combine data set-----------------------------------------------------------------------------
#this now merges the two seperate dataframe(test and train) into one single data frame using row combine. 
CombinedData <- rbind(TrainDataFrame, TestDataFrame)

#---------------------------------2 print mean + std from each measurement-----------------------------------------------------------------------------
meanIndex <- grep("mean()", features$V2)
stdIndex <- grep("std()", features$V2)
CombinedData[, meanIndex] #prints all columns that're mean
CombinedData[,stdIndex] #prints all columns that're standard devision

#---------------------------------3 label each activity-----------------------------------------------------------------------------
#this next line assigns activity labels to each activity in column "y" of the data
#activity and their lable is pulled from activityLables data
CombinedData$y <- factor(CombinedData$y, activityLabels$V1, labels  = activityLabels$V2)

#---------------------------------4 labeling variable names-----------------------------------------------------------------------------
#this function labels the columns using the data in features.txt. The V2 column holds the features. 
colnames(CombinedData) <- features$V2
colnames(CombinedData)
names(CombinedData)[562] <- "Activity" # applying above removes names for last 2 columns so we relable here
names(CombinedData)[563] <- "Subject"
head(CombinedData$Activity)
names(CombinedData)

#---------------------------------5 new tidy data with average-----------------------------------------------------------------------------
#Since we have duplicate column names we apply the make.unqiue function to the name. This will allow us to run the mean function 
#on each group that's broken by Activity and Subject. The group_by function creates a group by activity and subject, so each subject
#has 6 activities, or total of 180 rows can be expected after applying this function. 
#the summarize all function bascially applies the mean function in this case to all the columns of dataframe(grouped by)

#since instruction is not clear about whether they want grouped by Activity AND Subject or Activity and subject individually
#i will provide all three output. 
#1 ONE : By activity...gives total of 6 rows and all columns(features) are averaged . removing subject column as it's not needed 
tidySet_ActivityAvg <- CombinedData %>% setNames(make.unique(names(.))) %>% group_by(Activity) %>% select(-Subject) %>% summarise_all(list(mean)) %>% print()
write.table(tidySet_ActivityAvg,file = "tidySet_byActivity.txt", row.names = FALSE)
#2 TWO : By Subject...gives total of 30 rows(30 people) and all columns(features) are averaged .Removing Activity column as its not needed
tidySet_SubjectAvg <- CombinedData %>% setNames(make.unique(names(.))) %>% group_by(Subject)%>% select(-Activity) %>% summarise_all(list(mean)) %>% print()
write.table(tidySet_SubjectAvg,file = "tidySet_bySubject.txt", row.names = FALSE)

#3 THREE now grouped by Activity and Subject together so we should get total of 180 rows. 6 activities per individual(30 ind)
tidySet_ActivitySubjectAvg <- CombinedData %>% setNames(make.unique(names(.))) %>% group_by(Activity, Subject) %>% summarise_all(list(mean)) %>% print()
write.table(tidySet_ActivitySubjectAvg,file = "tidySet_byActivitySubject.txt", row.names = FALSE)
