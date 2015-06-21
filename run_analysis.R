#----------------------------------------------------------------------------------  
# This script does the following:
#
#(0) CHECK FOLDER AND LOAD LIBRARIES
#      run_analysis.R should sit in this directory: /UCI HAR Dataset 
#
#(1) LOAD FILES
#
#(2) DESCRIPTIVE COLUMNS LABELS
#
#(3) SELECT MEAN AND STD COLUMNS
#      Extracts only the measurements on the mean and standard deviation for each measurement
#
#(4) MERGE FILES
#      Merges the UCI HAR training and test data sets to create one large data set
#
#(5) DESCRIPTIVE ACTIVITY NAMES
#      Uses descriptive activity names to name the activities in the data set
#
#(6) CALCULATE THE MEAN FOR EACH ACTIVITY AND SUBJECT
#
#(7) DESCRIPTIVE VARIABLE NAMES
#      Appropriately labels the data set with descriptive variable names
#
#(8) GENERATE TIDY OUTPUT FILE
#      creates a second, independent tidy data set with the average of each variable for each activity and each subject
#
# A full description of the UCI HAR Dataset is available at the site where the data was obtained: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
#----------------------------------------------------------------------------------  

#(0) CHECK FOLDER AND LOAD LIBRARIES

folder <- "/UCI HAR Dataset"
#Check if run_analysis is in the correct folder
dir <- paste("/",tail(strsplit(getwd(), "/")[[1]], 1),collapse="", sep="")
if (!(dir==folder|length(list.dirs("."))==5)) {
  message(paste("please put run_analysis.R in", folder))
} else {
  message("run_analysis.R in correct folder")
}

#If the zip file doesn't exist, download and unzip it
#if (!file.exists("Dataset.zip")) {
#  message(paste("downloading", "Dataset.zip"))
#  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#  download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
#  unzip("Dataset.zip")
#}

#If the reshape 2 library package isn't installed, install and load it
if (!("reshape2" %in% rownames(installed.packages()))) {
  ## Open required libraries
  message(paste("installing", "reshape2"))
  install.packages("reshape2")
} else {
  message("reshape2 already installed")
}
if (!("dplyr" %in% rownames(installed.packages()))) {
  ## Open required libraries
  message(paste("installing", "dplyr"))
  install.packages("dplyr")
} else {
  message("dplyr already installed")
}

library(reshape2)
library(dplyr)

#(1) LOAD FILES
#Opens Activity, Features, Test and Train files from the UCI HAR Dataset

#Activity labels
al_file <- "activity_labels.txt"
message(paste("loading", al_file))
a.df <- read.table(al_file, header = FALSE, colClasses = c("numeric","factor"))

#Features file
f_file <- "features.txt"
message(paste("loading", f_file))
feature <- read.table(f_file, header = FALSE)
#replaces all characters in square brackets with an underscore character
feat_header <- sapply(feature$V2, function(x) {gsub("[-(),]+",'_', x)}) 

#Test files
x_test_file <- "./test/X_test.txt"
y_test_file <- "./test/y_test.txt"
s_test_file <- "./test/subject_test.txt"

message(paste("loading", x_test_file))
x_test <- read.table(x_test_file, header = FALSE, colClasses = "numeric")  #using colClasses speeds up reading
message(paste("loading", y_test_file))
y_test <- read.table(y_test_file, header = FALSE, colClasses = "numeric")
message(paste("loading", s_test_file))
s_test <- read.table(s_test_file, header = FALSE, colClasses = "integer")

#Train files
x_train_file <- "./train/X_train.txt"
y_train_file <- "./train/y_train.txt"
s_train_file <- "./train/subject_train.txt"

message(paste("loading", x_train_file))
x_train <- read.table(x_train_file, header = FALSE, colClasses = "numeric")  #using colClasses speeds up reading
message(paste("loading", y_train_file))
y_train <- read.table(y_train_file, header = FALSE, colClasses = "numeric")
message(paste("loading", s_train_file))
s_train <- read.table(s_train_file, header = FALSE, colClasses = "integer")

#Merge the test and training data into a new data frames
x.df <- rbind(x_test, x_train)
y.df <- rbind(y_test, y_train)
s.df <- rbind(s_test, s_train)

#(2) DESCRIPTIVE COLUMNS LABELS
#Label the column names in the data frames
colnames(x.df) <- feat_header
colnames(y.df) <- c("activity_id")
colnames(s.df) <- c("subject_id")
colnames(a.df) <- c("activity_id", "activity_type")

#(3) SELECT MEAN AND STD COLUMNS
#Narrow down the selected feature columns only to those that contain 'mean' or 'std'
mean_std_col <- grep('mean|std', feat_header, ignore.case=TRUE)

#reduce the x data frame to contain only mean and std columns
x.df <- x.df[,mean_std_col]

#(4) MERGE FILES
#Merge all data frames which contains subject, activity and selected mean and std features
syx <- cbind(s.df, y.df, x.df)

#(5) DESCRIPTIVE ACTIVITY NAMES
#Add a column with activity type description for each activity_id
syx <- merge(syx, a.df, by="activity_id")

#(6) CALCULATE THE MEAN FOR EACH ACTIVITY AND SUBJECT
#Groups data by activity_id and subject_id

#(7) DESCRIPTIVE VARIABLE NAMES

message("calculating mean.df")
mean.df <-
  syx %>%
  group_by(activity_id, activity_type, subject_id) %>%
  select(activity_type, activity_id, subject_id, everything()) %>%
  summarise_each(funs(mean)) 

#Groups data by activity only and disregard subject_id
message("calculating mean.compact.df")
mean.compact.df <-
  mean.df %>%
  group_by(activity_id, activity_type) %>%
  select(activity_type, activity_id, everything()) %>%
  summarise_each(funs(mean))

#Drop the subject_id from the mean.compact data frame
mean.compact.df <- subset(mean.compact.df, select=-subject_id)

#(8) GENERATE TIDY OUTPUT FILE
o_file <- "./tidy_activity_mean.txt"
message(paste("writing to file", o_file))
write.table(mean.df, file=o_file, sep="\t", row.names=FALSE)

# Print out portion of data frames for inspection
rows <- 3
cols <- 12
print("printing mean.df head")
print(head(mean.df[,1:cols],n=rows))
print("printing mean.df tail")
print(tail(mean.df[,1:cols],n=rows))

print("printing mean.compact.df head")
print(mean.compact.df[,1:cols],n=6)