#�ǉ����͗pR�t�@�C��
#2��15��

#+----------------------------------------------------------------------------------------------+
#landmark�t�@�C����ǂݍ��݁A
#50�������ĕʃt�@�C���ɕۑ�
{
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215/")
setwd(dir)
sep0215 = read.csv(file="50mon.csv", header=TRUE)

for (k in 1:32){
  who <-sep0215[k,1]
  timefilestamp = sep0215[k,2]
  landtimestamp = sep0215[k,3]
  filenum = sep0215[k,4]
  st <- sep0215[k,5]
  
  #�ǂݍ��݃t�@�C���̖��O�̍쐬
  timefile = paste("time_",who,"_",timefilestamp,"keisan.csv",sep= "") 
  landfile = paste(who,"_",landtimestamp,"landmark.csv",sep= "") 
  
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_keisan_0122")
  setwd(dir)
  #���ԃt�@�C���̓ǂ݂���
  time = read.csv(file=timefile, header=TRUE)
  #�o�ߎ��Ԃ�ۑ�
  keikaVec <- time[,8]
  
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/kakou_landmark_csv_0122")
  setwd(dir)
  
  #��������t�@�C���̓ǂ݂���
  land = read.csv(file=landfile, header=TRUE)
  
  # �����t�@�C���̃X�^�[�g�ƂȂ�millisecond������
  #millisecond���31�s��
  StartTime <- land[st,2]
  
  #millisecond����X�^�[�g���Ԃň���
  land <- transform(land,time0215=land$millisecond-StartTime)
  
  
  for(h in 1:50){
    #�������݃t�@�C���̖��O���쐬
    w_name = paste(who,"_",filenum,"_",h,".csv",sep= "") 
    
    # �t�@�C���̊J�n�ƏI���
    headtime <- keikaVec[h]
    tailtime <- keikaVec[h+1]
   
    #�������݃t�@�C���̒��g�̍쐬
    w_land <- data.frame(NULL)
    w_land <- subset(land,time0215>=headtime & land$time0215<tailtime)
    
    #NA�l���܂ލs�̏���
    w_land <- na.exclude(w_land)
    
    #��ƃf�B���N�g���̕ύX
    dir =("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215/landmark0215")
    setwd(dir)
    write.csv(w_land, file=w_name, quote=FALSE, row.names=FALSE)
    
    print(w_name)
  }
}
}

