#load Libraries
library(reshape2)
library(dplyr)
library(tidyr)

#File name to be downloaded
filename <- "./data/Dataset.zip"

#Assign URL and download the zipped data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,filename)

#Unzip dataSet to /data directory
unzip(filename,exdir="./data")

#Read training data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)

#Read testing data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)

#Read Features 
features <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

#Read Activity Labels 
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

#Assign Column Names From Features to datasets
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

#Assign names for new columns post cbind
colnames(y_test) <- "activity"
colnames(y_train) <- "activity"

colnames(subject_test) <- "subject"
colnames(subject_train) <- "subject"

#Merge All Testing Data - Subject + Activities(y) + Results(x)
merge_test <- cbind(subject_test, y_test, x_test)

#Merge All training Data - Subject + Activities(y) + Results(x)
merge_train <- cbind(subject_train, y_train, x_train)

#Merge All Data
merge_all <- rbind(merge_test,merge_train)

#Find list of all relevant columns. include all standard deviations(std) and means 
columnList <- grep("subject|activity|*std*|*mean*" , colnames(merge_all)) 

#Create new table with only relevent data
finalData <- merge_all[,columnList]
finalData <- arrange(finalData, subject)

#Change Activites and Subjects to factors. Assign activity with labels instead of numbers using Labels 
finalData$activity <- factor(finalData$activity, levels = activities[,1], labels = activities[,2])
finalData$subject <- as.factor(finalData$subject)

#Two ways to reach the final tidy dataset with mean values 
#Approach 1. Melt and Cast 
finalDataMelt <- melt(finalData, id = c("subject", "activity"))
finalDataMean <- dcast(finalDataMelt, subject + activity ~ variable, mean)
write.table(finalDataMean, "tidyData.txt", row.names = FALSE, quote = FALSE)

#Approach 2. Use Aggregate function on subject and activity together
tidyDataSet <- aggregate(. ~subject + activity, finalData, mean)
write.table(tidyDataSet, "tidyDataSet.txt", row.names = FALSE, quote = FALSE)
