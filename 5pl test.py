from pylab import *
from numpy import random
from scipy.optimize import curve_fit
#%%

def logistic5(x, A, B, C, D, E):
    f = D+(A-D)/((1+(x/C)**B)**E)
    return f
# A: min, B: hill, C: inflection, D: max, E:symmetrical

#%%
xdata=arange(0,85,5)
ydata=array([19,14,14,10,29,48,57,85,71,104,104,140,140,100,71,57,47])
#%%
y=ydata[xdata<60]
x=xdata[xdata<60]
plot(x,y,'o')

popt, pcov = curve_fit(logistic5, x, y, bounds=(0, [40, 10, 100, 200, 100]))
plot(x,logistic5(x,*popt),'r-')
m=max(logistic5(x,*popt))

#%
y=ydata[xdata>50]
x=xdata[xdata>50]
plot(x,y,'o')

popt, pcov = curve_fit(logistic5, x, y, bounds=([0, -100, 0, m-1, 0], [40, 20, 100, m, 100]))
plot(x,logistic5(x,*popt),'r-')

