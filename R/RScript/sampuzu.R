#散布図作成用スクリプト



timeA1 <- c(4036.74,3772.7,2859.5,2996.38)
timeA2 <- c(4185.38,3271.3,3020.42,3226.5)
timeB1 <- c(3056.58,2808.32,2556.12,2776.14,2729.42)
timeB2 <- c(2820.12,2708.88,2541.86)
timeC1 <- c(2527.8,2737.9,2349.56,2437.4,2359.78,2944.76)
timeC2 <- c(3096.12,3019)
timeD1 <- c(2874.08,2690.18,2670.36,2653.22,2336.6)
timeD2 <- c(2600.28,3057.24,2655.88)

correctA1 <- c(47,45,50,46)
correctA2 <- c(43,49,48,46)
correctB1 <- c(49,47,49,48,47)
correctB2 <- c(50,46,48)
correctC1 <- c(49,50,50,48,50,49)
correctC2 <- c(47,49)
correctD1 <- c(46,48,48,47,50)
correctD2 <- c(49,50,48)

time1 <-c(timeA1,timeB1,timeC1,timeD1)
time2 <-c(timeA2,timeB2,timeC2,timeD2)
correct1 <-c(correctA1,correctB1,correctC1,correctD1)
correct2 <-c(correctA2,correctB2,correctC2,correctD2)

par(mfrow=c(2,2),oma=c(0,0,0,0))

plot(0,0,type="n",xlim = c(2000, 4500), ylim = c(42,50),xlab = "平均解答時間[msec]", ylab = "正答数[問]",main="被験者A") 
points(timeA1,correctA1,col="blue",pch=17)
points(timeA2,correctA2,col="red", pch=16)

plot(0,0,type="n",xlim = c(2000, 4500), ylim = c(42,50),xlab = "平均解答時間[msec]", ylab = "正答数[問]",main="被験者B") 
points(timeB1,correctB1,col="blue",pch=17)
points(timeB2,correctB2,col="red", pch=16)

plot(0,0,type="n",xlim = c(2000, 4500), ylim = c(42,50),xlab = "平均解答時間[msec]", ylab = "正答数[問]",main="被験者C") 
points(timeC1,correctC1,col="blue",pch=17)
points(timeC2,correctC2,col="red", pch=16)

plot(0,0,type="n",xlim = c(2000, 4500), ylim = c(42,50),xlab = "平均解答時間[msec]", ylab = "正答数[問]",main="被験者D") 
points(timeD1,correctD1,col="blue",pch=17)
points(timeD2,correctD2,col="red", pch=16)

par(xpd=T)
legend(0,0,legend=c("疲労状態","疲労状態でない"),pch=c(16,17),col=c("red","blue"),ncol=2,cex=1.5)



plot(0,0,type="n",xlim = c(2000, 4500), ylim = c(42,50),xlab = "ave_time", ylab = "correct") 
points(time1,correct1,col="blue",pch=17)
points(time2,correct2,col="red", pch=16)
legend(par()$usr[1], par()$usr[4],legend=c("疲労状態","疲労状態でない"),pch=c(16,17),col=c("red","blue"),ncol=2,cex=1)


 t.test(time1,time2,var.equal = T)
t.test(correct1,correct2,var.equal = T)
