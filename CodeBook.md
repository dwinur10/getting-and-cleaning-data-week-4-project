# CodeBook

This document is a codebook that provides descriptions of the variables, the data, and all transformations and work that I performed to clean up the data.

The `run_analysis.R` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

### 1. Download the dataset
  * Dataset downloaded and extracted under the folder called "Cleaning Data"


### 2. Assign each data to variables
  * `ft.names` <- `UCI HAR Dataset/features.txt` : 561 rows, 2 columns
  * `act.label` <- `UCI HAR Dataset/activity_labels.txt` : 6 rows, 2 columns
  * `sub.test` <- `UCI HAR Dataset/test/subject_test.txt` : 2947 rows, 1 column
  * `ft.test` <- `UCI HAR Dataset/test/X_test.txt` : 2947 rows, 561 columns
  * `act.test` <- `UCI HAR Dataset/test/y_test.txt` : 2947 rows, 1 columns
  * `sub.train` <- `UCI HAR Dataset/train/subject_train.txt` : 7352 rows, 1 columns
  * `ft.train` <- `UCI HAR Dataset/train/X_train.txt` : 7352 rows, 561 columns
  * `act.train` <- `UCI HAR Dataset/train/y_train.txt` : 7352 rows, 1 columns


### 3. Merges the training and the test sets to create one data set
  - #### Assigning variable name
    * Name `act.test` and `act.train` column by `Activity` using `names()` function
    * Name `ft.test` and `ft.train` columns by all character in second column of `ft.names` using `names()` function
    * Name `sub.test` and `sub.train` column by `Subject` using `names()` function
  - #### Merge all data frame into one set
    * `by.test` (2947 rows, 563 columns) is created by merging `sub.test`, `act.test and `ft.test` using `cbind()` function
    * `by.train` (7352 rows, 563 column) is created by merging `sub.train`, `act.train and `ft.train` using `cbind()` function
    * `alldata` (10299 rows, 563 column) is created by merging `by.test` and `by.train` using `rbind()` function

### 4. Extracts only the measurements on the mean and standard deviation for each measurement
  - `TidyData` (10299 rows, 68 columns) is created by subsetting `alldata`, selecting only columns: `Subject`, `Activity` and the measurements on the mean and standard deviation (std) for each measurement

### 5. Uses descriptive activity names to name the activities in the data set
  - Entire numbers in `Activity` column of the `TidyData` replaced with corresponding activity taken from second column of the `act.label` variable

### 6. Appropriately labels the data set with descriptive variable names
  * All start with character `t` in column’s name replaced by `Time`
  * All start with character `f` in column’s name replaced by `Frequency`
  * All `Acc` in column’s name replaced by `Accelerometer`
  * All `BodyBody` in column’s name replaced by `Body`
  * All `Gyro` in column’s name replaced by `Gyroscope`
  * All `Mag` in column’s name replaced by `Magnitude`
  
### 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  * `TidyData2` (180 rows, 68 columns) is created by sumarizing `TidyData` taking the means of each variable for each activity and each subject, after groupped by `Subject` and `Activity`.

### 8. Create txt file from this tidy data
  * Export `TidyData` into `TidyData.txt` file.
