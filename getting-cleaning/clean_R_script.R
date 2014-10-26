subjects_train <- read.table ("./data/UCI HAR Dataset/train/subject_train.txt")
activities_train <- read.table ("./data/UCI HAR Dataset/train/y_train.txt")
features_train <- read.table ("./data/UCI HAR Dataset/train/X_train.txt")
rawdata_train <- cbind(subjects_train, activities_train, features_train)

subjects_test <- read.table ("./data/UCI HAR Dataset/test/subject_test.txt")
activities_test <- read.table ("./data/UCI HAR Dataset/test/y_test.txt")
features_test <- read.table ("./data/UCI HAR Dataset/test/X_test.txt")
rawdata_test <- cbind(subjects_test, activities_test, features_test)

rawdata_all <- rbind (rawdata_test, rawdata_train)
rm(activities_test, activities_train, features_test, 
   features_train, subjects_test, subjects_train, rawdata_test, rawdata_train)

first2_variable_names <- c("subjects","activities")
feature_names <- read.table("./data/UCI HAR Dataset/features.txt")
feature_names_vector <- as.vector(feature_names[,2])
variable_names <- c(first2_variable_names,feature_names_vector)
colnames(rawdata_all) <- variable_names
rm(first2_variable_names, feature_names, feature_names_vector,variable_names)

select_mean_variables <- grep (c("mean"), names(rawdata_all))
select_std_variables <- grep (c("std"), names(rawdata_all))
select_variables <- c(1,2,select_mean_variables, select_std_variables)
reduced_data <- rawdata_all[,select_variables]
rm(select_mean_variables, select_std_variables, select_variables)


reduced_data$activities <- as.factor(reduced_data$activities)
reduced_data$activities <- factor(reduced_data$activities, labels=c("walking",
      "walking_upstairs","walking_downstairs","sitting","standing","laying"))

library(reshape2)
variable_names2 <- names(reduced_data[3:81])
processed_data <- melt(reduced_data, id=c("subjects","activities"), 
                       measure.vars=c(variable_names2))
tidy_data <- dcast(processed_data, subjects+activities~variable,mean)
