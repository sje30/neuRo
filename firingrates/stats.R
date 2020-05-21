## stats.R -- simple introduction to R for Neuroscientists; some stats!
## Text following a hash (#) is a comment; good for humans; ignored by R.


## Create some data --------------------------------------------------
## following are firing Rates in hertz, from control and drug condition
## (synthetic -- i.e. I made them up.)
ctrl = c(3.1, 4.2, 2.9, 8.2, 4.1, 5.2, 7.1, 3.2, 4.5, 3.8)
drug = c(6.2, 7.1, 3.7, 8.9, 7.3, 6.9, 5.2, 8.1, 4.4, 6.2)

## Does drug increase firing rate?

mean(ctrl)
mean(drug)


summary(ctrl)

## What if I don't know what a function is doing?
## I can do
help(summary)

## but what if I don't know the function name?  e.g I want to
## calculate the standard deviation:
help.search("standard deviation")

## From where I can see that I can then use "sd"
sd(ctrl)
sd(drug)


## lets plot them, R is good at plotting.
stripchart(x=list(Control=ctrl, Drug=drug))

## I thought you said R graphs were good...?  Ok, let's try again:
stripchart(x=list(Control=ctrl, Drug=drug),
           vertical=T,
           pch=19,
           col=c("red", "blue"),
           ylab="Firing rate (Hz)", 
           main="Effect of drug XYZ upon spontaneous firing rate of neuron")

## Or if you prefer boxplots -- where possible, names are kept the
## same between plotting functions (e.g. "main" argument sets the title
## of the plot).

boxplot(x=list(Control=ctrl, Drug=drug),
           col=c("red", "blue"),
           ylab="Firing rate (Hz)", 
           main="Effect of drug XYZ upon spontaneous firing rate of neuron")

## That's good; I want to keep that as a PDF.
pdf(file='boxplot1.pdf')   ## Create a new DEVice

boxplot(x=list(Control=ctrl, Drug=drug),
           col=c("red", "blue"),
           ylab="Firing rate (Hz)", 
           main="Effect of drug XYZ upon spontaneous firing rate of neuron")

dev.off()  ## Don't forget to switch off the most recent DEVice

## Where did my file get stored?
getwd()
## Or change the working directory using Sessions menu, setwd()

## Are my data statistically significant? --------------------------------

## Let's reach for our friends, the t test and the non-parametric
## equivalent, the wilcoxon test:


## should first check that my data are normal -- the control data look
## a bit skewed by checking the box plot.

shapiro.test(ctrl)
shapiro.test(drug)

t.test(ctrl, drug)

wilcox.test(ctrl, drug)

## We should find Wilcoxon is slightly weaker, but both tests show significantly
## different.


## Permutation testing -------------------------------------------------

## Who can remember exactrly how those tests work?  How about a more
## intuitive method?  The following is called a permutation test, and uses the
## power of computers to draw the null distribution of the values expected
## if label (1=control, 2=drug) has no difference on the value.

## first we create one long vector of all data points:

data = c( ctrl, drug)
length(data)

## Q: why can't I write "real labels" instead of "real_labels" ?

sim_ctrl = data[1:10]
sim_drug = data[-(1:10)]

mean(sim_ctrl)
mean(sim_drug)
diff_means = abs( mean(sim_ctrl) - mean(sim_drug) )   # calculates | <c> - <d> |

## so how big really is 1.77?

means = rep(NA, 100)  ## NA = not available, good place holder.
for (i in 1:100) {
  sim_ctrl = data[1:10]
  sim_drug = data[-(1:10)]
  means[i] = abs( mean(sim_ctrl) - mean(sim_drug) )
}

## Not quite right -- all value of means are the same!
means

## Version 2 -- use sample to shuffle our data so that the first ten
## data points are no longer (all) control values.

## Run this a few times to see default behaviour of sample-- shuffles entries.
1:10 #creates a vector of length 10: 1, 2, ... 10
sample(1:10)


means = rep(NA, 100)  ## NA = not available, good place holder.
for (i in 1:100) {
  sim_ctrl = data[1:10]
  sim_drug = data[-(1:10)]
  means[i] = abs( mean(sim_ctrl) - mean(sim_drug) )
  data = sample(data) # <--- New line here.
}
stripchart(means, method='jitter', pch=20, col="green", main="abs diff of means")

## Q -- what is so special about means[1] ?
abline(v=means[1], col='blue')

## From which we can count an empirical P value