#+----------------------------------------------------------------------------------------------+
#�����ʂ̎Z�o���ăt�@�C�����쐬
#�����ʂ��܂Ƃ߂��t�@�C���̍쐬
{

library(hash)

#�팱�҂̊�l�̓ǂݍ���
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122")
setwd(dir)
kijyun <- read.csv(file="kijyun.csv",header=T)

# �팱�Җ��̃��X�g
participants = c("inoue", "kanomata", "minami", "shibasaki")


#�֐��̒�`
#2�_�Ԃ̋���
Distance2d <- function(x1,y1,x2,y2){10000*sqrt((x1-x2)^2 + (y1-y2)^2)}
#�ʐ�
area <- function(x1,y1,x2,y2){x1*y2-x2*y1}
areas <- function(x1,y1, x2,y2, x3,y3, x4,y4, x5,y5, x6,y6, x7,y7, x8,y8){10000*1/2*abs(area(x1,y1, x2,y2) + area(x2,y2, x3,y3) + area(x3,y3, x4,y4)+ area(x4,y4, x5,y5)+ area(x5,y5, x6,y6)+ area(x6,y6, x7,y7)+ area(x7,y7, x8,y8)+ area(x8,y8, x1,y1))}


#�����_���܂Ƃ߂�f�[�^�t���[���̍쐬
feature_df <- data.frame(name=NA,label=NA,
                         mean_LEyeArea=NA ,sd_LEyeArea=NA ,mean_REyeArea=NA ,sd_REyeArea=NA ,
                         mean_LEyeOpen=NA ,sd_LEyeOpen=NA ,mean_REyeOpen=NA ,sd_REyeOpen=NA ,
                         mean_l0=NA , sd_l0=NA ,  mean_l2=NA , sd_l2=NA ,
                         mean_l4=NA , sd_l4=NA ,  mean_l5=NA , sd_l5=NA ,
                         mean_l7=NA , sd_l7=NA ,  mean_l9=NA , sd_l9=NA ,
                         mean_l33=NA , sd_l33=NA ,  mean_l36=NA , sd_l36=NA ,
                         mean_l39=NA , sd_l39=NA ,  mean_l42=NA , sd_l42=NA 
                         )

for(name_index in 1:4){
  kijyun_vec <- kijyun[name_index,]
  
  for(file_index in 1:8) {
    
    for(ques_index in 1:50){
      
      #��ƃf�B���N�g���̕ύX
      dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215/landmark0215")
      setwd(dir)
    
      # �l���Ɣԍ�����CSV��ǂݍ���
      name.csv = paste(participants[name_index], "_", file_index, "_",ques_index,".csv", sep= "")
      df = read.csv(file=name.csv, header=TRUE)

      #�ڂ̉���(��)
      df <- transform(df, LEyeWidth=Distance2d(Xworld.10,Yworld.10,Xworld.14,Yworld.14))
      #�ڂ̏c��(��)
      df <- transform(df, LEyeHeight=Distance2d(Xworld.12,Yworld.12,Xworld.16,Yworld.16))
      #�ڂ̊J���x����(��)
      df <- transform(df, LEyeOpen2= df$LEyeHeight/df$LEyeWidth)
      
      #�ڂ̉���(�E)
      df <- transform(df, REyeWidth=Distance2d(Xworld.18,Yworld.18,Xworld.22,Yworld.22))
      #�ڂ̏c��(�E)
      df <- transform(df, REyeHeight=Distance2d(Xworld.20,Yworld.20,Xworld.24,Yworld.24))
      #�ڂ̊J���x����(�E)
      df <- transform(df, REyeOpen2= df$REyeHeight/df$REyeWidth)
    
      #�ڂ̖ʐ�
      df <- transform(df, LEyeArea2=areas(Xworld.10,Yworld.10,Xworld.11,Yworld.11,Xworld.12,Yworld.12,Xworld.13,Yworld.13,Xworld.14,Yworld.14,Xworld.15,Yworld.15,Xworld.16,Yworld.16,Xworld.17,Yworld.17))
      df <- transform(df, REyeArea2=areas(Xworld.18,Yworld.18,Xworld.19,Yworld.19,Xworld.20,Yworld.20,Xworld.21,Yworld.21,Xworld.22,Yworld.22,Xworld.23,Yworld.23,Xworld.24,Yworld.24,Xworld.25,Yworld.25))
    
      #29�Ƃق��̓_�̋���
      df <- transform(df,l0a= Distance2d(Xworld.0,Yworld.0,Xworld.29,Yworld.29))
      df <- transform(df,l2a= Distance2d(Xworld.2,Yworld.2,Xworld.29,Yworld.29))
      df <- transform(df,l4a= Distance2d(Xworld.4,Yworld.4,Xworld.29,Yworld.29))
      df <- transform(df,l5a= Distance2d(Xworld.5,Yworld.5,Xworld.29,Yworld.29))
      df <- transform(df,l7a= Distance2d(Xworld.7,Yworld.7,Xworld.29,Yworld.29))
      df <- transform(df,l9a= Distance2d(Xworld.9,Yworld.9,Xworld.29,Yworld.29))
      df <- transform(df,l33a= Distance2d(Xworld.33,Yworld.33,Xworld.29,Yworld.29))
      df <- transform(df,l36a= Distance2d(Xworld.36,Yworld.36,Xworld.29,Yworld.29))
      df <- transform(df,l39a= Distance2d(Xworld.39,Yworld.39,Xworld.29,Yworld.29))
      df <- transform(df,l42a= Distance2d(Xworld.42,Yworld.42,Xworld.29,Yworld.29))
    
    
      #��̑傫���ƕ@�̓��̐[�x�𒊏o
      df <- transform(df, FaceSize.w = Rect.w)
      df <- transform(df, FaceSize.h = Rect.h)
      df <- transform(df, FaceSize = FaceSize.w*FaceSize.h)
      df <- transform(df, Face.Z = Zworld.29)
    
      #��l�Ŋ���
      df <- transform(df,LEyeArea= df$LEyeOpen2/kijyun_vec$AveEyeArea)
      df <- transform(df,REyeArea= df$REyeOpen2/kijyun_vec$AveEyeArea)
      df <- transform(df,LEyeOpen= df$LEyeOpen2/kijyun_vec$LEyeOpen)
      df <- transform(df,REyeOpen= df$REyeOpen2/kijyun_vec$REyeOpen)
      df <- transform(df,l0= df$l0a/kijyun_vec$l0)
      df <- transform(df,l2= df$l2a/kijyun_vec$l2)
      df <- transform(df,l4= df$l4a/kijyun_vec$l4)
      df <- transform(df,l5= df$l5a/kijyun_vec$l5)
      df <- transform(df,l7= df$l7a/kijyun_vec$l7)
      df <- transform(df,l9= df$l9a/kijyun_vec$l9)
      df <- transform(df,l33= df$l33a/kijyun_vec$l33)
      df <- transform(df,l36= df$l36a/kijyun_vec$l36)
      df <- transform(df,l39= df$l39a/kijyun_vec$l39)
      df <- transform(df,l42= df$l42a/kijyun_vec$l42)
      
      #NA�l���܂ލs�̏���
      df <- na.exclude(df)
      
      #�����ʂ̕��ϒl�̎Z�o���ăx�N�g���ɂ���
      featureVector <- c(
        mean(df$LEyeArea),  sd(df$LEyeArea),  mean(df$REyeArea),  sd(df$REyeArea),
        mean(df$LEyeOpen),sd(df$LEyeOpen),  mean(df$REyeOpen),sd(df$REyeOpen),
        mean(df$l0), sd(df$l0),  mean(df$l2), sd(df$l2),
        mean(df$l4), sd(df$l4),  mean(df$l5), sd(df$l5),
        mean(df$l7), sd(df$l7),  mean(df$l9), sd(df$l9),
        mean(df$l33), sd(df$l33), mean(df$l36), sd(df$l36),
        mean(df$l39), sd(df$l39), mean(df$l42), sd(df$l42)
      )
      
      p <- (name_index-1)*8 + file_index
      
      if(sep0215[p,6]==1){
        Hirou <- "Yes"
      }else{
        Hirou <- "NO"
      }
      
      #�x�N�g���ɖ��O�ƃ��x����t�^
      featureVector <- c(name.csv,Hirou,featureVector)
        
      #�x�N�g�����f�[�^�t���[���ɒǉ�
      feature_df <- rbind(feature_df,featureVector)
      
      #�o�͗p�f�[�^�t���[���̍쐬 
      w_df <- df
      #W_df��1��ڂ����ڂ܂ō폜
      w_df <- w_df[,-1:-262]
    
      #�o�̓t�@�C���̖��O
      newname <- paste("feature_",name.csv, sep= "")
      
      #��ƃf�B���N�g���̕ύX
      dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215/feature0215")
      setwd(dir)
      write.csv(w_df, file=newname, quote=FALSE, row.names=FALSE)
      
      print(newname)
    }
  } 
}

#NA�l���܂ލs�̏���
feature_df <- na.exclude(feature_df)

#�����ʂ܂Ƃ߂������o��
dir =("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215")
setwd(dir)
write.csv(feature_df, file="feature.csv", quote=FALSE, row.names=FALSE)

print("END of Feature")

}

#+----------------------------------------------------------------------------------------------+
#�@�B�w�K�ƌ�������
{
#�@�B�w�K�p�p�b�P�[�W�̃C���X�g�[��
#install.packages("kernlab")
library(kernlab)

#install.packages("e1071")
library(e1071)

dir =("C:/Users/Shibasaki/Desktop/DataFile0122/separate50_0215")
setwd(dir)
data = read.csv(file="feature.csv",header=T)
nameVec <- data$name
data <- data[, colnames(data) != "name"]


classifier=svm(label ~., data=data,cross=1600)

#summary(classifier)
#predict(classifier, data)

table(predict(classifier, data), data$label)

#���ʂ������o��
result_df <- data.frame(name=nameVec,result=predict(classifier, data),true=data$label)
write.csv(result_df, file="result.csv", quote=FALSE, row.names=FALSE)


#��������
#leave-one-out
# result <- svm(V1 ~., data=data.feature,cross=32)
# summary(result)
# print(data.feature$V1)

#10-cross-validation
# samples=sort(sample(nrow(data), nrow(data)*0.90))
# train=data[samples,]
# test=data[-samples,]
}
