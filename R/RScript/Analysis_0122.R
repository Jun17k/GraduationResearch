#•ªÍ—pƒXƒNƒŠƒvƒg
#R‚ÅŒvZ‚µ‚½ŠçC–ÚCŒû‚Ì–ÊÏ‚ğì}‚·‚é

#‹@ŠBŠwK—pƒpƒbƒP[ƒW‚ÌƒCƒ“ƒXƒg[ƒ‹
install.packages("kernlab")
library(kernlab)

#CSVƒtƒ@ƒCƒ‹‚Ì“Ç‚İ‚İ
filenames <- c("R_inoue_20151211_1450landmark.csv",
               "R_inoue_20151216_1857landmark.csv",
               "R_inoue_20151222_1308landmark.csv",
               "R_inoue_20151223_1235landmark.csv",
               "R_inoue_20151223_2051landmark.csv",
               "R_inoue_20151225_0913landmark.csv",
               "R_inoue_20160113_1310landmark.csv",
               "R_inoue_20160113_1918landmark.csv",
               "R_kanomata_20151217_1959landmark.csv",
               "R_kanomata_20151222_1112landmark.csv",
               "R_kanomata_20151223_1241landmark.csv",
               "R_kanomata_20151223_2115landmark.csv",
               "R_kanomata_20160120_1146landmark.csv",
               "R_kanomata_20160120_1149landmark.csv",
               "R_kanomata_20160120_1958landmark.csv",
               "R_kanomata_20160120_2000landmark.csv",
               "R_minami_20151211_1445landmark.csv",
               "R_minami_20151212_0155landmark.csv",
               "R_minami_20151214_1534landmark.csv",
               "R_minami_20151218_1248landmark.csv",
               "R_minami_20151220_1905landmark.csv",
               "R_minami_20151220_2051landmark.csv",
               "R_minami_20151222_1900landmark.csv",
               "R_minami_20151222_2149landmark.csv",
               "R_shibasaki_20151216_1043landmark.csv",
               "R_shibasaki_20151217_1127landmark.csv",
               "R_shibasaki_20151218_1109landmark.csv",
               "R_shibasaki_20151221_2047landmark.csv",
               "R_shibasaki_20151225_0907landmark.csv",
               "R_shibasaki_20160106_1250landmark.csv",
               "R_shibasaki_20160111_1158landmark.csv",
               "R_shibasaki_20160112_1744landmark.csv"
)

#ì‹ÆƒfƒBƒŒƒNƒgƒŠ‚Ì•ÏX
dir = ("C:/Users/Shibasaki/Desktop/DataFile0122/R_landmark_0122")
setwd(dir)

# x <- data.frame(,ncol=4)
# x <- c()

#R_.csv‚ğ“Ç‚İ‚Ş
data_inoue = c()
data_kanomata = c()
data_minami = c()
data_shibasaki = c()
for(i in 1:8){
  data_inoue <- append(data_inoue, read.csv(file=filenames[i], header=TRUE))
  x[i,1]<-read.csv(file=filenames[i], header=TRUE)
  x[i,2]<-read.csv(file=filenames[i+8], header=TRUE)
  x[i,3]<-read.csv(file=filenames[i+16], header=TRUE)
  x[i,4]<-read.csv(file=filenames[i+24], header=TRUE)
}

for(i in 1:8){
  assign(paste("inoue", i, sep=""), read.csv(file=filenames[i], header=TRUE))
  assign(paste("kanomata", i, sep=""), read.csv(file=filenames[i+8], header=TRUE))
  assign(paste("minami", i, sep=""), read.csv(file=filenames[i+16], header=TRUE))
  assign(paste("shibasaki", i, sep=""), read.csv(file=filenames[i+24], header=TRUE))
}



#RŠî–{‚ÌƒJƒ‰[ƒpƒŒƒbƒg‚WF
#black, red, green3, blue, cyan, magenta, yellow, gray

