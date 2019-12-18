# Read Data
data<-read.csv("CTG.csv")
str(data)
data$NSP <- as.factor(data$NSP)
table(data$NSP)

# Data Partition. 70% data for training and 30% data for testing.
set.seed(123)
set.seed(123)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))
train <- data[ind==1,]
test <- data[ind==2,]

# Random Forest
library(randomForest)
library(e1071)
library(ggplot2)
library(doParallel)
library(foreach)
set.seed(222)

#loop to run for multiple cores. In our batch script submit.sh Parallel_output0.sh has the execution times for different number of cores from 2 to 16. We used this time to plot the scaling plot and we notice that with increase in number of cores, execution time is decreased. 

for(i in 2:16) 
{
    registerDoParallel(cores = i)
    getDoParWorkers()
    
    start_time <- Sys.time()

    rf <- foreach(ntree=rep(200, 5), .combine=randomForest::combine,
              .multicombine=TRUE, .packages='randomForest') %dopar% {
                randomForest(NSP~., data=train, ntree=ntree, mtry=8)
              }
    end_time <- Sys.time()

    time <- print(end_time - start_time)

}

#Optional part : To run individually for different number of cores, we can uncomment the below lines putting as many number of cores we need. In this example, we tried both with loop to print multiple values and individual runs with different number of cores. Same can be noticed from the commented part in the submit.sh batch script. 

#registerDoParallel(cores = 2) #Parallel_output1.txt in submit.sh
#registerDoParallel(cores = 4) #Parallel_output2.txt in submit.sh
#registerDoParallel(cores = 8) Parallel_output3.txt in submit.sh
#registerDoParallel(cores = 16) #Parallel_output4.txt in submit.sh
#registerDoParallel(cores = 32) #Parallel_output5.txt in submit.sh
#registerDoParallel(cores = 64) #Parallel_output6.txt in submit.sh

#getDoParWorkers()

#start_time <- Sys.time()

#rf <- foreach(ntree=rep(200, 5), .combine=randomForest::combine,
#              .multicombine=TRUE, .packages='randomForest') %dopar% {
#                randomForest(NSP~., data=train, ntree=ntree, mtry=8)
#              }
#end_time <- Sys.time()

#time <- print(end_time - start_time)

print(rf)
attributes(rf)

#Prediction & Confusion Matrix - train data
library(caret)
p1 <- predict(rf, train)
confusionMatrix(p1, train$NSP)

#Prediction & Confusion Matrix - test data
p2 <- predict(rf, test)
confusionMatrix(p2, test$NSP)

#Error rate of Random Forest
plot(rf)

#Tune mtry
t <- tuneRF(train[,-22], train[,22],
            stepFactor = 0.5,
            plot = TRUE,
            ntreeTry = 300,
            trace = TRUE,
            improve = 0.05)

#No. of nodes for the trees
hist(treesize(rf),
    main = "No. of Nodes for the Trees",
     col = "green")

#Variable Importance
varImpPlot(rf,
           sort = T,
           n.var = 10,
           main = "Top 10 - Variable Importance")
importance(rf)
varUsed(rf)

#Partial Dependence Plot
partialPlot(rf, train, ASTV, "2")

#Extract Single Tree
getTree(rf, 1, labelVar = TRUE)

