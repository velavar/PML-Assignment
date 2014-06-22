library(caret);
library(kernlab);
library(scatterplot3d);

dat=read.csv("C:\\Users\\velavarthy\\Desktop\\study7\\pml-training.csv",header=TRUE)
dattemp<-dat[,!sapply(dat,function(x) any(is.na(x)))]
dat1<-dattemp[,!sapply(dattemp, function(x) any(x == ""))]
inTrain=createDataPartition(y=dat1$classe,p=0.70,list=FALSE)
training<-dat1[inTrain,]
testing<-dat1[-inTrain,]
Control = trainControl(method = "cv", number = 2)
modFit<-train(classe~.,method="rf",data=training,trControl=Control)
modFit

newclass<-predict(modFit,newdata=testing)
confusionMatrix(newclass,testing$classe)

testdat=read.csv("C:\\Users\\nvelavar\\Desktop\\other\\pml-testing.csv",header=TRUE)
newclass<-predict(modFit,newdata=testdat)
newclass



modFit<-train(classe~.,method="rf",data=training,trControl=Control,importance=TRUE)
varImpPlot(modFit$finalModel)