#inoue
{
#•@‚Ì“ª‚Ì[“x‚ğì}
plot(inoue1$msec, inoue1$Face.Z, type="l", col="blue", ylim=c(0.4,.6))
lines(inoue2$msec, inoue2$Face.Z, type="l", col="red")
lines(inoue3$msec, inoue3$Face.Z, type="l", col="green3")
lines(inoue4$msec, inoue4$Face.Z, type="l", col="cyan")
lines(inoue5$msec, inoue5$Face.Z, type="l", col="magenta")
lines(inoue6$msec, inoue6$Face.Z, type="l", col="yellow")
lines(inoue7$msec, inoue7$Face.Z, type="l", col="gray")
lines(inoue8$msec, inoue8$Face.Z, type="l", col="black")

#Šç‚Ì–ÊÏ‚Ìì}
plot(inoue1$msec, inoue1$FaceSize, type="l", col="blue", ylim=c(10000,100000))
lines(inoue2$msec, inoue2$FaceSize, type="l", col="red")
lines(inoue3$msec, inoue3$FaceSize, type="l", col="green3")
lines(inoue4$msec, inoue4$FaceSize, type="l", col="cyan")
lines(inoue5$msec, inoue5$FaceSize, type="l", col="magenta")
lines(inoue6$msec, inoue6$FaceSize, type="l", col="yellow")
lines(inoue7$msec, inoue7$FaceSize, type="l", col="gray")
lines(inoue8$msec, inoue8$FaceSize, type="l", col="black")

#Šç‚Ì–ÊÏ‚ğ[“x‚Å•â³‚·‚é
inoue1 <- transform(inoue1,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue2 <- transform(inoue2,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue3 <- transform(inoue3,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue4 <- transform(inoue4,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue5 <- transform(inoue5,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue6 <- transform(inoue6,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue7 <- transform(inoue7,FaceSizeZ=FaceSize*(Face.Z)^2)
inoue8 <- transform(inoue8,FaceSizeZ=FaceSize*(Face.Z)^2)

#Šç‚Ì–ÊÏ([“x•â³Œã)‚Ìì}
plot(inoue1$msec, inoue1$FaceSizeZ, type="l", col="blue", ylim=c(8000,20000))
lines(inoue2$msec, inoue2$FaceSizeZ, type="l", col="red")
lines(inoue3$msec, inoue3$FaceSizeZ, type="l", col="green3")
lines(inoue4$msec, inoue4$FaceSizeZ, type="l", col="cyan")
lines(inoue5$msec, inoue5$FaceSizeZ, type="l", col="magenta")
lines(inoue6$msec, inoue6$FaceSizeZ, type="l", col="yellow")
lines(inoue7$msec, inoue7$FaceSizeZ, type="l", col="gray")
lines(inoue8$msec, inoue8$FaceSizeZ, type="l", col="black")

#–Ú‚Ì–ÊÏ‚ÌŠO‚ê’l‚Ìœ‹
which(inoue1$AveEyeArea > 2)
which(inoue2$AveEyeArea > 2)
which(inoue3$AveEyeArea > 2)
which(inoue4$AveEyeArea > 2)
which(inoue5$AveEyeArea > 2)
which(inoue6$AveEyeArea > 2)
which(inoue7$AveEyeArea > 2)
which(inoue8$AveEyeArea > 2)

vec_AveEyeArea1 <- inoue1$AveEyeArea[-which(inoue1$AveEyeArea > 2)]
vec_AveEyeArea2 <- inoue2$AveEyeArea[-which(inoue2$AveEyeArea > 2)]
vec_AveEyeArea3 <- inoue3$AveEyeArea[-which(inoue3$AveEyeArea > 2)]
vec_AveEyeArea4 <- inoue4$AveEyeArea[-which(inoue4$AveEyeArea > 2)]
vec_AveEyeArea5 <- inoue5$AveEyeArea[-which(inoue5$AveEyeArea > 2)]
vec_AveEyeArea6 <- inoue6$AveEyeArea[-which(inoue6$AveEyeArea > 2)]
vec_AveEyeArea7 <- inoue7$AveEyeArea[-which(inoue7$AveEyeArea > 2)]
vec_AveEyeArea8 <- inoue8$AveEyeArea[-which(inoue8$AveEyeArea > 2)]

plot(vec_AveEyeArea1,type="l",col="blue")
lines(vec_AveEyeArea2, type="l", col="red")
lines(vec_AveEyeArea3, type="l", col="green3")
lines(vec_AveEyeArea4, type="l", col="cyan")
lines(vec_AveEyeArea5, type="l", col="magenta")
lines(vec_AveEyeArea6, type="l", col="yellow")
lines(vec_AveEyeArea7, type="l", col="gray")
lines(vec_AveEyeArea8, type="l", col="black")

#–Ú‚Ì–ÊÏ‚Ìì}
plot(inoue1$msec, inoue1$AveEyeArea,type="l", col="blue", ylim=c(0,2))
lines(inoue2$msec, inoue2$AveEyeArea, type="l", col="red")
lines(inoue3$msec, inoue3$AveEyeArea, type="l", col="green3")
lines(inoue4$msec, inoue4$AveEyeArea, type="l", col="cyan")
lines(inoue5$msec, inoue5$AveEyeArea, type="l", col="magenta")
lines(inoue6$msec, inoue6$AveEyeArea, type="l", col="yellow")
lines(inoue7$msec, inoue7$AveEyeArea, type="l", col="gray")
lines(inoue8$msec, inoue8$AveEyeArea, type="l", col="black")

}

#kanomata
{
#•@‚Ì“ª‚Ì[“x‚ğì}
plot(kanomata1$msec, kanomata1$Face.Z, type="l", col="blue", ylim=c(0.4,.6))
lines(kanomata2$msec, kanomata2$Face.Z, type="l", col="red")
lines(kanomata3$msec, kanomata3$Face.Z, type="l", col="green3")
lines(kanomata4$msec, kanomata4$Face.Z, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$Face.Z, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$Face.Z, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$Face.Z, type="l", col="gray")
lines(kanomata8$msec, kanomata8$Face.Z, type="l", col="black")

#Šç‚Ì–ÊÏ‚Ìì}
plot(kanomata1$msec, kanomata1$FaceSize, type="l", col="blue", ylim=c(10000,100000))
lines(kanomata2$msec, kanomata2$FaceSize, type="l", col="red")
lines(kanomata3$msec, kanomata3$FaceSize, type="l", col="green3")
lines(kanomata4$msec, kanomata4$FaceSize, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$FaceSize, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$FaceSize, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$FaceSize, type="l", col="gray")
lines(kanomata8$msec, kanomata8$FaceSize, type="l", col="black")

#Šç‚Ì–ÊÏ‚ğ[“x‚Å•â³‚·‚é
kanomata1 <- transform(kanomata1,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata2 <- transform(kanomata2,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata3 <- transform(kanomata3,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata4 <- transform(kanomata4,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata5 <- transform(kanomata5,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata6 <- transform(kanomata6,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata7 <- transform(kanomata7,FaceSizeZ=FaceSize*(Face.Z)^2)
kanomata8 <- transform(kanomata8,FaceSizeZ=FaceSize*(Face.Z)^2)

#Šç‚Ì–ÊÏ([“x•â³Œã)‚Ìì}
plot(kanomata1$msec, kanomata1$FaceSizeZ, type="l", col="blue",ylim=c(6000,12000))
lines(kanomata2$msec, kanomata2$FaceSizeZ, type="l", col="red")
lines(kanomata3$msec, kanomata3$FaceSizeZ, type="l", col="green3")
lines(kanomata4$msec, kanomata4$FaceSizeZ, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$FaceSizeZ, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$FaceSizeZ, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$FaceSizeZ, type="l", col="gray")
lines(kanomata8$msec, kanomata8$FaceSizeZ, type="l", col="black")

#–Ú‚Ì–ÊÏ‚Ìì}
plot(kanomata1$msec, kanomata1$AveEyeArea,type="l", col="blue", xlim=c(10000,20000),ylim=c(0,2))
lines(kanomata2$msec, kanomata2$AveEyeArea, type="l", col="red")
lines(kanomata3$msec, kanomata3$AveEyeArea, type="l", col="green3")
lines(kanomata4$msec, kanomata4$AveEyeArea, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$AveEyeArea, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$AveEyeArea, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$AveEyeArea, type="l", col="gray")
lines(kanomata8$msec, kanomata8$AveEyeArea, type="l", col="black")

#–Ú‚ÌŠJ‚«‹ï‡i‚Ü‚Î‚½‚«j‚Ìì}
plot(kanomata1$msec, kanomata1$LEyeOpen,type="l", col="blue", xlim=c(10000,20000),ylim=c(0,.5))
lines(kanomata2$msec, kanomata2$LEyeOpen, type="l", col="red")
lines(kanomata3$msec, kanomata3$LEyeOpen, type="l", col="green3")
lines(kanomata4$msec, kanomata4$LEyeOpen, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$LEyeOpen, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$LEyeOpen, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$LEyeOpen, type="l", col="gray")
lines(kanomata8$msec, kanomata8$LEyeOpen, type="l", col="black")

plot(kanomata1$msec, kanomata1$LEyeHeight,type="l", col="blue", xlim=c(10000,20000),ylim=c(0,10))
lines(kanomata2$msec, kanomata2$LEyeHeight, type="l", col="red")
lines(kanomata3$msec, kanomata3$LEyeHeight, type="l", col="green3")
lines(kanomata4$msec, kanomata4$LEyeHeight, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$LEyeHeight, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$LEyeHeight, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$LEyeHeight, type="l", col="gray")
lines(kanomata8$msec, kanomata8$LEyeHeight, type="l", col="black")

plot(kanomata1$msec, kanomata1$LEyeOpen,type="l", col="blue", xlim=c(10000,20000),ylim=c(0,.5))
lines(kanomata2$msec, kanomata2$LEyeOpen, type="l", col="red")
lines(kanomata3$msec, kanomata3$LEyeOpen, type="l", col="green3")
lines(kanomata4$msec, kanomata4$LEyeOpen, type="l", col="cyan")
lines(kanomata5$msec, kanomata5$LEyeOpen, type="l", col="magenta")
lines(kanomata6$msec, kanomata6$LEyeOpen, type="l", col="yellow")
lines(kanomata7$msec, kanomata7$LEyeOpen, type="l", col="gray")
lines(kanomata8$msec, kanomata8$LEyeOpen, type="l", col="black")

}

#minami
{
#•@‚Ì“ª‚Ì[“x
plot(minami1$msec, minami1$Face.Z, type="l", col="blue", ylim=c(0.4,.6))
lines(minami2$msec, minami2$Face.Z, type="l", col="red")
lines(minami3$msec, minami3$Face.Z, type="l", col="green3")
lines(minami4$msec, minami4$Face.Z, type="l", col="cyan")
lines(minami5$msec, minami5$Face.Z, type="l", col="magenta")
lines(minami6$msec, minami6$Face.Z, type="l", col="yellow")
lines(minami7$msec, minami7$Face.Z, type="l", col="gray")
lines(minami8$msec, minami8$Face.Z, type="l", col="black")

#Šç‚Ì–ÊÏ
plot(minami1$msec, minami1$FaceSize, type="l", col="blue", ylim=c(10000,100000))
lines(minami2$msec, minami2$FaceSize, type="l", col="red")
lines(minami3$msec, minami3$FaceSize, type="l", col="green3")
lines(minami4$msec, minami4$FaceSize, type="l", col="cyan")
lines(minami5$msec, minami5$FaceSize, type="l", col="magenta")
lines(minami6$msec, minami6$FaceSize, type="l", col="yellow")
lines(minami7$msec, minami7$FaceSize, type="l", col="gray")
lines(minami8$msec, minami8$FaceSize, type="l", col="black")

#Šç‚Ì–ÊÏ‚ğ[“x‚Å•â³‚·‚é
minami1 <- transform(minami1,FaceSizeZ=FaceSize*(Face.Z)^2)
minami2 <- transform(minami2,FaceSizeZ=FaceSize*(Face.Z)^2)
minami3 <- transform(minami3,FaceSizeZ=FaceSize*(Face.Z)^2)
minami4 <- transform(minami4,FaceSizeZ=FaceSize*(Face.Z)^2)
minami5 <- transform(minami5,FaceSizeZ=FaceSize*(Face.Z)^2)
minami6 <- transform(minami6,FaceSizeZ=FaceSize*(Face.Z)^2)
minami7 <- transform(minami7,FaceSizeZ=FaceSize*(Face.Z)^2)
minami8 <- transform(minami8,FaceSizeZ=FaceSize*(Face.Z)^2)

#Šç‚Ì–ÊÏ([“x•â³Œã)‚Ìì}
plot(minami1$msec, minami1$FaceSizeZ, type="l", col="blue", ylim=c(8000,20000))
lines(minami2$msec, minami2$FaceSizeZ, type="l", col="red")
lines(minami3$msec, minami3$FaceSizeZ, type="l", col="green3")
lines(minami4$msec, minami4$FaceSizeZ, type="l", col="cyan")
lines(minami5$msec, minami5$FaceSizeZ, type="l", col="magenta")
lines(minami6$msec, minami6$FaceSizeZ, type="l", col="yellow")
lines(minami7$msec, minami7$FaceSizeZ, type="l", col="gray")
lines(minami8$msec, minami8$FaceSizeZ, type="l", col="black")

#–Ú‚Ì–ÊÏ‚Ìì}
plot(minami1$msec, minami1$AveEyeArea,type="l", col="blue", ylim=c(0,1))
lines(minami2$msec, minami2$AveEyeArea, type="l", col="red")
lines(minami3$msec, minami3$AveEyeArea, type="l", col="green3")
lines(minami4$msec, minami4$AveEyeArea, type="l", col="cyan")
lines(minami5$msec, minami5$AveEyeArea, type="l", col="magenta")
lines(minami6$msec, minami6$AveEyeArea, type="l", col="yellow")
lines(minami7$msec, minami7$AveEyeArea, type="l", col="gray")
lines(minami8$msec, minami8$AveEyeArea, type="l", col="black")
}

#shibasaki
{
#•@‚Ì“ª‚Ì[“x
plot(shibasaki1$msec, shibasaki1$Face.Z, type="l", col="blue", ylim=c(0.4,.6))
lines(shibasaki2$msec, shibasaki2$Face.Z, type="l", col="red")
lines(shibasaki3$msec, shibasaki3$Face.Z, type="l", col="green3")
lines(shibasaki4$msec, shibasaki4$Face.Z, type="l", col="cyan")
lines(shibasaki5$msec, shibasaki5$Face.Z, type="l", col="magenta")
lines(shibasaki6$msec, shibasaki6$Face.Z, type="l", col="yellow")
lines(shibasaki7$msec, shibasaki7$Face.Z, type="l", col="gray")
lines(shibasaki8$msec, shibasaki8$Face.Z, type="l", col="black")

#Šç‚Ì–ÊÏ
plot(shibasaki1$msec, shibasaki1$FaceSize, type="l", col="blue", ylim=c(10000,100000))
lines(shibasaki2$msec, shibasaki2$FaceSize, type="l", col="red")
lines(shibasaki3$msec, shibasaki3$FaceSize, type="l", col="green3")
lines(shibasaki4$msec, shibasaki4$FaceSize, type="l", col="cyan")
lines(shibasaki5$msec, shibasaki5$FaceSize, type="l", col="magenta")
lines(shibasaki6$msec, shibasaki6$FaceSize, type="l", col="yellow")
lines(shibasaki7$msec, shibasaki7$FaceSize, type="l", col="gray")
lines(shibasaki8$msec, shibasaki8$FaceSize, type="l", col="black")

#Šç‚Ì–ÊÏ‚ğ[“x‚Å•â³‚·‚é
shibasaki1 <- transform(shibasaki1,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki2 <- transform(shibasaki2,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki3 <- transform(shibasaki3,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki4 <- transform(shibasaki4,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki5 <- transform(shibasaki5,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki6 <- transform(shibasaki6,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki7 <- transform(shibasaki7,FaceSizeZ=FaceSize*(Face.Z)^2)
shibasaki8 <- transform(shibasaki8,FaceSizeZ=FaceSize*(Face.Z)^2)

#Šç‚Ì–ÊÏ([“x•â³Œã)‚Ìì}
plot(shibasaki1$msec, shibasaki1$FaceSizeZ, type="l", col="blue", ylim=c(8000,20000))
lines(shibasaki2$msec, shibasaki2$FaceSizeZ, type="l", col="red")
lines(shibasaki3$msec, shibasaki3$FaceSizeZ, type="l", col="green3")
lines(shibasaki4$msec, shibasaki4$FaceSizeZ, type="l", col="cyan")
lines(shibasaki5$msec, shibasaki5$FaceSizeZ, type="l", col="magenta")
lines(shibasaki6$msec, shibasaki6$FaceSizeZ, type="l", col="yellow")
lines(shibasaki7$msec, shibasaki7$FaceSizeZ, type="l", col="gray")
lines(shibasaki8$msec, shibasaki8$FaceSizeZ, type="l", col="black")

#–Ú‚Ì–ÊÏ‚Ìì}
plot(shibasaki1$msec, shibasaki1$AveEyeArea,type="l", col="blue", xlim=c(10000,20000),ylim=c(0,2))
lines(shibasaki2$msec, shibasaki2$AveEyeArea, type="l", col="red")
lines(shibasaki3$msec, shibasaki3$AveEyeArea, type="l", col="green3")
lines(shibasaki4$msec, shibasaki4$AveEyeArea, type="l", col="cyan")
lines(shibasaki5$msec, shibasaki5$AveEyeArea, type="l", col="magenta")
lines(shibasaki6$msec, shibasaki6$AveEyeArea, type="l", col="yellow")
lines(shibasaki7$msec, shibasaki7$AveEyeArea, type="l", col="gray")
lines(shibasaki8$msec, shibasaki8$AveEyeArea, type="l", col="black")

#Œû‚Ì–ÊÏ‚Ìì}
plot(shibasaki1$msec, shibasaki1$MouthArea,type="l", col="blue", xlim=c(10000,20000),ylim=c(6,10))
lines(shibasaki2$msec, shibasaki2$MouthArea, type="l", col="red")
lines(shibasaki3$msec, shibasaki3$MouthArea, type="l", col="green3")
lines(shibasaki4$msec, shibasaki4$MouthArea, type="l", col="cyan")
lines(shibasaki5$msec, shibasaki5$MouthArea, type="l", col="magenta")
lines(shibasaki6$msec, shibasaki6$MouthArea, type="l", col="yellow")
lines(shibasaki7$msec, shibasaki7$MouthArea, type="l", col="gray")
lines(shibasaki8$msec, shibasaki8$MouthArea, type="l", col="black")


summary(shibasaki1$AveEyeArea)

sh1 <- c(
  mean(shibasaki1$AveEyeArea),  sd(shibasaki1$AveEyeArea),
  mean(shibasaki1$MouthArea),  sd(shibasaki1$MouthArea),
  mean(shibasaki1$LEyeOpen),  sd(shibasaki1$LEyeOpen),
  mean(shibasaki1$REyeOpen),  sd(shibasaki1$REyeOpen)
)

sh2 <- c(
  mean(shibasaki2$AveEyeArea),  sd(shibasaki2$AveEyeArea),
  mean(shibasaki2$MouthArea),  sd(shibasaki2$MouthArea),
  mean(shibasaki2$LEyeOpen),  sd(shibasaki2$LEyeOpen),
  mean(shibasaki2$REyeOpen),  sd(shibasaki2$REyeOpen)
)

shdf <- rbind(sh1,sh2)
shdf <- cbind(shdf,c("YES","NO"))
shdf <- as.data.frame(shdf)

result_shdf <- ksvm(V9 ~., data=shdf)

result_predict <- predict(result_shdf, shdf)

}


