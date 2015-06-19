#1.Read features.txt file as “measurements” , convert its content into a factor list, it is used
#as descriptive columns in the final data set.
library(data.table)
measurements <- read.table("./features.txt", sep="")
measurements <- as.character(measurements[,1])


#2.Prepare complete test (include Subject, Activity and Descriptive column names) dataset by following 5 steps
#a. read raw data (test/X_test.txt) into R, save it as “test_raw”
test_raw <- read.table("./test/X_test.txt",sep="")  

#b. read test subject data (test/subject_test.txt) into R, save it as “test_subject”, convert it as factor list 
test_subject <- read.table("./test/subject_test.txt")
test_subject <- test_subject[,1]

#c. read test activity data (test/y_test.txt) into R, save it as “test_activity”
test_activity <- read.table("./test/y_test.txt")
test_activity <- test_activity[,1]

#d. replace test_raw’s column names with character vector “measurements” from step 1, save as “test_raw_rn”
setnames(test_raw, old = names(test_raw), new = measurements)

#e. column bind the subject and activity columns into test_raw, save as “test_full”, replace col1, col2’s name as “subject”, “activity”
test_full <- cbind(test_subject, test_activity, test_raw)
setnames(test_full, old = c("test_subject", "test_activity"), new = c("subject", "activity"))

#3. Preparing complete train (include Subject, Activity and Descriptive column names) dataset by following 4 steps


#a. read raw data (train/X_train.txt) into R, save it as “train_raw”
train_raw <- read.table("./train/X_train.txt",sep="")

#b. read test subject data (train/subject_train.txt) into R, save it as “train_subject”, convert it as factor list 
train_subject <- read.table("./train/subject_train.txt")
train_subject <- train_subject[,1]

#c. read test activity data (train/y_train.txt) into R, save it as “train_activity”
train_activity <- read.table("./train/y_train.txt")
train_activity <- train_activity[,1]

#d. replace train_raw’s column names with character vector “measurements” from step 1, save as “train_raw_rn”
setnames(train_raw, old = names(train_raw), new = measurements)

#e. cbind subject and activity columns into “train_raw”, save as “train_full”, replace col1, col2’s name as “subject”, “activity”                                       
train_full <- cbind(train_subject, train_activity, train_raw)
setnames(train_full, old = c("train_subject", "train_activity"), new = c("subject", "activity"))

#4. Merge data sets “train_full” and “test_full”, save as “completedata”
completedata <- rbind(train_full, test_full)

#5. Extract “completedata” with column names contain “mean( )” or “std( )”, save as "completedata_sub
criteria <- grep("subject|activity|(mean\\(\\))|(std\\(\\))",names(completedata))
completedata_sub <- completedata[,criteria]
colh <- colnames(completedata_sub)
colnames(completedata_sub)<- make.names(colh)

#6. Replace the column “activity” content with descriptive names
completedata_sub$activity[completedata_sub$activity == 1] <- "WALKING"
completedata_sub$activity[completedata_sub$activity == 2] <- "WALKING_UPSTAIRS"
completedata_sub$activity[completedata_sub$activity == 3] <- "WALKING_DOWNSTAIRS"
completedata_sub$activity[completedata_sub$activity == 4] <- "SITTING"
completedata_sub$activity[completedata_sub$activity == 5] <- "STANDING"
completedata_sub$activity[completedata_sub$activity == 6] <- "LAYING"


#7. Use library(reshape2) , identify “subject” and “activity” as ID, and perform mean calculation on the measurement variables.
library(reshape2)
completedata_submelt <- melt(completedata_sub, id=c("subject", "activity"))
completedata_final <- dcast(completedata_submelt, subject + activity ~ variable, mean)
write.table(completedata_final, file="./tidy_data.txt")
           

