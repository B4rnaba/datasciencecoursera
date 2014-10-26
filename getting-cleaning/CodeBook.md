---
title: "CodeBook"
author: "Barnaba Danieluk"
date: "Sunday, October 26, 2014"
output: html_document
---

##COURSE PROJECT - Getting and cleaning the data

#This is the R-script with commentary, I hopu You will find it clear and concise.

##  1. Uploading the data from my working directory (previously downloaded and extracted)

#Subjects
subjects_train <- read.table ("./UCI HAR Dataset/train/subject_train.txt")
#Activities
activities_train <- read.table ("./UCI HAR Dataset/train/y_train.txt")
#Indicator values (features)
features_train <- read.table ("./UCI HAR Dataset/train/X_train.txt")
#Merging the data with 'cbind' function
rawdata_train <- cbind(subjects_train, activities_train, features_train)
#The same for the 'test' part of data
subjects_test <- read.table ("./UCI HAR Dataset/test/subject_test.txt")
activities_test <- read.table ("./UCI HAR Dataset/test/y_test.txt")
features_test <- read.table ("./UCI HAR Dataset/test/X_test.txt")
rawdata_test <- cbind(subjects_test, activities_test, features_test)

##   2. Joining data from two parts of the study (Point 1 in Assignment Task)
#with the 'rbind' function
rawdata_all <- rbind (rawdata_test, rawdata_train)
#Removing unnecessary objects from workspace
rm(activities_test, activities_train, features_test, 
   features_train, subjects_test, subjects_train, rawdata_test, rawdata_train)

##   3. Adding variable (column) names for all the data (Point 4 in the Assignement Task)
#Making vector with first 2 column names:
first2_variable_names <- c("subjects","activities")
#All other names are extracted from 'features.txt' file
feature_names <- read.table("./UCI HAR Dataset/features.txt")
#Converting DF with feature names into character vector
feature_names_vector <- as.vector(feature_names[,2])
#Joining both vectors to obtain complete list of variables
variable_names <- c(first2_variable_names,feature_names_vector)
#Adding variable(column) names using 'colnames' function
colnames(rawdata_all) <- variable_names
#Removing used objects
rm(first2_variable_names, feature_names, feature_names_vector,variable_names)

##   4. Now it's time to select and extract measurements on the mean and standard
#deviation. You can do it by manually scan the feature names from 'feature.txt'
#and "feature_info.txt" but you can do it using R function.

#I used 'grep' function, which search for "mean" and "std" words in variable names
select_mean_variables <- grep (c("mean"), names(rawdata_all))
select_std_variables <- grep (c("std"), names(rawdata_all))

#I create variable that identifies column names for reducted dataset
#(it contains also 'subjects' and 'activities')
select_variables <- c(1,2,select_mean_variables, select_std_variables)

#Next part of the code extracts measurements on the mean and SD using created 
#variable "select_variables". It is a Point 2 of the Assignment Task
reduced_data <- rawdata_all[,select_variables]

#Removing used object
rm(select_mean_variables, select_std_variables, select_variables)

##   5. Adds descriptive activity names to variable "activities" according
#to Point 3 of the Assignment Task
#First, converts "activities" variable into factor, then adds appropriate labels
#to them (from "activity_labels.txt")
reduced_data$activities <- as.factor(reduced_data$activities)
reduced_data$activities <- factor(reduced_data$activities, labels=c("walking",
            "walking_upstairs","walking_downstairs","sitting","standing","laying"))

#    6. To create tidy dataset from step 5 I used melt and dcast functions from 'reshape2'
#package. I used 'subjects' and 'activities' variables as id, and all other variables
#as 'variables'.
library(reshape2)
variable_names2 <- names(reduced_data[3:81])
processed_data <- melt(reduced_data, id=c("subjects","activities"), 
            measure.vars=c(variable_names2))
tidy_data <- dcast(processed_data, subjects+activities~variable,mean)

#The result is the tidy_data set

