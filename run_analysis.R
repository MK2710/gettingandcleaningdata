run_analysis <- function(){
        #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        #              destfile = "gettingdata_endproject.zip")
        
        #unzip("gettingdata_endproject.zip")
        
        library(dplyr)
        
        #load data, add variable names
        
        test_set <- read.table("UCI HAR Dataset\\test\\X_test.txt")
        test_labels <- read.table("UCI HAR Dataset\\test\\y_test.txt")
        test_subjects <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
        
        train_set <- read.table("UCI HAR Dataset\\train\\X_train.txt")
        train_labels <- read.table("UCI HAR Dataset\\train\\y_train.txt")
        train_subjects <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
        
        variable_names <- read.table("UCI HAR Dataset\\features.txt")
        variable_names <- variable_names[,2]
        
        names(test_subjects) <- "subject"
        names(train_subjects) <- "subject"
        
        dim(test_labels)
        dim(test_set)
        dim(train_labels)
        dim(train_set)
        dim(variable_names)
        variable_names[1:10]
        
        names(test_set) <- variable_names
        names(train_set) <- variable_names
        names(test_labels) <- "activity"
        names(train_labels) <- "activity"
        
        names(test_set)[1:10]
        names(train_set)[1:10]
        names(test_labels)
        names(train_labels)
        
        #merge data
        test_set <- cbind(test_subjects, test_labels, test_set)
        train_set <- cbind(train_subjects, train_labels, train_set)
        complete_set <- rbind(test_set, train_set)
       
         # reduce dataset to mean and std of measurements
        slice_for_mean_std <- grepl("subject|activity|[Mm]ean|std",names(complete_set))
        complete_set <- complete_set[,slice_for_mean_std]
        
        # rename activities
        activity_names <-read.table("UCI HAR Dataset\\activity_labels.txt")
        
        activity_names <- activity_names[,2]
        
        complete_set_2 <- complete_set
        nr_rows <- nrow(complete_set)
        for (i in 1:nr_rows){
                
                complete_set_2[i,2]<- as.character(activity_names[complete_set[i,2]])
                
                
        }
        
        # Question 4: desciptive variable names:
        
        
        descriptive_variable_names <- vector(mode = "character")
        descriptive_variable_names[1] <- "subject"
        descriptive_variable_names[2] <- "activity"
        
        for (i in 3:length(names(complete_set_2))){
                
                if(!grepl("^angle", names(complete_set_2[i]))){
                        if (grepl( "^t", names(complete_set_2[i]))){
                                domain <- "in the time domain" 
                        }else{
                                domain <- "in the frequency domain" 
                        }
                        
                        
                        if (grepl( "Body", names(complete_set_2[i]))){
                                body_or_gravity <- "Body" 
                        }else{
                                body_or_gravity <- "Gravity"
                        }
                        
                        if (grepl( "Acc", names(complete_set_2[i]))){
                                accelerometer_or_gyroscope <- "accelerometer" 
                        }else{
                                accelerometer_or_gyroscope <- "gyroscope"
                        }
                        
                        if (grepl( "X$", names(complete_set_2[i]))){
                                dimension <- "in X dimension" 
                        }
                        
                        if (grepl( "Y$", names(complete_set_2[i]))){
                                dimension <- "in Y dimension" 
                        }    
                        
                        if (grepl( "Z$", names(complete_set_2[i]))){
                                dimension <- "in Z dimension" 
                        }
                        
                        if (grepl( "mean", names(complete_set_2[i]))){
                                data_type <- "mean of" 
                        }
                        
                        if (grepl( "meanFreq", names(complete_set_2[i]))){
                                data_type <- "frequency mean of" 
                        }
                        
                        
                        if (grepl( "std", names(complete_set_2[i]))){
                                data_type <- "st. dev. of" 
                        }
                        
                        if (grepl( "Jerk", names(complete_set_2[i]))){
                                Jerk <- "Jerking motions" 
                        }else{
                                Jerk <- ""
                        }      
                        
                        if (grepl( "Mag", names(complete_set_2[i]))){
                                magnitude <- "magnitude of" 
                        }else{
                                magnitude <- ""
                        }
                        
                        descriptive_variable_names[i] <- paste(data_type, magnitude, body_or_gravity, 
                                                               accelerometer_or_gyroscope, Jerk, dimension, domain)
                        
                }else{
                        descriptive_variable_names[i] <- gsub("\\(t", "\\(time domain ", names(complete_set_2[i]))
                        descriptive_variable_names[i] <- gsub("Body", "Body ", descriptive_variable_names[i])
                        descriptive_variable_names[i] <- gsub("Acc", "acceleration ", descriptive_variable_names[i])
                        descriptive_variable_names[i] <- gsub("Gyro", "gyroscope ", descriptive_variable_names[i])
                        descriptive_variable_names[i] <- gsub("Jerk", "Jerk ", descriptive_variable_names[i])
                        descriptive_variable_names[i] <- gsub("gravity", "gravity ", descriptive_variable_names[i])
                        #descriptive_variable_names[i] <- names(complete_set_2[i])
                }
                
                
        }
        names(complete_set_2) <- descriptive_variable_names
        
        # 5 create a second, independent tidy data set with the average of each variable for each activity and each subject.
        average_data_set <- aggregate(complete_set_2[, 3:88], by = list(complete_set_2$subject, complete_set_2$activity), mean)
        
        names(average_data_set)[1] <- "subject"
        names(average_data_set)[2] <- "activity"
        
        write.table(average_data_set, file = "tidy_data.txt", row.name = FALSE)
        
}