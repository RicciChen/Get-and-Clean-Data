## Peer Assessment
# Part1 : read txt file and transform into dataframe

origin.dir <-"./UCI HAR Dataset/"

list <- list.files(origin.dir,full.names=TRUE,recursive=TRUE)
file.name <- strsplit(list, split='.txt')
file.name <- gsub("^.*/","",file.name)

for   ( i in (1:length(list)) )
{
        data <- read.csv(file=list[i],header=FALSE,sep="")
        assign(file.name[i],data)        
}

### Part2 : Merge & Reshape Data Sets

## 2.1 Merge [X_test] & [X_trainning] by adding [features] as column names


X <- rbind(X_test,X_train)
names(X) <- features$V2
dim(X) #= 10299 x (561)

## 2.2 Extracts only the measurements on the mean and standard deviation for each measurement.

#find out those columns of mean & std
means <- grep("mean",features$V2,ignore.case=TRUE)
stds  <- grep("std" ,features$V2,ignore.case=TRUE)

# check
intersect(means,stds) # = 0 

# remove X data without mean and std
rm.col <- setdiff( c(1:nrow(features)), union(means,stds)) 
mean.std.X <- X[-rm.col] 
dim(mean.std.X) # 10299 x 86

# 2.3 Merge [y_test] and [y_train] with column name act.lable. 


y <- rbind(y_test,y_train)
names(y) <- c("act.label")
dim(y) # 10299 x1
names(activity_labels)<-c("act.label","activity")
act.y <- join(y,activity_labels, by="act.label")
dim(act.y) # 10299 x 2

# 2.4 Merge [subject_test] and [subject_train] with name subject


subject <- rbind(subject_test,subject_train)
names(subject) <- c("subject")
dim(subject) # 10299 x1

# 2.5 Merge 9 vectors
 
body_acc_x<-rbind(body_acc_x_test,body_acc_x_train)        
names(body_acc_x) <- c(c(paste("body_acc_x",c(1:128),sep="")) )        
dim(body_acc_x) # 10299 x 128
   
body_acc_y<-rbind(body_acc_y_test,body_acc_y_train)        
names(body_acc_y) <- c(c(paste("body_acc_y",c(1:128),sep="")) )        
dim(body_acc_y) # 10299 x 128
 
body_acc_z<-rbind(body_acc_z_test,body_acc_z_train)        
names(body_acc_z) <- c(c(paste("body_acc_z",c(1:128),sep="")) )        
dim(body_acc_z) # 10299 x 128
      
body_gyro_x<-rbind(body_gyro_x_test,body_gyro_x_train)        
names(body_gyro_x) <- c(c(paste("body_gyro_x",c(1:128),sep="")) )        
dim(body_gyro_x) # 10299 x 128
        
body_gyro_y<-rbind(body_gyro_y_test,body_gyro_y_train)        
names(body_gyro_y) <- c(c(paste("body_gyro_y",c(1:128),sep="")) )        
dim(body_gyro_y) # 10299 x 128
        
body_gyro_z<-rbind(body_gyro_z_test,body_gyro_z_train)        
names(body_gyro_z) <- c(c(paste("body_gyro_z",c(1:128),sep="")) )        
dim(body_gyro_z) # 10299 x 128
           
total_acc_x<-rbind(total_acc_x_test,total_acc_x_train)        
names(total_acc_x) <- c(c(paste("total_acc_x",c(1:128),sep="")) )        
dim(total_acc_x) # 10299 x 128
      
total_acc_y<-rbind(total_acc_y_test,total_acc_y_train)        
names(total_acc_y) <- c(c(paste("total_acc_y",c(1:128),sep="")) )        
dim(total_acc_y) # 10299 x 128
       
total_acc_z<-rbind(total_acc_z_test,total_acc_z_train)        
names(total_acc_z) <- c(c(paste("total_acc_z",c(1:128),sep="")) )        
dim(total_acc_z) # 10299 x 128
        
 V <-cbind(body_acc_x,body_acc_y,body_acc_z,
           body_gyro_x,body_gyro_y,body_gyro_z,
           total_acc_x,total_acc_y,total_acc_z)        
dim(V) # 10299 x 1152 

 # Merge [subject]10299x1 + [act.y] 10299x2 +
# [mean.std.X] 10299x86  +  [V] 102299x1152

Data<-cbind(act.y,subject,mean.std.X,V)       
dim(Data)        # 10299 x 1241

## 5. Creates a second, independent tidy data set 
#  with the average of each variable for each activity and each subject. 

# prepare a 180 x (1241-3) matrix 

Table <- matrix(rep(0,180*1238),180,1238)

for (i in 4:1241)
{     
        table.data <- Data[c(2:3,i)]
        table<- dcast(table.data,activity~subject, mean )
        t<-as.vector(as.matrix(table))    
        t<-t[7:186]
        j=i-3
        Table[,j]<-t
}

column.names <- names(Data)[4:1241]

write.csv(column.names,file="./Table_names.txt",sep=",",col.names=FALSE,row.names=FALSE)
#write(Table,file="./Table.txt",sep=",",ncolumns=1238)
write.csv(Table,file="./Table.txt",sep=",",col.names=FALSE,row.names=FALSE)
# Column names and row names can output by other files. 









