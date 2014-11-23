
##1.Reading and Merging Datasets
subject_test<-read.table("test/subject_test.txt")
subject_train<-read.table("train/subject_train.txt")
features<-read.table("features.txt")
x_train<-read.table("train/X_train.txt")
x_test<-read.table("test/X_test.txt")
y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
features_t<-t(features)

feat<-cbind(features_t,"Subject","Activity")
data_x<-rbind(x_train,x_test)
data_sub<-rbind(subject_train,subject_test)
data_y<-rbind(y_train,y_test) 

data<-cbind(data_x,data_sub,data_y)
colnames(data)<-feat[2,]### assigning column names to the dataset

##2.Extracting measurements on mean and standard deviation for each measurement

 m<-names(data)[grepl("mean[^Freq]|std..|Subject|Activity",names(data))]
dat<-data[,which(colnames(data) %in% m)]

##3.Adding Extra column for meaningful activity names
dat<-cbind(dat,"ActivityName")
colnames(dat)[ncol(dat)]<-"ActivityName"

activity<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
for(i in 1 : length(activity) ){
	
	dat$ActivityName <- ifelse(dat$Activity == i, activity, dat$ActivityName)
}
renameColumn <- function(ds, from, to) {
    names(ds)[names(ds) == from] <- to
    ds
  }


##5.Creating tidy dataset and calculating the average value for each column based on Subject and Activity

average<-suppressWarnings(aggregate(dat, by=list(dat$Subject, dat$Activity), FUN="mean"))

  cols <- colnames(average)[colnames(average) != "Activity" & colnames(average) != "Subject" & colnames(average) != "ActivityName"]
  average <- average[, cols]
  average <- renameColumn(average, "Group.1", "Subject")
  average <- renameColumn(average, "Group.2", "Activity")


### Melting dataset into the form ||"Activity" "Subject" "Variable Names" "Value"||

datm<-melt(average,id.vars=c("Activity","Subject"))

##Replacing Activity values with Activity Names
activity<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
for(i in 1 : length(activity) ){
	
	datm$Activity <- ifelse(datm$Activity == i, activity, datm$Activity)
}

## Writing the data to a text file called "Mydata.txt"
write.table(datm,"Mydata.txt", sep=",",row.names=FALSE)
