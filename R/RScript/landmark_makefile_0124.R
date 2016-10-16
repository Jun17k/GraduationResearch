
#���͗pR�t�@�C��
#java�ŉ��H����landmark�t�@�C����ǂݍ��݁A
#�ڂ̊J����C�ڂ̖ʐρC���̖ʐς��v�Z���ďo��
#�P��24��

library(hash)

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

dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/java_landmark_0122")
setwd(dir)

# �l���Ɣԍ�����CSV��ǂݍ��ފ֐�
loadFaceDataFromList <- function(participant, index) {
  print(timestamps[[participant]][index])
  name.csv = paste("R_", participant, "_", timestamps[[participant]][index], "landmark.csv", sep= "")
  print(name.csv)
  return(read.csv(file=name.csv, header=T))
}

for(i in 1:length(filenames)){
  
  
  #��ƃf�B���N�g���̕ύX
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/java_landmark_0122")
  setwd(dir)
  
  land = read.csv(file=filenames[i], header=TRUE)
  
  #���l���������߂Ƀf�[�^�t���[���̍쐬
  df <- data.frame(NULL)
  df <- land
  
  #�o�ߎ��Ԃ̍Čv�Z
  df <- transform(df, msec = millisecond-df[1,2])
  
  #��̑傫���ƕ@�̓��̐[�x�𒊏o
  df <- transform(df, FaceSize.w = Rect.w)
  df <- transform(df, FaceSize.h = Rect.h)
  df <- transform(df, FaceSize = FaceSize.w*FaceSize.h)
  df <- transform(df, Face.Z = Zworld.29)
  
  #�ڂ̉����A�c���̒ǉ�(*1000�{)
  Distance2d <- function(x1,y1,x2,y2){10000*sqrt((x1-x2)^2 + (y1-y2)^2)}
  
  #����
  df <- transform(df, LEyeWidth=Distance2d(Xworld.10,Yworld.10,Xworld.14,Yworld.14),LEyeHeight =Distance2d(Xworld.12,Yworld.12,Xworld.16,Yworld.16))
  #�ڂ̊J����̒ǉ�
  df <- transform(df, LEyeOpen= df$LEyeHeight/df$LEyeWidth)
  
  #�E��
  df <- transform(df, REyeWidth=Distance2d(Xworld.18,Yworld.18,Xworld.22,Yworld.22),REyeHeight =Distance2d(Xworld.20,Yworld.20,Xworld.24,Yworld.24))
  #�ڂ̊J����̒ǉ�
  df <- transform(df, REyeOpen= df$REyeHeight/df$REyeWidth)
  
  #�ڂ̖ʐ�
  area <- function(x1,y1,x2,y2){x1*y2-x2*y1}
  areas <- function(x1,y1, x2,y2, x3,y3, x4,y4, x5,y5, x6,y6, x7,y7, x8,y8){area(x1,y1, x2,y2) + area(x2,y2, x3,y3) + area(x3,y3, x4,y4)+ area(x4,y4, x5,y5)+ area(x5,y5, x6,y6)+ area(x6,y6, x7,y7)+ area(x7,y7, x8,y8)+ area(x8,y8, x1,y1)}
  
  df <- transform(df, LEyeArea=10000*1/2*abs(areas(Xworld.10,Yworld.10,Xworld.11,Yworld.11,Xworld.12,Yworld.12,Xworld.13,Yworld.13,Xworld.14,Yworld.14,Xworld.15,Yworld.15,Xworld.16,Yworld.16,Xworld.17,Yworld.17)))
  df <- transform(df, REyeArea=10000*1/2*abs(areas(Xworld.18,Yworld.18,Xworld.19,Yworld.19,Xworld.20,Yworld.20,Xworld.21,Yworld.21,Xworld.22,Yworld.22,Xworld.23,Yworld.23,Xworld.24,Yworld.24,Xworld.25,Yworld.25)))
  
  #�ڂ̂܂��8�_�̂��̕��ϒl
  #ave_z <- function(z1,z2,z3,z4,z5,z6,z7,z8){(z1+z2+z3+z4+z5+z6+z7+z8)/8}
  #df <- transform(df,LEyeZ=ave_z(Zworld.10,Zworld.11,Zworld.12,Zworld.13,Zworld.14,Zworld.15,Zworld.16,Zworld.17))
  #df <- transform(df,REyeZ=ave_z(Zworld.18,Zworld.19,Zworld.20,Zworld.21,Zworld.22,Zworld.23,Zworld.24,Zworld.25))
  
  #���ڂ̕���
  df <- transform(df, AveEyeArea = (LEyeArea+REyeArea)/2)
  
  #���̖ʐ�
  df <- transform(df, MouthArea=10000*1/2*abs(areas(Xworld.33,Yworld.33,Xworld.34,Yworld.34,Xworld.36,Yworld.36,Xworld.38,Yworld.38,
                                                    Xworld.39,Yworld.39,Xworld.40,Yworld.40,Xworld.42,Yworld.42,Xworld.44,Yworld.44)))
  #���̕��ϐ[�x
  #df <- transform(df,MouthZ=ave_z(Zworld.33,Zworld.34,Zworld.36,Zworld.38,Zworld.39,Zworld.40,Zworld.42,Zworld.44))
  
  
  #�o�͗p�f�[�^�t���[���̍쐬
  w_df <- df
  #W_df��1��ڂ���243��ڂ܂ō폜
  w_df <- w_df[,-1:-243]
  
  
  #�o�̓t�@�C���̖��O
  newfilenames <- filenames
  newfilenames <- gsub("java", "R", newfilenames)
  
  
  #��ƃf�B���N�g���̕ύX
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_landmark_0122")
  setwd(dir)
  write.csv(w_df, file=newfilenames[i], quote=FALSE, row.names=FALSE)
  
}