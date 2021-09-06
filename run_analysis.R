#Install and load dplyr package
install.packages("dplyr")
library("dplyr")

#Download zipped file data and unzip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "getdata_projectfiles_UCI HAR Dataset.zip")
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
folder<-"./UCI HAR Dataset/"

#Collect test data and read into a data frame.
test_data<-read.table(paste(folder,"test/subject_test.txt",sep = ""))
test_data<-cbind(test_data,read.table(paste(folder,"test/y_test.txt",sep = "")))
test_data<-cbind(test_data,read.table(paste(folder,"test/X_test.txt",sep = "")))

#Collect training data and read into a data frame.
train_data<-read.table(paste(folder,"train/subject_train.txt",sep = ""))
train_data<-cbind(train_data,read.table(paste(folder,"train/y_train.txt",sep = "")))
train_data<-cbind(train_data,read.table(paste(folder,"train/X_train.txt",sep = "")))

#Merge test and training Data
merged<-rbind(test_data,train_data)

#Extracts the measurements related to mean and standard deviation for each measurement.
features<-read.table(paste(folder,"features.txt",sep = ""))
required_features_postions<-grep(".*[Mm]ean.*|.*[Ss]td.*",features$V2)
required_features_names<-features$V2[grep(".*[Mm]ean.*|.*[Ss]td.*",features$V2)]
extracted_merged<-merged[,c(1,2,(required_features_postions+2))]

#Expand variable names and remove special character to create descriptive descriptive variable names. 
required_features_names_edited<-gsub('-',"Minus",required_features_names)
required_features_names_edited<-gsub("[,()]","",required_features_names_edited)
required_features_names_edited<-gsub("mean","Mean",required_features_names_edited)
required_features_names_edited<-gsub("[Ss]td","StandardDeviation",required_features_names_edited)
required_features_names_edited<-gsub("gravity","Gravity",required_features_names_edited)
required_features_names_edited<-gsub("[Aa]cc","Acceleration",required_features_names_edited)
required_features_names_edited<-gsub("[Mm]ag","Magnitude",required_features_names_edited)
required_features_names_edited<-gsub("[Ff]req","Frequency",required_features_names_edited)

#rename colums of data frame
names(extracted_merged)<-c("subject","activity",required_features_names_edited)

#Replace activity id with full names
final_data<-mutate(extracted_merged,activity=factor(activity,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")))

#Create data set with the average of each variable for each activity and each subject.
summarized_means<-final_data%>%group_by(subject,activity)%>%summarize_all(mean)


