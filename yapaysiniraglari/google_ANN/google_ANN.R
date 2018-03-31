
google <- read.csv(file.choose(),header = TRUE,sep = ",")
google
str(google)

normalize <- function(x){
  return((x-min(x)/(max(x)-min(x))))
}

google_norm <-as.data.frame(lapply(google, normalize))
google_norm
summary(google_norm$Adj.Close)

google_train <- concrete_norm[1:1999,]
google_test  <- concrete_norm[2000:2518,]

library(neuralnet)
google_model <- neuralnet(Adj.Close ~ Open+High+Low+Close+Volume,data=google_train)
plot(google_model)

model_results <- compute(google_model,google_test[1:5])
predicted_adjclose <-model_results$net.result
cor(predicted_adjclose,google_test$strength)

google_model2 <- neuralnet(Adj.Close ~ Open+High+Low+Close+Volume,data=google_train,hidden = 5)
plot(google_model2)

model_results2 <- compute(google_model2,google_test[1:5])
predicted_adjclose2 <-model_results2$net.result
cor(predicted_adjclose2,google_test$strength)
