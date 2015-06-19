# smart-phone-tracker
a script for generating tidy data set for statistically analsysis

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Steps to work on this course project:
1.Download and unzip the file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) under current working directly. You will obtain data file “UCI HAR Dataset”.
2. Create run_analysis.R under folder “UCI HAR Dataset”. Set “./UCI HAR Dataset” as working directly by setwd().

This run_analysis.R script perform the following work about this data file:
a.Reformat the test and train data set separately, using measurement variables as column names. Two separate columns subject (30 volunteers) and activity (6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) are added to each data set.
b. Merge two data sets (train and test) into complete data set (completedata)
c. Subset completedata from step2 with column names containing activity, subject, mean(), and std(). The columns names with “meanFreq()” is not considered as mean value calculation since it is weighted average of the frequency components to obtain a mean frequency.
d. Replace column “ activity” with meaning content (6 activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). It creates a data file called completedata_sub.
e. Use reshape2 library to melt and dcast the completedata_sub file using “subject” and “activity” as ID variable. Calculate mean for the measurement variables. 
3. Run source(run_analysis.R), it will generate “tidy.data.txt” under folder
UCI HAR Dataset.


