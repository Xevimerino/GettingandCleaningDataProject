#Command to download and unzip the file, if a file with the same name is present it will be overwritten
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","getdata-projectfiles-UCI HAR Dataset.zip")
unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir="./Data")

#Load common data for test and train
Feature<-read.table("./Data/UCI HAR Dataset/features.txt")
ActivityLabels<-read.table("./Data/UCI HAR Dataset/activity_labels.txt")

#Load data for Test
X_test<-read.table("./Data/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./Data/UCI HAR Dataset/test/y_test.txt")
Subject_test<-read.table("./Data/UCI HAR Dataset/test/subject_test.txt")
#Created the data.table for test
Test<-cbind(Subject_test,Y_test,X_test)

#Load data for Train
X_train<-read.table("./Data/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./Data/UCI HAR Dataset/train/y_train.txt")
Subject_train<-read.table("./Data/UCI HAR Dataset/train/subject_train.txt")
#Created the data.table for test
Train<-cbind(Subject_train,Y_train,X_train)

#Mix both data.tables
TestandTrain<-rbind(Test,Train)

#Because of the dimensions will transpose feature and get rid of the first line 
#to merge with TestandTrain
tFeature<-t(Feature); tFeature<-tFeature[2,]

#Here we have labeled the test with the features
colnames(TestandTrain)<-c("Subject","Activity",tFeature)

#Changing the numerical values in activity to the descriptive names provided 
#by ActivityLabels
colnames(ActivityLabels)<-c("Activity","ActivityName")
merged<-merge(ActivityLabels,TestandTrain,sort=FALSE)

#Get the names from "merged" that contain either mean or std 
#and then discard the ones with meanFreq and all the other ones
smean<-grepl("mean",names(merged))
smean2<-grepl("meanFreq",names(merged))
smean3<-as.logical(smean-smean2)
sstd<-grepl("std",names(merged))

#Combine all the columns for the different measurements
merged2<-cbind(merged["ActivityName"],merged["Subject"],merged[smean3],merged[sstd])

#Cleaning the names of the data
colnames(merged2)<-gsub("BodyBody","Body",names(merged2))
colnames(merged2)<-gsub("\\()","",names(merged2))
colnames(merged2)<-gsub("\\-","",names(merged2))
colnames(merged2)<-sub("tB","TimeB",names(merged2))
colnames(merged2)<-sub("tG","TimeG",names(merged2))
colnames(merged2)<-sub("fB","FrequencyB",names(merged2))
colnames(merged2)<-sub("fG","FrequencyG",names(merged2))
colnames(merged2)<-sub("std","Std",names(merged2))
colnames(merged2)<-sub("mean","Mean",names(merged2))
colnames(merged2)<-sub("Acc","Accelerometer",names(merged2))
colnames(merged2)<-sub("Gyro","Gyroscope",names(merged2))

#Install and load reshape2 package
install.packages("reshape2")
library(reshape2)

#Subsetting the data for each activity and calculating the mean of each variable
#activity wise 
merged3<-merged2[merged2$ActivityName=="LAYING",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
LAYING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("LAYING",30)
LAYING_group<-cbind(Activity,LAYING_group)

merged3<-merged2[merged2$ActivityName=="STANDING",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
STANDING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("STANDING",30)
STANDING_group<-cbind(Activity,STANDING_group)

merged3<-merged2[merged2$ActivityName=="SITTING",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
SITTING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("SITTING",30)
SITTING_group<-cbind(Activity,SITTING_group)

merged3<-merged2[merged2$ActivityName=="WALKING_DOWNSTAIRS",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
WALKING_D_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING_DOWNSTAIRS",30)
WALKING_D_group<-cbind(Activity,WALKING_D_group)

merged3<-merged2[merged2$ActivityName=="WALKING_UPSTAIRS",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
WALKING_U_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING_UPSTAIRS",30)
WALKING_U_group<-cbind(Activity,WALKING_U_group)

merged3<-merged2[merged2$ActivityName=="WALKING",]
melted<-melt(merged3, id="Subject", measure.vars=c(3:68))
WALKING_group<-dcast(melted, Subject~variable,mean)
Activity<-rep("WALKING",30)
WALKING_group<-cbind(Activity,WALKING_group)

#The diferent tables for each activity are combined in one table
final<-rbind(LAYING_group,SITTING_group,STANDING_group,WALKING_D_group,WALKING_U_group,WALKING_group)

#The archive to be submitted is created
write.table(final,"TidyData.txt",row.names=FALSE)