p = read.table('~/proj/1993-2001/web/waves2-data/r22AP5c20p1.nf', skip=1)
plot(x=p[,1], y=p[,2], type='l')
plot(x=p[,1], y=p[,3], type='l')
abline(h=100, col='red')

## what is this object that we've read in?
mode(p)

## Let's make the data into a matrix, where the rows are time, and the columns
## are the ROIs.

## remove the first column, as that has the frame number.
data = as.matrix(p[,-1])

rotate <- function(x) t(apply(x, 2, rev))

image( rotate(data), ylab='time (frames)', xlab='ROI')
image( rotate(data), axes=F)
require(lattice)
levelplot(data, xlab='Frame number', ylab='Region of Interest')
x2 = smooth(p[,3])
plot(x=p[,1], y=p[,3], type='l')
lines(x=p[,1], y=expsmooth( p[,3], alpha=0.2), type='l', col='blue')

apply(data, 1, max)

mean_trace = apply(data, 1, mean)

plot(mean_trace)
plot(mean_trace, type='l')
plot(mean_trace, type='l', xlab='Time', ylab='mean fluorescence')
max_of_each_roi = apply(data, 2, max)

plot(max_of_each_roi, xlab='ROI', ylab='Maximum response')
highest_firing = which.max(max_of_each_roi)
highest_firing

points(highest_firing, max_of_each_roi[highest_firing], col='red', pch='*')

lowest_firing = which.min(max_of_each_roi)
points(lowest_firing, max_of_each_roi[lowest_firing], col='blue', pch='*')


## so lets see all three.

plot(mean_trace, type='l', col='green', ylim=c(60,170))
lines(data[,highest_firing], col='orangered')
lines(data[,lowest_firing], col='blue')
legend('topright', lty=1, legend=c('Max', 'Mean', 'Min'), col=c('orangered', 'green', 'blue'))
## show the position of the ROIs.
xyloc = read.table("~/proj/1993-2001/web/waves2-data/r22.rp",skip=1)

plot(xyloc, pch=20, cex=2, col=sample(grey.colors(20), 100, replace=T))

x = max_of_each_roi
xscal <- scale(x,center=min(x),scale=diff(range(x)))
cols = c("red", "white", "blue")
out <- colorRamp(cols)(xscal)
plot(xyloc, pch=20, cex=2, col=out)
## help pages?

for (i in 1:nrow(data)) {
  x = data[i,]
  ##xscal <- scale(x,center=min(x),scale=diff(range(x)))
  xscal <- scale(x,center=70,scale=30)
  ##cols = c("red", "white", "blue")
  cols = c("red", "white", "blue")
  out <- colorRamp(cols)(xscal)
  plot(xyloc, pch=20, cex=2, col=out, bg='black',main=i)
}

## find the neuron with the largest response.
which.max(p)

## 22 of the regions are duff.
## length(which(xyloc[,1]==-1))

expsmooth <- function(x, alpha=0.9) {
  ## https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/exposmoo.htm
  y = x
  n = length(x)
  for (i in 2:n) {
    y[i] = (alpha*x[i]) + ((1-alpha)*y[i-1])
  }
  y
}


## Aside: why is this called exponential smoothing?
## solve with x[1] =1; x[2..n] = 0.

                                        #3 c


x <- seq(1,20,.1)
y <- rnorm(length(x))
#z <- seq(1,200,length.out=length(x))
z <- runif(length(x), min=90, max=120)

my_colour_plot <- function(x, y, z, lo=90, hi=150, ...) {
  n = 100
  breaks = seq(from=lo, to=hi, length=n)
  cols <- heat.colors(n)[cut(z,breaks=breaks,label=F)]
  xyplot(y~x, aspect="iso", type=c("p","g"), col=1, cex=1.5, pch=21,fill=cols, ...,
         legend=list(right=
                       list(fun = draw.colorkey,
                            args=list(key=list(col = heat.colors,
                                               at = do.breaks(c(lo, hi),n))))))
}


my_colour_plot(xyloc[,1], xyloc[,2], max_of_each_roi, main='hello')

for (p in 1:nrow(data)) {
  plot = my_colour_plot(xyloc[,1], xyloc[,2], data[p,], main=as.character(p))
  print(plot)
}
