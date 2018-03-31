ANN <-read.csv(file.choose(),header = TRUE,sep = ",")
ANN
str(ANN)

normalize <- function(x){
  return((x-min(x)/(max(x)-min(x))))
}
ANN_norm <- as.data.frame(lapply(ANN,normalize))

summary(ANN_norm$HVSC)

ANN_train <- ANN_norm[1:1000,]
ANN_test   <- ANN_norm[1001:4257,]

library(neuralnet)
ANN_model <- neuralnet(HVSC ~ ptf+PTFS+PTFG+PTFH1+PTFH2+PTFH3+PTFH4+PTFH5,data = ANN_train)
plot(ANN_model)
ANN_results <- compute(ANN_model,ANN_test[1:8])
predicted_HVSC <- ANN_results$net.result
cor(predicted_HVSC,ANN_test$HVSC)


ANN_model2 <- neuralnet(HVSC ~ ptf+PTFS+PTFG+PTFH1+PTFH2+PTFH3+PTFH4+PTFH5,data = ANN_train,hidden = 3)
plot(ANN_model2)
ANN_results2 <- compute(ANN_model2,ANN_test[1:8])
predicted_HVSC2 <-ANN_results2$net.result
cor(predicted_HVSC2,ANN_test$HVSC)








