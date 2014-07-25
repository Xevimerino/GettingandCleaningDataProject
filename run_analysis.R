file.exists("getdata-projectfiles-UCI HAR Dataset.zip")
#Will check if the file has been downloaded if no then message saying no file

#If file exists then create a folder where to put all data and unzip
unzip("getdata-projectfiles-UCI HAR Dataset.zip", exdir="./Data")

#This command might be useful if later is it deemed important to have data on diferent folders
##list<-unzip("getdata-projectfiles-UCI HAR Dataset.zip", list=TRUE, exdir="./Data") #Maybe not needed

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

#Mix both data.sets
TestandTrain<-rbind(Test,Train)

#Because of the dimensions will transpose feature and get rid of the first line 
#to merge with TestandTrain
tFeature<-t(Feature); tFeature<-tFeature[2,]

#Here we have labeled the test with the features
colnames(TestandTrain)<-c("Subject","Activity",tFeature)


merged<-merge(TestandTrain, ActivityLabels, by.y=("V1"),by.x=("Activity"))
View(merged[seq(1,10000,1000),c("Activity","V2")])

