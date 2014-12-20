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
