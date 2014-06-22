library(caret);
library(kernlab);
library(scatterplot3d);

#read data and clear unneeded columns
dat=read.csv("pml-training.csv",header=TRUE)
dattemp<-dat[,!sapply(dat,function(x) any(is.na(x)))]
dat1<-dattemp[,!sapply(dattemp, function(x) any(x == ""))]

#Create partition and save data into training and testing datasets
inTrain=createDataPartition(y=dat1$classe,p=0.70,list=FALSE)
training<-dat1[inTrain,]
testing<-dat1[-inTrain,]

#Set control parameters and run train function for the random forest method
Control = trainControl(method = "cv", number = 2)
modFit<-train(classe~.,method="rf",data=training,trControl=Control)
modFit

#Test the trained model on the testing dataset
newclass<-predict(modFit,newdata=testing)
confusionMatrix(newclass,testing$classe)

#Run the 20 testcases by the model
testdat=read.csv("pml-testing.csv",header=TRUE)
newclass<-predict(modFit,newdata=testdat)
newclass

#Plot showing importance of variables
modFit<-train(classe~.,method="rf",data=training,trControl=Control,importance=TRUE)
varImpPlot(modFit$finalModel)

