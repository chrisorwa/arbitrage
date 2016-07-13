#load required libraries
library(ggplot2)

#load data from folder
files <-dir()
for (i in 1:length(files)){
  a <-read.csv(files[i],header=FALSE)
  b <-a[c('V1','V6')] 
  colnames(b) <-c('date',rownames(file.info(files[i]))) 
  assign(paste('X',i,sep=''),b)
}

#merge data sets
v <-Reduce(function(x, y) merge(x, y,by='date'), list(X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,
                                                      X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,
                                                      X21,X22,X23,X24,X25,X26,X27,X28,X29,X30,
                                                      X31,X32,X33,X34,X35,X36,X37,X38,X39,X40,
                                                      X41,X42,X43,X44,X45))

#create matrix to perform computation
vx <-v[-c(1)]

#principal component analysis
pca <-prcomp(vx)
rnd <-as.data.frame(round(x=pca$rotation,digits=2))

#plotting 
p <- ggplot(rnd, aes(x=rnd$PC1,y=rnd$PC2, label=rownames(rnd)))
pl <- p + geom_text(size=10)
plot(pl)


