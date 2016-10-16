#計算結果の加工用スクリプト
#経過時間，平均解答時間，正答数を算出する
#そのあとすべての計算結果を一つのファイルにまとめて出力する

filenames <- c("inoue_20151211_1450keisan.csv",
               "inoue_20151216_1857keisan.csv",
               "inoue_20151222_1304keisan.csv",
               "inoue_20151223_1234keisan.csv",
               "inoue_20151223_2051keisan.csv",
               "inoue_20151225_0913keisan.csv",
               "inoue_20160113_1309keisan.csv",
               "inoue_20160113_1917keisan.csv",
               "kanomata_20151217_1959keisan.csv",
               "kanomata_20151222_1110keisan.csv",
               "kanomata_20151223_1241keisan.csv",
               "kanomata_20151223_2115keisan.csv",
               "kanomata_20160120_1146keisan.csv",
               "kanomata_20160120_1149keisan.csv",
               "kanomata_20160120_1958keisan.csv",
               "kanomata_20160120_2000keisan.csv",
               "minami_20151211_1443keisan.csv",
               "minami_20151212_0155keisan.csv",
               "minami_20151214_1534keisan.csv",
               "minami_20151218_1248keisan.csv",
               "minami_20151220_1904keisan.csv",
               "minami_20151220_2050keisan.csv",
               "minami_20151222_1900keisan.csv",
               "minami_20151222_2149keisan.csv",
               "shibasaki_20151216_1042keisan.csv",
               "shibasaki_20151217_1127keisan.csv",
               "shibasaki_20151218_1109keisan.csv",
               "shibasaki_20151221_2047keisan.csv",
               "shibasaki_20151225_0906keisan.csv",
               "shibasaki_20160106_1250keisan.csv",
               "shibasaki_20160111_1157keisan.csv",
               "shibasaki_20160112_1743keisan.csv")

#開始時間，終了時間ベクトルの作成
#startmin <- NULL
#startmsec <- NULL
#finishmin  <- NULL
#finishmsec <- NULL

#正答数、全体時間、平均解答時間ベクトルの作成
seitou <- NULL
alltime <- NULL
aveanstime <- NULL

for(i in 1:length(filenames)){
  
  #作業ディレクトリの変更
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/keisan_csv_0122")
  setwd(dir)
  
  df = read.csv(file=filenames[i], header=TRUE)
  
  #CSVファイルの読み込み
  #for(i in 1:length(filenames)){
  #  assign(paste("keisan", i, sep=""), read.csv(file=filenames[i], header=TRUE))
  #}
  #keisan1
  
  #経過時間の算出
  difmin <- df$hour.min-df[1,1]
  
  y <- which(difmin>40)
  for(k in y){
    difmin <- replace(difmin,k,difmin[k]%%10)
  }
  
  time <- function(difmin,msec,startmsec){difmin*60000+msec-startmsec}
  df <- transform(df, keika=time(difmin,msec,df[1,2]))
  
  x <- df$keika
  x <- x[-1]
  x <- c(x,df$keika[51])
  
  df <- transform(df, anstime=x-keika)
  
  #開始min
  #startmin <- c(startmin,df[1,1])
  #開始msec
  #startmsec <- c(startmsec,df[1,2])
  #終了min
  #finishmin <- c(finishmin,df[51,1])
  #終了msec
  #finishmsec <- c(finishmsec,df[51,2])
  #正答数
  seitou <- c(seitou,sum(df$check))
  #全体時間
  alltime <- c(alltime,max(df$keika))
  #平均解答時間
  aveanstime <- c(aveanstime,max(df$keika)/50)
  
  #出力ファイルの作成
  #dfから出力用データフレームの作成
  w_df <- df
  
  #出力ファイルの名前
  newfilenames <- paste("time",filenames,sep="_")
  
  #作業ディレクトリの変更
  dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_keisan_0122")
  setwd(dir)
  write.csv(w_df, file=newfilenames[i], quote=FALSE, row.names=FALSE)
}

#まとめ用データフレームの作成と書き出し
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122")
setwd(dir)
matome <- data.frame(filenames, #"開始min"=startmin, "開始msec"=startmsec,
                     #"終了min"=finishmin,"終了msec"=finishmsec,
                     "correct"=seitou, "AllTime"=alltime, "AveTime"=aveanstime)
write.csv(matome, "keisan_matome.csv", quote=FALSE, row.names=FALSE)
