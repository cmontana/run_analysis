==================================================================
Human Activity Recognition Using Smartphones Tidy Dataset
Version 1.0
==================================================================
César Montaña
==================================================================


Scripts below generates a tidy datased based on testing and training observations of cellprhones sensors.


includes the following files:
=========================================

- 'README.md'

- 'CodeBook.md': Describes the variables, the data, and any transformations or work performed to clean up the data

- 'run_analysis.R': Contains script that transform and export data to output file



Script execution
=========================================

1. configure script
	a. open run_analysis.R file
	b. modify configuration variables:

  #configuration variables
  testDir <- "./UCI HAR Dataset/test"   #test files directory
  trainDir <- "./UCI HAR Dataset/train" #training files directory
  labelsDir <- "./UCI HAR Dataset"      #labels activities and features files directory
  outFileDir <- "."                     #output file directory
  outFileName <- "TidyDataset.txt"      #output file name

2. execute transformation

> source("run_analysis.R")
> createTidyDataset()

3. An file will be generated on configured output directory