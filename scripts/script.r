library(plyr)

data <- read.csv("measurements_10_28_random_size_wide.csv");


seq_mean <- ddply(data, .(Size), summarize, Seq=mean(Seq))
par_mean <- ddply(data, .(Size), summarize, Par=mean(Par))
libc_mean <- ddply(data, .(Size), summarize, Libc=mean(Libc))


reg_seq <- lm(formula = data$Seq~data$Size, data=data)
reg_par <- lm(formula = data$Par~data$Size, data=data)
reg_libc <- lm(formula = data$Libc~data$Size, data=data)

reg_seq2 <- lm(formula = data$Seq~( data$Size * log(data$Size)), data=data)
reg_par2 <- lm(formula = data$Par~( data$Size * log(data$Size)), data=data)
reg_libc2 <- lm(formula = data$Libc~( data$Size * log(data$Size)), data=data)

summary(reg_seq)
summary(reg_par)
summary(reg_libc)
summary(reg_seq2)
summary(reg_par2)
summary(reg_libc2)


#plot(data$Size, data$Seq, col="red", type="p", xlab="Array Size", ylab="red=Seq, green=Par, blue=Libc", xlim=range(data$Size), ylim=range(c(data$Seq, data$Par, data$Libc)))
#par(new=T)
#plot(data$Size, data$Par, col="green", type="p", xlab="", ylab="", axes=F, xlim=range(data$Size), ylim=range(c(data$Seq, data$Par, data$Libc)))
#par(new=T)
#plot(data$Size, data$Libc, col="blue", type="p", xlab="", ylab="", axes=F, xlim=range(data$Size), ylim=range(c(data$Seq, data$Par, data$Libc)))


plot(seq_mean$Size, seq_mean$Seq, col="red", xlab="Array Size", ylab="red=Seq, green=Par, blue=Libc", xlim=range(seq_mean$Size), ylim=range(c(seq_mean$Seq, par_mean$Par, libc_mean$Libc)))
par(new=T)
plot(par_mean$Size, par_mean$Par, col="green", xlab="", ylab="", axes=F, xlim=range(par_mean$Size), ylim=range(c(seq_mean$Seq, par_mean$Par, libc_mean$Libc)))
par(new=T)
plot(libc_mean$Size, libc_mean$Libc, col="blue", xlab="", ylab="", axes=F, xlim=range(libc_mean$Size), ylim=range(c(seq_mean$Seq, par_mean$Par, libc_mean$Libc)))

abline(reg_seq)
abline(reg_par)
abline(reg_libc)


df <- data.frame(x = data$Size, y = data$Par)
mod <- lm(y ~ x, data = df)

newx <- seq(min(df$x), max(df$x), length.out=100)
preds_par <- predict(mod, newdata = data.frame(x=newx), interval = 'confidence')

polygon(c(rev(newx), newx), c(rev(preds[ ,3]), preds[ ,2]), col = 'grey80', border = NA)


# model
#abline(mod)
# intervals
lines(newx, preds[ ,3], lty = 'dashed', col = 'red')
lines(newx, preds[ ,2], lty = 'dashed', col = 'red')