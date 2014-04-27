
Get_Tidy_UCI_HAR_Mean<-function(){
        
        cur.wd<-getwd()
        
        if (file.exists("getdata-projectfiles-UCI HAR Dataset")){
                setwd(file.path(getwd(), "getdata-projectfiles-UCI HAR Dataset"))
        }
        
        if (file.exists("UCI HAR Dataset")){
                setwd(file.path(getwd(), "UCI HAR Dataset"))
        }
        
        
        file.list<-c("activity_labels.txt","features.txt",
                     "subject_train.txt","X_train.txt","y_train.txt",
                     "subject_test.txt","X_test.txt","y_test.txt")
        
        path.list<-c(rep("",2),rep("train",3),rep("test",3))
        
        data.dir<-getwd()
        
        print(paste("Current R working directory:",cur.wd,sep=" "))
        print(paste("Reading data from the directory:",data.dir,sep=" "))
        
        for (i in 1:length(file.list)){
                
                if (nchar(path.list[i])>0) {
                        file.name<-file.path(path.list[i],file.list[i])
                } else{
                        file.name<-file.list[i]
                }
                
                if (file.exists(file.name)) {
                        print(paste("reading",file.name,"......"))
                        assign(file.list[i],read.table(file.name,header = FALSE,sep=""))                        
                        print(paste(file.name,"is read successfully!",sep = " "))
                } else{
                        setwd(cur.wd)
                        stop(paste(file.name,"does not exist in the directory:",data.dir,"! Please check!",sep = " ")) 
                }               
        }
        
        print("merging the training and test datasets......")
        x<-rbind(X_train.txt,X_test.txt)
        y<-rbind(y_train.txt,y_test.txt)
        subject<-rbind(subject_train.txt,subject_test.txt)
        print("task 1 is done: Merges the training and the test sets to create one data set")
        
        print("dropping measurements other than mean and std......")
        names(x)<-features.txt[,2]
        x<-x[,grepl("mean\\(\\)",tolower(features.txt[,2]))|grepl("std\\(\\)",tolower(features.txt[,2]))]
        print("task 2 is done: Extracts only the measurements on the mean and standard deviation for each measurement.")
        print("attaching descriptive variable names to the dataset......")
        names(y)<-c("activitycode")
        names(activity_labels.txt)<-c("activitycode","activity")
        names(subject)<-c("subject")
        activity<-merge(x=y,y=activity_labels.txt,by="activitycode",all.x=TRUE)
        print("task 3 is done: Uses descriptive activity names to name the activities in the data set")
        print("task 4 is done: Appropriately labels the data set with descriptive activity names.")
        
        print("creating master table......")
        master<-cbind(subject,activity,x)
        master$activitycode<-NULL
        
        print("aggregating master table......")
        output.table<-aggregate(.~ subject + activity,data=master,mean)
        output.table<-output.table[order(output.table$subject,output.table$activity),]
        row.names(output.table)<-1:nrow(output.table)
        print("task 5 is done: Creates a second, independent tidy data set with the average of each variable for each activity and each subject")
        setwd(cur.wd)
        
        print("writing txt format data to your R work folder......")
        write.table(output.table,"UCI_HAR_Tidy_Summary_Dataset.txt",row.names=FALSE)
        print(paste("mean statistics data: UCI_HAR_Tidy_Summary_Dataset.txt, is saved in the path:",getwd()))
        print("this is the end of run. the function should return a tidy dataset as data frame object")
        return(output.table)
} 
# UCI_Mean<-Get_Tidy_UCI_HAR_Mean()