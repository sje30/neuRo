
## For this to work, make sure you are in the same directory as this
## script.  Goto "Session" menu --> "Set Working Directory" -->
## "To Source File Location".
## This will issue a setwd() command.
p = read.table('data/r22AP5c20p1.nf', skip=1)
xyloc = read.table("data/r22.rp",skip=1)


## This is a second dataset that we can examine later.
## p = read.table('data/r17c.nf', skip=1)
## xyloc = read.table("data/r22.rp",skip=1)



plot(x=p[,1], y=p[,2], type='l', main='ROI 1')
plot(x=p[,1], y=p[,3], type='l', main='ROI 2')
abline(h=100, col='red')

## what is this object that we've read in?
mode(p)

## Let's make the data into a matrix, where the rows are time, and the columns
## are the ROIs.

## remove the first column, as that has the frame number.
data = as.matrix(p[,-1])

##rotate <- function(x) t(apply(x, 2, rev))
##image( rotate(data), ylab='time (frames)', xlab='ROI')

require(lattice)
levelplot(data, xlab='Frame number', ylab='Region of Interest')
x2 = smooth(p[,3])
plot(x=p[,1], y=p[,3], type='l')
lines(x=p[,1], y=expsmooth( p[,3], alpha=0.2), type='l', col='blue')

apply(data, 1, max)

mean_trace = apply(data, 1, mean)

plot(mean_trace, type='l')
plot(mean_trace, type='l', xlab='Time', ylab='mean fluorescence')
max_of_each_roi = apply(data, 2, max)

plot(max_of_each_roi, xlab='ROI', ylab='Maximum response')
highest_firing = which.max(max_of_each_roi)
highest_firing

points(highest_firing, max_of_each_roi[highest_firing], col='red',
       cex=3, pch='+')

lowest_firing = which.min(max_of_each_roi)
points(lowest_firing, max_of_each_roi[lowest_firing], col='blue', cex=3, pch='0')


## so lets see all three.

plot(mean_trace, type='l', col='green', ylim=c(80,170))
lines(data[,highest_firing], col='orangered')
lines(data[,lowest_firing], col='blue')
legend('topright', lty=1, legend=c('Max', 'Mean', 'Min'), col=c('orangered', 'green', 'blue'))


expsmooth <- function(x, alpha=0.3) {
  ## https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/exposmoo.htm
  y = x
  n = length(x)
  for (i in 2:n) {
    y[i] = (alpha*x[i]) + ((1-alpha)*y[i-1])
  }
  y
}


## Let's see the smoother in action.
## alpha = 1 ==> no smoothing.

y = data[,highest_firing]
y1 = expsmooth(y, alpha=0.6)
y2 = expsmooth(y, alpha=0.1)

plot(y, type='l', col='red', main="Smoothing the highest firing ROI")
lines(y1, col='blue')
lines(y2, col='black')
legend('topright', lty=1,
       legend=c('alpha=1', 'alpha=0.6', 'alpha=0.1'),
       col=c('red', 'blue', 'black'))

plot(expsmooth(mean_trace), type='l', col='green',
     xlab="Frame number",
     ylab="Intensity",
     ylim=c(80,170))
lines(expsmooth(data[,highest_firing]), col='orangered')
lines(expsmooth(data[,lowest_firing]), col='blue')
legend('topright', lty=1, legend=c('Max', 'Mean', 'Min'), col=c('orangered', 'green', 'blue'))
title(main="Smoothed version of traces")

## Aside: why is this called exponential smoothing?
## solve with x[1] =1; x[2..n] = 0.



######################################################################
## Now lets look at the x,y data

plot(xyloc[,1], xyloc[,2], asp=1, pch='+', main="location of each ROI")

## perhaps we should find the ROI number (switch to a dot)
plot(xyloc[,1], xyloc[,2], asp=1, pch='.', main="location of each ROI")
text(xyloc, text=1:nrow(xyloc))

my_colour_plot <- function(x, y, z, lo=90, hi=120, ...) {
  n = 100
  breaks = seq(from=lo, to=hi, length=n)
  cols <- heat.colors(n)[cut(z,breaks=breaks,label=F)]
  xyplot(y~x, aspect="iso", type=c("p","g"), col=1, cex=1.5, pch=21,fill=cols, ...,
         legend=list(right=
                       list(fun = draw.colorkey,
                            args=list(key=list(col = heat.colors,
                                               at = do.breaks(c(lo, hi),n))))))
}


my_colour_plot(x=xyloc[,1], y=xyloc[,2], z=max_of_each_roi,
               lo=100, hi=160,
               main='max activation of each ROI')

for (p in 1:nrow(data)) {
  plot = my_colour_plot(xyloc[,1], xyloc[,2], data[p,], main=as.character(p))
  print(plot)
}


## Exercises:
## 
## 1. Try the second data file -- what is different?
##
## 2. Can you convert the frame number to time in seconds.  There are 30 frames
## per second.
