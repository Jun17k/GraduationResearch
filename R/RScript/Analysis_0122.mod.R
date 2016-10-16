#���͗p�X�N���v�g
#R�Ōv�Z������C�ځC���̖ʐς���}����

#�@�B�w�K�p�p�b�P�[�W�̃C���X�g�[��
#install.packages("kernlab")
library(kernlab)

#hash�e�[�u�����g�����߂̃p�b�P�[�W
#install.packages("hash")
library(hash)

#install.packages("e1071")
library(e1071)

# �팱�Җ��̃��X�g
participants = c("inoue", "kanomata", "minami", "shibasaki")

# �g�p����CSV�̎��ʗp�^�C���X�^���v�̃��X�g
timestamps <- hash()
timestamps[participants[1]] <- 
  c("20151211_1450", "20151216_1857", "20151222_1308", "20151223_1235",
  "20151223_2051", "20151225_0913", "20160113_1310", "20160113_1918")
timestamps[participants[2]] <- 
  c("20151217_1959", "20151222_1112", "20151223_1241", "20151223_2115",
    "20160120_1146", "20160120_1149", "20160120_1958", "20160120_2000")
timestamps[participants[3]] <- 
  c("20151211_1445", "20151212_0155", "20151214_1534", "20151218_1248",
    "20151220_1905", "20151220_2051", "20151222_1900", "20151222_2149")
timestamps[participants[4]] <- 
  c("20151216_1043", "20151217_1127", "20151218_1109", "20151221_2047",
    "20151225_0907", "20160106_1250", "20160111_1158", "20160112_1744")

#��ƃf�B���N�g���̕ύX
#dir = ("C:/Users/nlab/Sync/sandbox/R/shibasaki/R_landmark_0122")
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_landmark_0122")
setwd(dir)

# �l���Ɣԍ�����CSV��ǂݍ��ފ֐�
loadFaceDataFromList <- function(participant, index) {
  print(timestamps[[participant]][index])
  name.csv = paste("R_", participant, "_", timestamps[[participant]][index], "landmark.csv", sep= "")
  print(name.csv)
  return(read.csv(file=name.csv, header=T))
}

# 1�l1����������̓����ʂ��x�N�g�������ĕԂ��֐�
# loadFaceDataFromList���Ăяo���ĉ��H
calculateFeatureVector <- function(participant, index) {
  data.raw <- loadFaceDataFromList(participant, index)
  featureVector <- c(
    mean(data.raw$LEyeArea),  sd(data.raw$LEyeArea),
    mean(data.raw$REyeArea),  sd(data.raw$REyeArea),
    mean(data.raw$LEyeOpen),sd(data.raw$LEyeOpen),
    mean(data.raw$REyeOpen),sd(data.raw$REyeOpen),
    mean(data.raw$l0), sd(data.raw$l0),
    mean(data.raw$l2), sd(data.raw$l2),
    mean(data.raw$l4), sd(data.raw$l4),
    mean(data.raw$l5), sd(data.raw$l5),
    mean(data.raw$l7), sd(data.raw$l7),
    mean(data.raw$l9), sd(data.raw$l9),
    mean(data.raw$l33), sd(data.raw$l33),
    mean(data.raw$l36), sd(data.raw$l36),
    mean(data.raw$l39), sd(data.raw$l39),
    mean(data.raw$l42), sd(data.raw$l42)
  )
  return(featureVector)
}


# 4�lx8�������̃f�[�^��matrix��
# landmark���瓾�������ʂ̎Z�o
data.feature = NULL
for (participant in participants) {
  for(i in 1:8) {
      data.feature <- rbind(data.feature, calculateFeatureVector(participant, i))
  }
}

# #�v�Z���𓚌��ʂ̓ǂݍ��݁Cmatrix�Ƀf�[�^��ǉ�
# dir = ("C:/Users/Shibasaki/Desktop/DataFile0122")
# setwd(dir)
# keisan <- read.csv(file="keisan_matome.csv",header=TRUE)
# dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_landmark_0122")
# setwd(dir)
# 
# data.feature <- cbind(data.feature,keisan$correct)
# data.feature <- cbind(data.feature,keisan$AveTime)


# ����ɐ����f�[�^��t��������
data.feature <- cbind(c("NO", "YES", "NO", "NO", 
                        "NO", "YES", "YES", "YES", 
                        "NO", "NO", "NO", "YES", 
                        "NO", "NO", "YES", "YES",  
                        "NO", "YES", "NO", "YES", 
                        "YES", "NO", "NO","NO",  
                        "NO", "NO", "NO", "YES", 
                        "NO","NO", "YES","YES"),data.feature)

data.feature <- as.data.frame(data.feature)
print(data.feature)

#c("NO", "YES", "NO", "NO", "NO", "YES", "NO", "YES", "YES", "NO", "NO", "YES", "NO", "NO", "YES", "YES","NO", "YES", "NO", "YES", "NO", "NO", "NO","YES","NO", "NO", "NO", "YES",  "NO","NO", "YES","YES"))
#c("NO", "YES", "NO", "NO", "YES", "YES", "YES", "YES", "YES", "NO", "NO", "YES", "NO", "NO", "YES", "YES",  "NO", "YES", "NO", "YES", "NO", "NO", "NO","YES",  "NO", "NO", "YES", "YES", "NO","NO", "YES","YES"))


#���ʂ̏����o��
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/svm")
setwd(dir)
write.csv(data.feature, file="svm.csv", quote=FALSE, row.names=FALSE)



#��������
#leave-one-out
result <- svm(V1 ~., data=data.feature,cross=32)
summary(result)
print(data.feature$V1)

predict(result,data.feature)

table(predict(result, data.feature), data.feature$V1)