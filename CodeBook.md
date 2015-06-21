Dataset 
=================
Each observation for generated dataset has 81 variables:

activity: activity name performed
subject: number of the subject who is performing activity

Next variables are the mean of features that come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Transformation
=================
The output data is an aggregation from both testing and training datasets, and contains only the measurements on the mean and standard deviation for each measurement.

Transformation steps are described bellow:

1. Load features.txt and activity_labels.txt into dataframes
2. build a widths vector including and excluding columns in order to load only mean and std variables
3. load test data (subjects, observations, activities)
4. Rename columns of testing observations with valid column names
5. add activities and subjects columns to testing data frame
6. load training data (subjects, observations, activities)
7. Rename columns of training observations with valid column names
8. add activities and subjects columns to training data frame
9. append training dataset to test dataset
10. merge dataset with activity labels dataset in order to introduce descriptive names and remove activity numbers column
11. generate a new dataset grouping by activity and subject and calculating mean for variables
12. export generated data frame to txt file



