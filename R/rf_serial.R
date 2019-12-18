# Read Data
data = CTG
str(data)
data$NSP <- as.factor(data$NSP)
table(data$NSP)

# Data Partition
set.seed(123)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.7, 0.3))
train <- data[ind==1,]
test <- data[ind==2,]

# Random Forest
library(randomForest)
set.seed(222)

start_time <- Sys.time()

rf <- randomForest(NSP~., data=train,
                   ntree = 1000,
                   mtry = 8,
                   importance = TRUE,
                   proximity = TRUE)
end_time <- Sys.time()

print(end_time - start_time)

print(rf)
attributes(rf)

#Prediction & Confusion Matrix - train data
library(caret)
p1 <- predict(rf, train)
confusionMatrix(p1, train$NSP)

#Prediction & Confusion Matrix - test data
p2 <- predict(rf, test)
confusionMatrix(p2, test$NSP)

# Error rate of Random Forest
plot(rf)

# Tune mtry
t <- tuneRF(train[,-22], train[,22],
       stepFactor = 0.5,
       plot = TRUE,
       ntreeTry = 300,
       trace = TRUE,
       improve = 0.05)

# No. of nodes for the trees
hist(treesize(rf),
     main = "No. of Nodes for the Trees",
     col = "green")

# Variable Importance
varImpPlot(rf,
           sort = T,
           n.var = 10,
           main = "Top 10 - Variable Importance")
importance(rf)
varUsed(rf)

# Partial Dependence Plot
partialPlot(rf, train, ASTV, "2")

# Extract Single Tree
getTree(rf, 1, labelVar = TRUE)

# Multi-dimensional Scaling Plot of Proximity Matrix
MDSplot(rf, train$NSP)
