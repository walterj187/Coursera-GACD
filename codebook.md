Introduction
This file describes the data, the variables, and the work that has been performed to clean up the data.

Data Set Description

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:

•	Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

•	Triaxial Angular velocity from the gyroscope. 

•	A 561-feature vector with time and frequency domain variables. 

•	Its activity label. 

•	An identifier of the subject who carried out the experiment.

The dataset includes the following files:

•	'features_info.txt': Shows information about the variables used on the feature vector.

•	'features.txt': List of all features.

•	'activity_labels.txt': Links the class labels with their activity name.

•	'train/X_train.txt': Training set.

•	'train/y_train.txt': Training labels.

•	'test/X_test.txt': Test set.

•	'test/y_test.txt': Test labels.

•	'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

•	'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

•	'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

•	'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


Variables

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Work/Transformations

Load test and training sets and the activities
The data set was downloaded from the UCI website and put into the working directory. The following code will meet all
of the requirements for this assignment.

testData <- read.table('C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\X_test.txt',header=FALSE)
testData_act <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\y_test.txt",header=FALSE)
testData_sub <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\test\\subject_test.txt",header=FALSE)
trainData <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\X_train.txt",header=FALSE)
trainData_act <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\y_train.txt",header=FALSE)
trainData_sub <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\train\\subject_train.txt",header=FALSE)
##########
activities <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\activity_labels.txt",header=FALSE,colClasses="character")
testData_act$V1 <- factor(testData_act$V1,levels=activities$V1,labels=activities$V2)
trainData_act$V1 <- factor(trainData_act$V1,levels=activities$V1,labels=activities$V2)
###############
features <- read.table("C:\\Users\\Walter\\Desktop\\Getting and Cleaning Data\\UCI HAR Dataset\\features.txt",header=FALSE,colClasses="character")
colnames(testData)<-features$V2
colnames(trainData)<-features$V2
colnames(testData_act)<-c("Activity")
colnames(trainData_act)<-c("Activity")
colnames(testData_sub)<-c("Subject")
colnames(trainData_sub)<-c("Subject")
#############
testData<-cbind(testData,testData_act)
testData<-cbind(testData,testData_sub)
trainData<-cbind(trainData,trainData_act)
trainData<-cbind(trainData,trainData_sub)
bigData<-rbind(testData,trainData)
##########
library(data.table)
bigData_mean<-sapply(bigData,mean,na.rm=TRUE)
bigData_sd<-sapply(bigData,sd,na.rm=TRUE)
################
DT <- data.table(bigData)
tidy<-DT[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidy,file="tidy.txt",sep=",",row.names = FALSE)
