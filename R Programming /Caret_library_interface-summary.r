#caret interface summary 

# Classification default = Accuracy
# Regression default = RMSE 

# 1. Logistic Regression ( Binary Classification ) - Sigmoid function 
# P(Y = 1|X) = e^z/(1+e^z)
# Can change threshold that we set like 0.50, 0.75 , 0.80
# common classification metrics 
# Accuracy, Precision , Recall, F1, AUC(Area under curve)

library(tidyverse)
library(caret)
library(mlbench)

# Regularization ลด over fitting 
# Ridge Regression(L2) (alpha = 0)
# RSS = sigma(y^-y)**2 
# Ridge RSS = sigma(y^-y)**2 + lamda(sum(beta)**2)
# Lasso Regression (L1) (alpha = 1)
# Lasso RSS = sigma(y^-y)**2 + lamda(|beta|)
# not include b0 

data("PimaIndiansDiabetes")

df <- PimaIndiansDiabetes
View(df)

# Logistic Regression Model -------------------------------

set.seed(42)
n <- nrow(df)
id <- sample(n, size = 0.8*n)
train_df <- df[id, ]
test_df <- df[-id, ]


ctrl <- trainControl(method = "cv", 
                     number = 5, 
                     verboseIter = TRUE)
logistic_model <- train(diabetes ~ . ,
                        data = train_df, 
                        method = "glm", 
                        trControl = ctrl)

#score model
p <- predict(logistic_model, newdata = test_df)

# evaluate model 
confusionMatrix(p, test_df$diabetes, 
                positive = "pos", 
                mode = "prec_recall")

#glmnet Reade(0), Lasso(1) 
my_grid <- expand.grid(alpha = 0:1,
                       lambda = seq(0.0005, 0.05, length = 20))
glmnet_model <- train(diabetes ~ . ,
                        data = train_df, 
                        method = "glmnet",
                        tuneGrid = my_grid, 
                        trControl = ctrl)
#score model
p <- predict(glmnet_model, newdata = test_df)

# evaluate model 
confusionMatrix(p, test_df$diabetes, 
                positive = "pos", 
                mode = "prec_recall")

# Decition tree -------------------------------------

library(rpart)
library(rpart.plot)
tree_model <- train(diabetes ~ . ,
                      data = train_df, 
                      method = "rpart",
                      tuneGrid = expand.grid( cp = c(0.02, 0.1, 0.25)), 
                      trControl = ctrl)

# cp stand for complexity parameter
# cp ต่ำ ลด overfiting 
#score model
p <- predict(tree_model, newdata = test_df)

# evaluate model 
confusionMatrix(p, test_df$diabetes, 
                positive = "pos", 
                mode = "prec_recall")

rpart.plot(tree_model$finalModel)
tree_model$finalModel

# Random Forest ------------------------------------------------

# mtry hyperparameter 

# tuneGrid 
rf_model <- train(diabetes ~ . ,
                  data = train_df, 
                  method = "rf" , 
                  tunegrid = expand.grid(mtry = c(3, 5)), 
                  trControl = ctrl)
#score model
p <- predict(rf_model, newdata = test_df)

# evaluate model 
confusionMatrix(p, test_df$diabetes, 
                positive = "pos", 
                mode = "prec_recall")

# tuneLength-----
rf_model <- train(diabetes ~ . ,
                  data = train_df, 
                  method = "rf" , 
                  tuneLength= 5, 
                  trControl = ctrl)

#score model
p <- predict(rf_model, newdata = test_df)

# evaluate model 
confusionMatrix(p, test_df$diabetes, 
                positive = "pos", 
                mode = "prec_recall")


## resample() => compare model performance 
## predict diabetes 

model1 <- train(diabetes ~ . , 
                data = train_df, 
                method = "glm" ,
                trControl = trainControl(
                  method = "cv", number = 5
                ))

model2 <- train(diabetes ~ . , 
                data = train_df, 
                method = "rpart" ,
                trControl = trainControl(
                  method = "cv", number = 5
                ))

model3 <- train(diabetes ~ . , 
                data = train_df, 
                method = "rf" ,
                trControl = trainControl(
                  method = "cv", number = 5
                ))

model4 <- train(diabetes ~ . , 
                data = train_df, 
                method = "glmnet" ,
                trControl = trainControl(
                  method = "cv", number = 5
                ))


# resamples
list_models <- list(
  logistic = model1, 
  tree = model2, 
  ransomForest = model3, 
  glmnet = model4
)

result <- resamples(list_models)
summary(result)




# K-Means Clustering --------------------------------------------
# Client segmentation 
df <- BostonHousing
glimpse(df)


# subset columns
subset_df <- df %>%
  select(dis, rm, age , medv) %>%
  as_tibble()

# test different k (k= 2:5)
result <- kmeans( x = subset_df_norm ,centers = 5)

# membership [1,2,3]
subset_df$cluster <- result$cluster
View(subset_df)

result$size

# run descriptive statistic
subset_df %>%
  group_by(cluster) %>%
  summarise( AVGPrice = mean(medv), 
             AVGRoom = mean(rm), 
             n=n())



# normalization min - max scaling [0-1]
normalize_data <- function(x){
  (x-min(x)) /(max(x)-min(x))
} 
# apply this function to all column 
subset_df_norm <-  apply(subset_df, 2, normalize_data)

# test different k (k= 2:5)
result <- kmeans( x = subset_df_norm ,centers = 5)

# save Model
# saveRDS(model, "model.rds")
# model <- readRDS("model.rds")
# Ensample model 



