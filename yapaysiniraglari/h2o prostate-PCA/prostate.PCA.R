#Akin Yalcinkaya
#PCA(Principal Component Analysis) en nüyük variances açıklamak 
library(h2o) #h2o,büyük veri için açık kaynaklı bir yazılımdır.
             #kullanıcların veri modellerini keşfetmesinin bit parçası olarak binclerce model uymasını sağlar
h2o.init() 

prostatePath = system.file("extdata","prostate.csv",package = "h2o")
prostatePath
prostate.hex =h2o.uploadFile(path = prostatePath)

pca_model =h2o.prcomp(training_frame = prostate.hex,k=8,transform = "STANDARDIZE")

summary(pca_model)

barplot(as.numeric(pca_model@model$importance[2,]),
        main="PCA model",
        xlab="PCA component",
        ylab="Proportion of Variance")
