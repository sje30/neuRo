## Izhikevich model
## Adapted from code for Figure 1 of 2004 paper
## available at http://www.izhikevich.org/publications/figure1.m
## (SJE: copied from izh.m in cnw-2014)

a=0.02; b=0.2;  c=-65;  d=6;
V=-70;  u=b*V;
tau = 0.25;  ## time in units of milliseconds
tspan = seq(from=0, by=tau, to=100)
nsteps = length(tspan)
VV = uu = rep(0.0, nsteps)
T1=tspan[nsteps]/10 # when to turn on stimulus

i=1 #loop counter

input = function(t) {
  ifelse(t>T1, 14, 0)
  ## The original does not work if t is a VECTOR:
  ## if (t>T1) {
  ##   I=14
  ## } else {
  ##   I=0
  ## }
}

plot(tspan, input(tspan), type='l')



for (t in tspan) {

  ## Determine stimulus
  I = input(t)
  V = V + tau*(0.04*V^2+5*V+140-u+I)
  u = u + tau*a*(b*V-u)

  ## Did neuron get above threshold?
  if (V > 30) {
    VV[i] = 30
    V = c
    u = u + d
  } else {
    VV[i]=V
  }
  uu[i] = u; i=i+1
}


plot(tspan, VV, type='l', xlab='Time (ms)', ylab='Voltage (mV)',
     las=1, bty='n')
lines(tspan, input(tspan), col='red')  

## Exercises:
## Switch off input after 100ms, and simulate for up to 130ms to check.
## Change a,b,c,d to match the paper.  (Give example)

