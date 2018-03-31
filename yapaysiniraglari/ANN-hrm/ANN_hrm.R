
hrm <- read.csv(file.choose(),header = TRUE,sep = ",")
hrm
str(hrm)

normalize <- function(x){
  return ((x-min(x)/(max(x)-min(x))))
}
hrm_norm <- as.data.frame(lapply(hrm,normalize))
summary(hrm_norm$satisfaction_level)

hrm_train <- hrm_norm[1:9999,]
hrm_test  <- hrm_norm[10000:14874,]

library(neuralnet)

hrm_model <- neuralnet(satisfaction_level ~ last_evaluation+number_project+average_montly_hours+time_spend_company+Work_accident+left+promotion_last_5years,data = hrm_train)
plot(hrm_model)
model_results <- compute(hrm_model,hrm_test[1:7])
predicted_hrm <- model_results$net.result
cor(predicted_hrm,hrm_test$satisfaction_level)


hrm_model2 <- neuralnet(satisfaction_level ~ last_evaluation+number_project+average_montly_hours+time_spend_company+Work_accident+left+promotion_last_5years,data = hrm_train,hidden = 3)
plot(hrm_model2)
model_results2 <- compute(hrm_model2,hrm_test[1:7])
predicted_hrm2 <- model_results2$net.result
cor(predicted_hrm2,hrm_test$satisfaction_level)











