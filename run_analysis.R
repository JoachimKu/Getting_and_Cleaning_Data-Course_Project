#
# Getting and Cleaning Data
#
# Course project
#
# The data for the project is saved in the subfolder "mainsubdir"
# Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#
# The goal is to prepare a tidy data that can be used for later analysis
#
# 2 Files are created:
# - "Tidy UCI HAR Dataset.txt"
# - "TidyGroup UCI HAR Dataset.txt"
#

# load package dplyr for later
library(dplyr)

# 
TestRows <- -1      # Standard: -1  /  TestRows: <number> of test rows

# Set the main sub-directory
mainsubdir <- "./UCI HAR Dataset/"

# Read the names of the feature list
fname<-paste(mainsubdir,"features.txt", sep="")             # set file name
featurelist<- read.table(fname, sep=" ", header=FALSE)      # read file

maxfeaturelistrows <- nrow(featurelist)                     # eval max headers
featurelistheader <- featurelist[1:maxfeaturelistrows,2]    # list headers
# Identify cols of Mean and Standard Deviation for later col reduction
# ATT: Include just the cols with "mean(" and "std("
MSCols <- sort(c(grep("mean\\(",featurelistheader), grep("std\\(",featurelistheader)))

# clean col-data
featurelist[,2]<-gsub(",", "_", featurelist[,2])            # replace "," with "_"
featurelist[,2]<-gsub("\\(\\)", "", featurelist[,2])        # delete "()"
featurelist[,2]<-gsub("\\(|\\)", ".", featurelist[,2])      # replace "(" or ")" with "."

featurelistheader <- featurelist[1:maxfeaturelistrows,2]    # list headers

# Read the names of the activity labels
fname<-paste(mainsubdir,"activity_labels.txt", sep="")
activitylist<- read.table(fname, sep=" ", header=FALSE)

#-------------- Read Test-data
# Assemble subdirectory and filenames
datatype <- "test"
datadir <- paste(mainsubdir,datatype,"/", sep="")
xdatafname <- paste(datadir,"X_",datatype,".txt", sep="")
ydatafname <- paste(datadir,"y_",datatype,".txt", sep="")
subjectfname <- paste(datadir,"subject_",datatype,".txt", sep="")

# Read Test-Data
XTestData <- read.table(xdatafname, nrows= TestRows, col.names=featurelistheader)    # read file with headers
YTestData <- read.table(ydatafname, nrows= TestRows, col.names="Activity")
STestData <- read.table(subjectfname, nrows= TestRows, col.names="Subject")

#-------------- Read Train-data
# Assemble subdirectory and filenames
datatype <- "train"
datadir <- paste(mainsubdir,datatype,"/", sep="")
xdatafname <- paste(datadir,"X_",datatype,".txt", sep="")
ydatafname <- paste(datadir,"y_",datatype,".txt", sep="")
subjectfname <- paste(datadir,"subject_",datatype,".txt", sep="")

# Read Test-Data
XTrainData <- read.table(xdatafname, nrows= TestRows, col.names=featurelistheader)    # read file with headers
YTrainData <- read.table(ydatafname, nrows= TestRows, col.names="Activity")
STrainData <- read.table(subjectfname, nrows= TestRows, col.names="Subject")

#--------------  Merge data               (Task 1)
# Merging Test and Train data
XData <- rbind(XTestData, XTrainData)
YData <- rbind(YTestData, YTrainData)
SData <- rbind(STestData, STrainData)

#-------------- Create reduced data set   (Task 2)
# Create Dataset with all cols of Mean and Standard Deviation
MSData <- XData[,MSCols]

#-------------- Create reduced data set   (Task 3)
# Replace the numbers to activity names
YData[,1] <- activitylist[YData[,1],2]

#-------------- Combine the data sets and write to file   (Task 4)
#   Subject, Activity and (Mean and Standard Deviation)
TidyDataSet <- cbind(SData, YData, MSData)
write.table(TidyDataSet, "Tidy UCI HAR Dataset.txt", row.names=FALSE)

#-------------- Create dataset with the avg of each var for each actifity and each subject  (Task 5)
tbldata <- tbl_df(TidyDataSet)
GroupTidyDataSet <- group_by(tbldata, Activity, Subject)                # grouping by Subject and Activity
FinalGroupTidyDataSet <- summarise_each(GroupTidyDataSet, funs(mean))   # sum for each var
write.table(FinalGroupTidyDataSet, "TidyGroup UCI HAR Dataset.txt", row.names=FALSE)

## Remove (almost) everything in the working environment.
## You will get no warning, so don't do this unless you are really sure.
#rm(list = ls())
