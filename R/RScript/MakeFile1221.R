#テスト用コード
#landmarkを読み込み、計算して出力

#CSVファイルの読み込み
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


  #作業ディレクトリの変更
  dir = ("C:/Users/Shibasaki/R_workspace/landmark")
  setwd(dir)
  
  land = read.csv(file=filenames[i], header=TRUE)
  
  #数値を扱うためにデータフレームの作成
  #ここに算出した値を保存
  df <- data.frame(NULL)
  df <- land
  
  Distance3d <- function(x1,y1,z1,x2,y2,z2){sqrt((x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2)}
  
  #目の横幅、縦幅の追加(*1000倍)
  #左目
  df <- transform(df, LEyeWidth=1000*Distance3d(Xworld.10,Yworld.10,Zworld.10,Xworld.14,Yworld.14,Zworld.14), 
                  LEyeHeight =1000*Distance3d(Xworld.12,Yworld.12,Zworld.12,Xworld.16,Yworld.16,Zworld.16))
  #目の開き具合の追加
  df <- transform(df, LEyeOpen= df$LEyeHeight/df$LEyeWidth)
  
  #右目
  df <- transform(df, REyeWidth=1000*Distance3d(Xworld.18,Yworld.18,Zworld.18,Xworld.22,Yworld.22,Zworld.22), 
                  REyeHeight =1000*Distance3d(Xworld.20,Yworld.20,Zworld.20,Xworld.24,Yworld.24,Zworld.24))
  #目の開き具合の追加
  df <- transform(df, REyeOpen= df$REyeHeight/df$REyeWidth)
  
  #目の面積
  area <- function(x1,y1,x2,y2){x1*y2-x2*y1}
  areas <- function(x1,y1, x2,y2, x3,y3, x4,y4, x5,y5, x6,y6, x7,y7, x8,y8)
  {area(x1,y1, x2,y2) + area(x2,y2, x3,y3) + area(x3,y3, x4,y4)+ area(x4,y4, x5,y5)+ area(x5,y5, x6,y6)+ area(x6,y6, x7,y7)+ area(x7,y7, x8,y8)+ area(x8,y8, x1,y1)}
  
  df <- transform(df, LEyeArea=1000*1/2*abs(areas(Xworld.10,Yworld.10,Xworld.11,Yworld.11,Xworld.12,Yworld.12,Xworld.13,Yworld.13,
                                                  Xworld.14,Yworld.14,Xworld.15,Yworld.15,Xworld.16,Yworld.16,Xworld.17,Yworld.17)))
  df <- transform(df, REyeArea=1000*1/2*abs(areas(Xworld.18,Yworld.18,Xworld.19,Yworld.19,Xworld.20,Yworld.20,Xworld.21,Yworld.21,
                                                  Xworld.22,Yworld.22,Xworld.23,Yworld.23,Xworld.24,Yworld.24,Xworld.25,Yworld.25)))
  #目のまわり8点のｚの平均値
  ave_z <- function(z1,z2,z3,z4,z5,z6,z7,z8){(z1+z2+z3+z4+z5+z6+z7+z8)/8}
  df <- transform(df,LEyeZ=ave_z(Zworld.10,Zworld.11,Zworld.12,Zworld.13,Zworld.14,Zworld.15,Zworld.16,Zworld.17))
  df <- transform(df,REyeZ=ave_z(Zworld.18,Zworld.19,Zworld.20,Zworld.21,Zworld.22,Zworld.23,Zworld.24,Zworld.25))
  
  #目の平均深度補正後の面積
  df <- transform(df, LEyeAreaZ = LEyeArea*LEyeZ)
  df <- transform(df, REyeAreaZ = REyeArea*REyeZ)
  
  #両目の平均
  df <- transform(df, AveEyeArea = (LEyeAreaZ+REyeAreaZ)/2)
  
  #口の面積
  df <- transform(df, MouthArea=1000*1/2*abs(areas(Xworld.33,Yworld.33,Xworld.34,Yworld.34,Xworld.36,Yworld.36,Xworld.38,Yworld.38,
                                               Xworld.39,Yworld.39,Xworld.40,Yworld.40,Xworld.42,Yworld.42,Xworld.44,Yworld.44)))
  #口の平均深度
  df <- transform(df,MouthZ=ave_z(Zworld.33,Zworld.34,Zworld.36,Zworld.38,Zworld.39,Zworld.40,Zworld.42,Zworld.44))
  
  #口の平均深度補正後の面積
  df <- transform(df,MouthAreaZ=MouthArea*MouthZ)
  
  #出力ファイルの作成
  #dfから出力用データフレームの作成
  w_df <- df
  
  #W_dfの6列目から243列目まで削除
  w_df <- w_df[,-6:-243]
  
  #出力ファイルの名前
  newfilenames <- filenames
  newfilenames <- gsub("R", "Result", newfilenames)
  
  head(w_df)
  
  #作業ディレクトリの変更
  dir = ("C:/Users/Shibasaki/R_workspace/landmark/ResultFiles")
  setwd(dir)
  write.csv(w_df, file=newfilenames[i], quote=FALSE, row.names=FALSE)

}
