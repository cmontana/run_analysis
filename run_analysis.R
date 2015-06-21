#This function executes the complete analysis and it generates the TidyDataset.txt file

createTidyDataset <- function(){
  
  #include library dplyr for group_by function
  library(dplyr)
  
  #configuration variables
  testDir <- "./UCI HAR Dataset/test"   #test files directory
  trainDir <- "./UCI HAR Dataset/train" #training files directory
  labelsDir <- "./UCI HAR Dataset"      #labels activities and features files directory
  outFileDir <- "."                     #output file directory
  outFileName <- "TidyDataset.txt"      #output file name
  
  #load features file
  features <- loadFeatures(labelsDir, "features.txt")
  #rename columns
  names(features) <- c("num","name")
  #load activity labels file
  labels <- loadFeatures(labelsDir, "activity_labels.txt")
  #rename columns
  names(labels) <- c("num","activity")
  
  
  #build a widths vector including and excluding columns in order to load only mean and std variables
  widths <- ifelse(grepl("-mean",features$name) | grepl("-std",features$name) , 16 , -16)
  
  #builds a vector with valid column names with only mean and std variables and remove parenthessis and scores
  validCols <- features[grepl("-mean",features$name) | grepl("-std",features$name),"name"]
  validCols <- gsub("\\(\\)","",validCols)
  validCols <- gsub("-",".",validCols)
  
  #loads test data (subjects, observations, activities)
  subject_test <- loadData(testDir,"subject_test.txt",16)
  X_test <- loadData(testDir,"x_test.txt", widths)
  y_test <- loadData(testDir,"y_test.txt",16)
  
  
  #rename columns of observations with valid column names
  names(X_test) <- validCols
  
  #adds activities column to data frame
  X_test[,"y"] <- y_test
  
  #adds subjects column to data frame
  X_test[,"subject"] <- subject_test
  
  
 
  #loads training data (subjects, observations, activities)
  subject_train <- loadData(trainDir,"subject_train.txt",16)
  X_train <- loadData(trainDir,"x_train.txt", widths)
  y_train <- loadData(trainDir,"y_train.txt",16)
  
  #rename columns of observations with valid column names
  names(X_train) <- validCols

  #adds activities column to data frame
  X_train[,"y"] <- y_train
  
  #adds subjects column to data frame
  X_train[,"subject"] <- subject_train
  
  #append training dataset to test dataset
  mergedDF <- rbind(X_test,X_train)
  
  #merge dataset with activity labels dataset in order to introduce descriptive names
  mergedDF <- merge(mergedDF,labels, by.x="y",by.y="num")
  #remove activity numbers column
  mergedDF$y <- NULL
  
  #generate a new dataset grouping by activity and subject and calculating mean for variables
  mergedDF <- mergedDF %>% group_by(activity, subject)  %>% summarize(
    tBodyAcc.mean.X = mean(tBodyAcc.mean.X, nar.rm = TRUE), 
    tBodyAcc.mean.Y = mean(tBodyAcc.mean.Y, nar.rm = TRUE), 
    tBodyAcc.mean.Z = mean(tBodyAcc.mean.Z, nar.rm = TRUE), 
    tBodyAcc.std.X = mean(tBodyAcc.std.X, nar.rm = TRUE), 
    tBodyAcc.std.Y = mean(tBodyAcc.std.Y, nar.rm = TRUE), 
    tBodyAcc.std.Z = mean(tBodyAcc.std.Z, nar.rm = TRUE), 
    tGravityAcc.mean.X = mean(tGravityAcc.mean.X, nar.rm = TRUE), 
    tGravityAcc.mean.Y = mean(tGravityAcc.mean.Y, nar.rm = TRUE), 
    tGravityAcc.mean.Z = mean(tGravityAcc.mean.Z, nar.rm = TRUE), 
    tGravityAcc.std.X = mean(tGravityAcc.std.X, nar.rm = TRUE), 
    tGravityAcc.std.Y = mean(tGravityAcc.std.Y, nar.rm = TRUE), 
    tGravityAcc.std.Z = mean(tGravityAcc.std.Z, nar.rm = TRUE), 
    tBodyAccJerk.mean.X = mean(tBodyAccJerk.mean.X, nar.rm = TRUE), 
    tBodyAccJerk.mean.Y = mean(tBodyAccJerk.mean.Y, nar.rm = TRUE), 
    tBodyAccJerk.mean.Z = mean(tBodyAccJerk.mean.Z, nar.rm = TRUE), 
    tBodyAccJerk.std.X = mean(tBodyAccJerk.std.X, nar.rm = TRUE), 
    tBodyAccJerk.std.Y = mean(tBodyAccJerk.std.Y, nar.rm = TRUE), 
    tBodyAccJerk.std.Z = mean(tBodyAccJerk.std.Z, nar.rm = TRUE), 
    tBodyGyro.mean.X = mean(tBodyGyro.mean.X, nar.rm = TRUE), 
    tBodyGyro.mean.Y = mean(tBodyGyro.mean.Y, nar.rm = TRUE), 
    tBodyGyro.mean.Z = mean(tBodyGyro.mean.Z, nar.rm = TRUE), 
    tBodyGyro.std.X = mean(tBodyGyro.std.X, nar.rm = TRUE), 
    tBodyGyro.std.Y = mean(tBodyGyro.std.Y, nar.rm = TRUE), 
    tBodyGyro.std.Z = mean(tBodyGyro.std.Z, nar.rm = TRUE), 
    tBodyGyroJerk.mean.X = mean(tBodyGyroJerk.mean.X, nar.rm = TRUE), 
    tBodyGyroJerk.mean.Y = mean(tBodyGyroJerk.mean.Y, nar.rm = TRUE), 
    tBodyGyroJerk.mean.Z = mean(tBodyGyroJerk.mean.Z, nar.rm = TRUE), 
    tBodyGyroJerk.std.X = mean(tBodyGyroJerk.std.X, nar.rm = TRUE), 
    tBodyGyroJerk.std.Y = mean(tBodyGyroJerk.std.Y, nar.rm = TRUE), 
    tBodyGyroJerk.std.Z = mean(tBodyGyroJerk.std.Z, nar.rm = TRUE), 
    tBodyAccMag.mean = mean(tBodyAccMag.mean, nar.rm = TRUE), 
    tBodyAccMag.std = mean(tBodyAccMag.std, nar.rm = TRUE), 
    tGravityAccMag.mean = mean(tGravityAccMag.mean, nar.rm = TRUE), 
    tGravityAccMag.std = mean(tGravityAccMag.std, nar.rm = TRUE), 
    tBodyAccJerkMag.mean = mean(tBodyAccJerkMag.mean, nar.rm = TRUE), 
    tBodyAccJerkMag.std = mean(tBodyAccJerkMag.std, nar.rm = TRUE), 
    tBodyGyroMag.mean = mean(tBodyGyroMag.mean, nar.rm = TRUE), 
    tBodyGyroMag.std = mean(tBodyGyroMag.std, nar.rm = TRUE), 
    tBodyGyroJerkMag.mean = mean(tBodyGyroJerkMag.mean, nar.rm = TRUE), 
    tBodyGyroJerkMag.std = mean(tBodyGyroJerkMag.std, nar.rm = TRUE), 
    fBodyAcc.mean.X = mean(fBodyAcc.mean.X, nar.rm = TRUE), 
    fBodyAcc.mean.Y = mean(fBodyAcc.mean.Y, nar.rm = TRUE), 
    fBodyAcc.mean.Z = mean(fBodyAcc.mean.Z, nar.rm = TRUE), 
    fBodyAcc.std.X = mean(fBodyAcc.std.X, nar.rm = TRUE), 
    fBodyAcc.std.Y = mean(fBodyAcc.std.Y, nar.rm = TRUE), 
    fBodyAcc.std.Z = mean(fBodyAcc.std.Z, nar.rm = TRUE), 
    fBodyAcc.meanFreq.X = mean(fBodyAcc.meanFreq.X, nar.rm = TRUE), 
    fBodyAcc.meanFreq.Y = mean(fBodyAcc.meanFreq.Y, nar.rm = TRUE), 
    fBodyAcc.meanFreq.Z = mean(fBodyAcc.meanFreq.Z, nar.rm = TRUE), 
    fBodyAccJerk.mean.X = mean(fBodyAccJerk.mean.X, nar.rm = TRUE), 
    fBodyAccJerk.mean.Y = mean(fBodyAccJerk.mean.Y, nar.rm = TRUE), 
    fBodyAccJerk.mean.Z = mean(fBodyAccJerk.mean.Z, nar.rm = TRUE), 
    fBodyAccJerk.std.X = mean(fBodyAccJerk.std.X, nar.rm = TRUE), 
    fBodyAccJerk.std.Y = mean(fBodyAccJerk.std.Y, nar.rm = TRUE), 
    fBodyAccJerk.std.Z = mean(fBodyAccJerk.std.Z, nar.rm = TRUE), 
    fBodyAccJerk.meanFreq.X = mean(fBodyAccJerk.meanFreq.X, nar.rm = TRUE), 
    fBodyAccJerk.meanFreq.Y = mean(fBodyAccJerk.meanFreq.Y, nar.rm = TRUE), 
    fBodyAccJerk.meanFreq.Z = mean(fBodyAccJerk.meanFreq.Z, nar.rm = TRUE), 
    fBodyGyro.mean.X = mean(fBodyGyro.mean.X, nar.rm = TRUE), 
    fBodyGyro.mean.Y = mean(fBodyGyro.mean.Y, nar.rm = TRUE), 
    fBodyGyro.mean.Z = mean(fBodyGyro.mean.Z, nar.rm = TRUE), 
    fBodyGyro.std.X = mean(fBodyGyro.std.X, nar.rm = TRUE), 
    fBodyGyro.std.Y = mean(fBodyGyro.std.Y, nar.rm = TRUE), 
    fBodyGyro.std.Z = mean(fBodyGyro.std.Z, nar.rm = TRUE), 
    fBodyGyro.meanFreq.X = mean(fBodyGyro.meanFreq.X, nar.rm = TRUE), 
    fBodyGyro.meanFreq.Y = mean(fBodyGyro.meanFreq.Y, nar.rm = TRUE), 
    fBodyGyro.meanFreq.Z = mean(fBodyGyro.meanFreq.Z, nar.rm = TRUE), 
    fBodyAccMag.mean = mean(fBodyAccMag.mean, nar.rm = TRUE), 
    fBodyAccMag.std = mean(fBodyAccMag.std, nar.rm = TRUE), 
    fBodyAccMag.meanFreq = mean(fBodyAccMag.meanFreq, nar.rm = TRUE), 
    fBodyBodyAccJerkMag.mean = mean(fBodyBodyAccJerkMag.mean, nar.rm = TRUE), 
    fBodyBodyAccJerkMag.std = mean(fBodyBodyAccJerkMag.std, nar.rm = TRUE), 
    fBodyBodyAccJerkMag.meanFreq = mean(fBodyBodyAccJerkMag.meanFreq, nar.rm = TRUE), 
    fBodyBodyGyroMag.mean = mean(fBodyBodyGyroMag.mean, nar.rm = TRUE), 
    fBodyBodyGyroMag.std = mean(fBodyBodyGyroMag.std, nar.rm = TRUE), 
    fBodyBodyGyroMag.meanFreq = mean(fBodyBodyGyroMag.meanFreq, nar.rm = TRUE), 
    fBodyBodyGyroJerkMag.mean = mean(fBodyBodyGyroJerkMag.mean, nar.rm = TRUE), 
    fBodyBodyGyroJerkMag.std = mean(fBodyBodyGyroJerkMag.std, nar.rm = TRUE), 
    fBodyBodyGyroJerkMag.meanFreq = mean(fBodyBodyGyroJerkMag.meanFreq, nar.rm = TRUE)
  )
  
  #export data frame to txt file
  write.table(mergedDF,file=paste(outFileDir,outFileName,sep="/"), row.name=FALSE)
  

}

#this function loads data from a fixed widths file
loadData <- function(directory, filename, widths){
  newData <- read.fwf(file=paste(directory,"/",filename,sep=""), header=FALSE,widths=widths)
    newData
}

#this function loads data from a csv file
loadFeatures <- function(directory, filename, numcolumns){
  newData <- read.csv(file=paste(directory,"/",filename,sep=""), header=FALSE,sep=" ")
  newData
}


