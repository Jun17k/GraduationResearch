#�e�X�g�p�R�[�h
#landmark��ǂݍ��݁A�v�Z���ďo��

#CSV�t�@�C���̓ǂݍ���
filenames <- c("R_inoue_20151211_1450landmark.csv",
               "R_inoue_20151216_1857landmark.csv",
               "R_kanno_20151217_2019landmark.csv",
               "R_kanomata_20151217_1959landmark.csv",
               "R_minami_20151211_1445landmark.csv",
               "R_minami_20151212_0155landmark.csv",
               "R_minami_20151214_1534landmark.csv",
               "R_minami_20151218_1248landmark.csv",
               "R_minami_20151220_1905landmark.csv",
               "R_minami_20151220_2051landmark.csv",
               
               "R_okada_20151217_2044landmark.csv",
               "R_shibasaki_20151210_1235landmark.csv",
               "R_shibasaki_20151216_1043landmark.csv",
               "R_shibasaki_20151217_1127landmark.csv",
               "R_shibasaki_20151218_1109landmark.csv",
               "R_shibasaki_20151221_2047landmark.csv",
               "R_takeuchi_20151220_1857landmark.csv")

#filenames <- c("R_shibasaki_20160112_1256landmark.csv")

for(i in 1:length(filenames)){


  #��ƃf�B���N�g���̕ύX
  dir = ("C:/Users/Shibasaki/R_workspace/landmark")
  setwd(dir)
  
  land = read.csv(file=filenames[i], header=TRUE)
  
  #���l���������߂Ƀf�[�^�t���[���̍쐬
  #�����ɎZ�o�����l��ۑ�
  df <- data.frame(NULL)
  df <- land
  
  Distance3d <- function(x1,y1,z1,x2,y2,z2){sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)}
  
  #�ڂ̉����A�c���̒ǉ�(*1000�{)
  #����
  df <- transform(df, LEyeWidth=1000*Distance3d(Xworld.10,Yworld.10,Zworld.10,Xworld.14,Yworld.14,Zworld.14), 
                  LEyeHeight =1000*Distance3d(Xworld.12,Yworld.12,Zworld.12,Xworld.16,Yworld.16,Zworld.16))
  #�ڂ̊J����̒ǉ�
  df <- transform(df, LEyeOpen= df$LEyeHeight/df$LEyeWidth)
  
  #�E��
  df <- transform(df, REyeWidth=1000*Distance3d(Xworld.18,Yworld.18,Zworld.18,Xworld.22,Yworld.22,Zworld.22), 
                  REyeHeight =1000*Distance3d(Xworld.20,Yworld.20,Zworld.20,Xworld.24,Yworld.24,Zworld.24))
  #�ڂ̊J����̒ǉ�
  df <- transform(df, REyeOpen= df$REyeHeight/df$REyeWidth)
  
  #�ڂ̖ʐ�
  area <- function(x1,y1,x2,y2){x1*y2-x2*y1}
  areas <- function(x1,y1, x2,y2, x3,y3, x4,y4, x5,y5, x6,y6, x7,y7, x8,y8)
  {area(x1,y1, x2,y2) + area(x2,y2, x3,y3) + area(x3,y3, x4,y4)+ area(x4,y4, x5,y5)+ area(x5,y5, x6,y6)+ area(x6,y6, x7,y7)+ area(x7,y7, x8,y8)+ area(x8,y8, x1,y1)}
  
  df <- transform(df, LEyeArea=1000*1/2*abs(areas(Xworld.10,Yworld.10,Xworld.11,Yworld.11,Xworld.12,Yworld.12,Xworld.13,Yworld.13,
                                                  Xworld.14,Yworld.14,Xworld.15,Yworld.15,Xworld.16,Yworld.16,Xworld.17,Yworld.17)))
  df <- transform(df, REyeArea=1000*1/2*abs(areas(Xworld.18,Yworld.18,Xworld.19,Yworld.19,Xworld.20,Yworld.20,Xworld.21,Yworld.21,
                                                  Xworld.22,Yworld.22,Xworld.23,Yworld.23,Xworld.24,Yworld.24,Xworld.25,Yworld.25)))
  #�ڂ̂܂��8�_�̂��̕��ϒl
  ave_z <- function(z1,z2,z3,z4,z5,z6,z7,z8){(z1+z2+z3+z4+z5+z6+z7+z8)/8}
  df <- transform(df,LEyeZ=ave_z(Zworld.10,Zworld.11,Zworld.12,Zworld.13,Zworld.14,Zworld.15,Zworld.16,Zworld.17))
  df <- transform(df,REyeZ=ave_z(Zworld.18,Zworld.19,Zworld.20,Zworld.21,Zworld.22,Zworld.23,Zworld.24,Zworld.25))
  
  #�ڂ̕��ϐ[�x�␳��̖ʐ�
  df <- transform(df, LEyeAreaZ = LEyeArea*LEyeZ)
  df <- transform(df, REyeAreaZ = REyeArea*REyeZ)
  
  #���ڂ̕���
  df <- transform(df, AveEyeArea = (LEyeAreaZ+REyeAreaZ)/2)
  
  #���̖ʐ�
  df <- transform(df, MouthArea=1000*1/2*abs(areas(Xworld.33,Yworld.33,Xworld.34,Yworld.34,Xworld.36,Yworld.36,Xworld.38,Yworld.38,
                                               Xworld.39,Yworld.39,Xworld.40,Yworld.40,Xworld.42,Yworld.42,Xworld.44,Yworld.44)))
  #���̕��ϐ[�x
  df <- transform(df,MouthZ=ave_z(Zworld.33,Zworld.34,Zworld.36,Zworld.38,Zworld.39,Zworld.40,Zworld.42,Zworld.44))
  
  #���̕��ϐ[�x�␳��̖ʐ�
  df <- transform(df,MouthAreaZ=MouthArea*MouthZ)
  
  #�o�̓t�@�C���̍쐬
  #df����o�͗p�f�[�^�t���[���̍쐬
  w_df <- df
  
  #W_df��6��ڂ���243��ڂ܂ō폜
  w_df <- w_df[,-6:-243]
  
  #�o�̓t�@�C���̖��O
  newfilenames <- filenames
  newfilenames <- gsub("R", "Result", newfilenames)
  
  head(w_df)
  
  #��ƃf�B���N�g���̕ύX
  dir = ("C:/Users/Shibasaki/R_workspace/landmark/ResultFiles")
  setwd(dir)
  write.csv(w_df, file=newfilenames[i], quote=FALSE, row.names=FALSE)

}