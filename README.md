Getting And Cleaning Data Project
=============================

The purpose of this Git repo is to fulfill the requirement of the course project of Coursera online course: Getting and Cleaning Data, instructed by Professor Jeff Leek, Johns Hopkins University.

There are 3 files in the repo folder:

1. run_analysis.R

	the R code submitted for the course project, which contains a R function: Get_Tidy_UCI_HAR_Mean() for performing the analysis

2. CodeBook.md

	 describes the objective of the code, raw data information, how to run the code, and the expected output after running the code.

3. README.md

## How to run run_analysis.R

1. download the raw data from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), and save the zip file in your R work directory:

2. unzip the downloaded file in your R work directory.

3. download run_analysis.R from this github repo, and save it in your R work directory

4. run the following code in your R console to load the function:

        source("run_analysis.R")
		
5. run the following code in your R console to call the function and create the output dataset

        UCI_Mean<-Get_Tidy_UCI_HAR_Mean()
		
6. there would be messages prompted during the runtime of code. The code run is successfully completed when you see the following message:

	    "this is the end of run. the function would return a tidy dataset as data frame object"