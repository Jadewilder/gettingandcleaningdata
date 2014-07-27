##install required packages 
require(reshape)

##download files
if (!file.exists("td")) {
    dir.create("td")}

url<-("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(url, destfile="./td/tf.zip")
unzip("./td/tf.zip")
dateDownloaded <- date()
dateDownloaded

###read files into r
test<- as.data.frame(read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, stringsAsFactors=FALSE))
train<-as.data.frame(read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, stringsAsFactors=FALSE))
labels<-as.data.frame(read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE, stringsAsFactors=TRUE))
testlab<-as.data.frame(read.table("./UCI HAR Dataset/test/Y_test.txt", header=FALSE, stringsAsFactors=FALSE))
trainlab<-as.data.frame(read.table("./UCI HAR Dataset/train/Y_train.txt", header=FALSE, stringsAsFactors=FALSE))
testsub<- as.data.frame(read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, stringsAsFactors=TRUE))
trainsub<-as.data.frame(read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, stringsAsFactors=TRUE))
rowlabels<-as.vector(tolower((t((read.table("./UCI HAR Dataset/features.txt",header=FALSE, stringsAsFactors=FALSE)[-1,-1])))))

##merge labels with datasets
va01<-sub("t","Time",rowlabels)
va02<-sub("acc","Acceleration",va01)
va1<-gsub("-","",va02)
va2<-gsub("\\)","",va1)
va3<-gsub("\\(","",va2)
va4<-gsub(" ","",va3)
va5<-gsub("\\,","",va4)
names(test)<-va5
names(train)<-va5
colnames(testsub)<-"subject"
colnames(trainsub)<-"subject"
colnames(testlab)[1]<-"activitycode"
colnames(trainlab)[1]<-"activitycode"
test2<-cbind(testsub,testlab,test)
train2<-cbind(trainsub,trainlab,train)
  
##merge datasets
dataset<-rbind(test2,train2)
colnames(labels)[1]<-"activitycode"
colnames(labels)[2]<-"activity"

dataset2<-merge(labels,dataset,by.x="activitycode",by.y="activitycode", all=TRUE)

##reshape data
va<-grep("mean|std", va5, value=TRUE)
keep<-as.character(c(va,"activity","subject"))
dataset3<-dataset2[,(names(dataset2) %in% keep)]


##get means
dataset4<-melt(dataset3,id=c("activity","subject"))
dataset5<-cast(dataset4, subject~activity+variable, mean)


##write file
write.csv(file="./final.csv", x=dataset5, row.names=FALSE)

##write file
##write.table(file="./data/final.txt", x=dataset5, row.names=FALSE)