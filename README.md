## Getting and Cleaning Data
## Course project
Readme.md  
  
### Requirements:
	DataSource: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	(A description of the data and files exists in the Readme.txt)

### Preparations:
	- Donload the ZIP file
	- Unzip the sourcefile to the working directory (A subfolder "UCI HAR Dataset" will be created

### Action:
	- Run the R script (run_analysis.R)

### Result:
	Two Files are created:
	- "Tidy UCI HAR Dataset.txt"
	- "TidyGroup UCI HAR Dataset.txt"

## Description of the script:
- Loading package dplyr
- Set a var "TestRows" for faster checks during the developing phase, finally it must be -1
- Setting the main sub-directory where the prog finds the data 

- Imports the "Feature list" (561 obs)
  - Identify the coloums of Mean and Standard Deviation (66 obs)
  - Clean the col-data -> delete () and ,
  - Set a var "featurelistheader" of the cleaned colums 

- Imports the "Activity labels" 

- Imports the "Test-data"
  - Set Subdirectory where the test data exists
  - Reads the Data to "XTestData" and sets the appropiate col-names (2947 obs. x 561 vars)
  - Reads the Labels to "YTestData" and sets col-name to "Activity" (2947 obs. x 1 var)
  - Reads the Subjects to "STestData" and sets col-name to "Subject" (2947 obs. x 1 var)

- Imports the "Training-data"
  - Set Subdirectory where the training data exists
  - Reads the Data to "XTrainData" and sets the appropiate col-names (7352 obs. x 561 vars)
  - Reads the Labels to "YTrainData" and sets col-name to "Activity" (7352 obs. x 1 var)
  - Reads the Subjects to "STrainData" and sets col-name to "Subject" (7352 obs. x 1 var)

- Merging Test-data and Training-data
  - XData (10299 obs. x 561 vars)
  - YData (10299 obs. x 1 var)
  - SData (10299 obs. x 1 var)

- Create a dataset with all cols of Mean and Standard Deviation (10299 obs. 66 vars)

- Replace the numbers of the activites "YData" to readable activity names

- Combine the three data sets (Subject, Activity and (Mean and Standard Deviation)) 
  into TidyDataSet (10299 obs. x 68 vars)

- Write to first file "Tidy UCI HAR Dataset.txt"

- Create a data frame table of the TidyDataSet 

- Create a grouped data frame table by the cols Activity and Subject

- Summarise by the grouped cols and use the function mean for the rest of the cols  
  The result is stored in "FinalGroupTidyDataSet" (180 obs. x 68 vars)

- Write to second file "TidyGroup UCI HAR Dataset.txt"
  