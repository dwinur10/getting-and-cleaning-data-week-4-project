
# library(dplyr)

# Download the Data set
      if(!file.exists("./Cleaning Data")){dir.create('./Cleaning Data')}
      fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      download.file(fileurl, destfile = './Cleaning Data/projectdataset.zip')
      
# Unzip the Data set
      unzip('./Cleaning Data/projectdataset.zip', exdir = './Cleaning Data')
      
      
## 0 Start to reading files
      
      # Read training data
      act.train <- read.table('./Cleaning Data/UCI HAR Dataset/train/y_train.txt', header = F)
      ft.train <- read.table('./Cleaning Data/UCI HAR Dataset/train/X_train.txt', header = F)
      sub.train <- read.table('./Cleaning Data/UCI HAR Dataset/train/subject_train.txt', header = F)
      
      # Read test data
      act.test <- read.table('./Cleaning Data/UCI HAR Dataset/test/y_test.txt', header = F)
      ft.test <- read.table('./Cleaning Data/UCI HAR Dataset/test/X_test.txt', header = F)
      sub.test <- read.table('./Cleaning Data/UCI HAR Dataset/test/subject_test.txt', header = F)
      
      # Read activity labels
      act.label <- read.table('./Cleaning Data/UCI HAR Dataset/activity_labels.txt', header = F)
      
      # Read feature names
      ft.names <- read.table('./Cleaning Data/UCI HAR Dataset/features.txt', header = F)

      
## 1 Merges the training and the test sets to create one data set.
      
      # 1.1 Assigning variable names
      names(act.train) <- 'Activity'
      names(ft.train) <- ft.names[,2]
      names(sub.train) <- 'Subject'
      
      names(act.test) <- 'Activity'
      names(ft.test) <- ft.names[,2]
      names(sub.test) <- 'Subject'
      
      names(act.label) <- c('Activity', 'ActivityType')
      
      # 1.2 Merge all data frame into one set
      by.train <- cbind(sub.train, act.train, ft.train)
      by.test <- cbind(sub.test, act.test, ft.test)
      alldata <- rbind(by.train, by.test)

## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
      ft.colnames <- ft.names$V2[grep("mean\\(\\)|std\\(\\)",ft.names$V2)]
      dat.colnames <- c('Subject', 'Activity', as.character(ft.colnames))
      TidyData <- subset(alldata, select = dat.colnames)
      
      
## 3 Uses descriptive activity names to name the activities in the data set
      for (x1 in 1:6) {TidyData$Activity [(as.character(TidyData$Activity) == x1)] <- as.character(act.label[x1,2])
         
      }

      
## 4 Appropriately labels the data set with descriptive variable names.
      names(TidyData) <- gsub('^t','Time', names(TidyData))
      names(TidyData) <- gsub('^f', 'Frequency', names(TidyData))
      names(TidyData) <- gsub('Acc', 'Accelerometer', names(TidyData))
      names(TidyData) <- gsub('BodyBody', 'Body', names(TidyData))
      names(TidyData) <- gsub('Gyro', 'Gyroscope', names(TidyData))
      names(TidyData) <- gsub('Mag', 'Magnitude', names(TidyData))
      
      
## 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      TidyData2 <- aggregate(.~ Subject + Activity, TidyData, mean)
      TidyData2 <- TidyData2[order(TidyData2$Subject,TidyData2$Activity), ]
      
# Create txt file from this tidy data
      write.table(TidyData2, file = './Cleaning Data/TidyData.txt', row.names = F)
      
# E N D