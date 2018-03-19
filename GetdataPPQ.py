#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Mar  5 10:30:01 2018

@author: andrew
"""

from IPython import get_ipython
get_ipython().magic('reset -sf')

#Get data

import numpy as np
import netCDF4
import sys
from glob import glob
from matplotlib import pyplot as plt

## Set up string to gather infiles ##

fileloc = '/home/andrew/runs/'
fns = 'ts_Ant_run'          #filename string
var1 = 'ice_volume_glacierized_grounded'
var2 = 'ice_area_glacierized_grounded'

runlist1=[16,5,18,19,20]
runlist2=[32,27,34,35,36]
name='PPQ'

iniset = netCDF4.Dataset(fileloc+fns+str(runlist1[0])+'.nc',mode='r')
times = (iniset['time'])[:]
tyr = times/31557600

#vol=np.zeros([])
ivol1=[]
ivol2=[]

iarea1=[]
iarea2=[]

for ii in runlist1:
    infile=fileloc+fns+str(ii)+'.nc'
    
    dset = netCDF4.Dataset(infile,mode='r')
    #print dset.variables.keys()

    rvol=(dset.variables[var1])[:]/1e9
    rarea = (dset.variables[var2])[:]/1e6
    
    ivol1.append(rvol)
    iarea1.append(rarea)

for ii in runlist2:
    infile=fileloc+fns+str(ii)+'.nc'
    
    dset = netCDF4.Dataset(infile,mode='r')
    #print dset.variables.keys()

    rvol=(dset.variables[var1])[:]/1e9
    rarea = (dset.variables[var2])[:]/1e6
    
    ivol2.append(rvol)
    iarea2.append(rarea)
    
    #iarea = dset.variables['ice_area_glacierized']
    #farea=iarea[-1]
    
plt.figure(figsize=(13,6))
plt.plot(tyr,ivol1[0],label=name+'=0',linewidth=3)
plt.plot(tyr,ivol1[1],label=name+'=0.25',linewidth=3)
plt.plot(tyr,ivol1[2],label=name+'=0.50',linewidth=3)
plt.plot(tyr,ivol1[3],label=name+'=0.75',linewidth=3)
plt.plot(tyr,ivol1[4],label=name+'=1.0',linewidth=3)
plt.plot(tyr,ivol2[0],'--',color='blue',linewidth=2)
plt.plot(tyr,ivol2[1],'--',color='orange',linewidth=2)
plt.plot(tyr,ivol2[2],'--',color='green',linewidth=2)
plt.plot(tyr,ivol2[3],'--',color='red',linewidth=2)
plt.plot(tyr,ivol2[4],'--',color='purple',linewidth=2)
#plt.plot(tyr,ivol2[1],label='SIAe=2',linewidth=3)
#plt.plot(tyr,ivol2[2],label='SIAe=3',linewidth=3)
plt.legend(fontsize=12)
plt.tick_params(axis='both', labelsize=25)
plt.title('Grounded Ice Volume',fontsize=35)
plt.xlabel('time (years)',fontsize=25)
plt.ylabel('volume (1e7 km^3)',fontsize=25)
plt.savefig('figures/volume_'+name+'.png')

plt.figure(figsize=(13,6))
plt.plot(tyr,iarea1[0],label=name+'=0',linewidth=3)
plt.plot(tyr,iarea1[1],label=name+'=0.25',linewidth=3)
plt.plot(tyr,iarea1[2],label=name+'=0.50',linewidth=3)
plt.plot(tyr,iarea1[3],label=name+'=0.55',linewidth=3)
plt.plot(tyr,iarea1[4],label=name+'=1.0',linewidth=3)
plt.plot(tyr,iarea2[0],'--',color='blue',linewidth=2)
plt.plot(tyr,iarea2[1],'--',color='orange',linewidth=2)
plt.plot(tyr,iarea2[2],'--',color='green',linewidth=2)
plt.plot(tyr,iarea2[3],'--',color='red',linewidth=2)
plt.plot(tyr,iarea2[4],'--',color='purple',linewidth=2)
plt.legend(fontsize=12)
plt.title('Grounded Ice Area',fontsize=35)
plt.xlabel('time (years)',fontsize=25)
plt.ylabel('Area (1e7 km^2)',fontsize=25)
plt.tick_params(axis='both', labelsize=25)
plt.savefig('figures/area_'+name+'.png')
