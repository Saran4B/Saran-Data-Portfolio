# Basic linear model

library(tidyverse)
library(caret)
library(mlbench)

# ML with buildin dataset BostonHousing --------------------------------------------------------------------------------------------
data("BostonHousing")
# 1. Train Test split data
 # rename data 
df <- BostonHousing

# complete data (check missing value )
 mean(complete.cases(df))

 split_data <- function(df, train_size= 0.8){
   set.seed(42)
   n <- nrow(df)
   id <- sample(1:n, size = n*train_size)
   train_df <- df[id, ]
   test_df <- df[-id, ]
   list( train = train_df, test = test_df)
 }
 
 # can change train size 
 prep_data <- split_data(df)
 train_data <- prep_data$train
 test_data <- prep_data$test
 str(prep_data)
 
 # 2. train model
 # defult Boostrapped  25 rounds
 set.seed(42)
 model <- train(medv ~ rm + b + crim , 
                data = train_data, 
                method = "lm")

# 3. score / predict new data
p <- predict(model, newdata = test_data)

# 4.evaluate model 
cal_mae <- function(actual, pred) {
  error <- actual - pred
  mean(abs(error))
}

cal_mse <- function(actual, pred) {
  error <- actual - pred
  mean(error**2)
}

cal_rmse <- function(actual, pred) {
  error <- actual - pred
  sqrt(mean(error**2))
}

cal_mae(test_data$medv, p)
cal_mse(test_data$medv, p)
cal_rmse(test_data$medv, p)

# save model  .RDS 
saveRDS(model, "lm_model.RDS")


# create a train control for change re-sampling mathod 
# here we have three re-sampling method 
# Bootstrap 
ctrl_boot <- trainControl(
  method = "boot", 
  number = 50, 
  verboseIter = TRUE
)

# Leave one out CV
ctrl_LOOCV <- trainControl(
  method = "LOOCV", 
  verboseIter = TRUE
)

# K-fold cross validation 
ctrl_cv <- trainControl(
  method = "cv", 
  number = 5,
  verboseIter = TRUE
)

# run model 
set.seed(42)
model <- train(medv ~ rm + b + crim , 
               data = train_data, 
               method = "lm", 
               trControl = ctrl_cv)

# add preProcess DATA to centralization scale 
# set scale variable to equal scale 
set.seed(42)
model <- train(medv ~ rm + b + crim , 
               data = train_data, 
               method = "lm", 
               preProcess = c("center", "scale"), 
               trControl = ctrl_cv)

# Variable Important 
varImp(model)

model$finalModel
model$finalModel %>%
  summary()
# -------------------------------------------------------------------------------------------------------------------------------------

# normalization 
# set scale variable to equal scale 
# center = mean, scale = sd

set.seed(42)
model <- train(medv ~ rm + b + crim , 
               data = train_data, 
               method = "lm", 
               preProcess = c("center", "scale", "zv", "nzv"),
               trControl = ctrl_cv)


# knn 
set.seed(42)
model <- train(medv ~ . , 
               data = train_data, 
               method = "knn", 
               preProcess = c("range", "zv", "nzv"),
               trControl = ctrl_cv)
# set hyper paramiter knn # tuneLength
set.seed(42)
model <- train(medv ~ . , 
               data = train_data, 
               method = "knn", 
               preProcess = c("range", "zv", "nzv"),
               tuneLength = 2, 
               trControl = ctrl_cv)

p <- predict(model, newdata = test_data)

# train final model using k=5
model_k5 <- train(medv ~ . , 
     data = train_data, 
     method = "knn", 
     tuneGrid = data.frame(k=5),
     preProcess = c("range", "zv", "nzv"),
     trControl = trainControl(method = "none"))

## predict test set
p_train <- predict(model_k5)
p_test <- predict(model_k5, newdata = test_data)


## rmse foe test set 
rmse_train <- cal_rmse(train_data$medv, p_train)
rmse_test <- cal_rmse(test_data$medv, p_test)



## tuneLength vs. tunegrid (set K manually)

# k -flod CV k=5
ctrl <- trainControl(
  method = "cv",
  number = 5, 
  verboseIter = TRUE
)

model_k5 <- train(medv ~ . , 
                  data = train_data, 
                  method = "knn", 
                  tuneGrid = data.frame(k=c(5,7,13)),
                  preProcess = c("center", "scale"),
                  trControl = ctrl )

## predict test set
p_train <- predict(model_k5)
p_test <- predict(model_k5, newdata = test_data)


## rmse foe test set 
rmse_train <- cal_rmse(train_data$medv, p_train)
rmse_test <- cal_rmse(test_data$medv, p_test)


# change decition choose model by MAE
model_k5 <- train(medv ~ . , 
                  data = train_data, 
                  method = "knn", 
                  metric = "MAE", 
                  tuneGrid = data.frame(k=c(5,7,13)),
                  preProcess = c("center", "scale"),
                  trControl = ctrl )

# repeated cv
ctrl <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 5,
  verboseIter = TRUE
)


