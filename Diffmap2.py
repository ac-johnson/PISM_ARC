#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  6 10:55:53 2018

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

#fileloc = '/home/andrew/runs/'
#filename = 'ts_Ant_run*.nc'

file1='/home/andrew/runs/Ant_run1.nc'
file2='/home/andrew/runs/Ant_run3.nc'

#infiles = glob(fileloc+filename)
#print infiles
#file1 = '/home/andrew/runs/newruns/Ant_1yr_10km_fk.nc'
#file2 = '/home/andrew/runs/newruns/Ant_run5.nc'
#file3 = '/home/andrew/runs/newruns/ts_Ant_run5.nc'
#file4 = '/home/andrew/maps/end_evol-5km_Ant_spinup_W65_v1.nc'
file4 = '/home/andrew/maps/Ant_1yr_fk.nc'

dset1 = netCDF4.Dataset(file1,mode='r')
dset2 = netCDF4.Dataset(file2,mode='r')


thkmap1 = (dset1.variables['thk'])[:]
thkmap2 = (dset2.variables['thk'])[:]

tdiffmap = thkmap1-thkmap2
tdiffmap = tdiffmap[0,:,:]
tdiffmap=np.flipud(tdiffmap)

#def plotnormalize(inmap,midpoint):
midpoint = 0
inmap= tdiffmap
outmap = inmap[:]
rlen1 = abs(midpoint - np.min(inmap))
rlen2 = abs(np.max(inmap)-midpoint)
outmap[inmap<=midpoint]=(outmap[inmap<=midpoint]-np.min(inmap))/rlen1 * 0.5
outmap[inmap>midpoint]=((outmap[outmap>midpoint]-midpoint)/rlen2)*0.5 + 0.5
    #(n-xmin)/range
    
plt.figure(figsize=(12,10))
#colors = [(255,0,0),(255,150,150),(150,150,255),(0,0,255)]
#n_bins = [np.min(tdiffmap),-1,1,np.max(tdiffmap)]
maxval = np.max(np.abs(tdiffmap))
#plt.imshow(tdiffmap,cmap='RdBu',vmin=-maxval,vmax=maxval)
#normmap = plotnormalize(tdiffmap,0)
plt.imshow(tdiffmap,cmap='RdBu',norm=outmap)
plt.colorbar()
plt.title('Thickness Difference after 1000yrs')
titlestr='Ant_thk_diffv2.png'
plt.savefig('/home/andrew/github/pism/pism/ARC/figures/'+titlestr)

#tm1 = thkmap1[0,:,:]
#tm1 = np.flipud(tm1)

#plt.figure(figsize=(12,10))
#plt.imshow(tm1)
#colors = [(255,255,255),(0,0,0),(100,50,50),(200,100,100),(255,255,255)]
#n_bins = [10,20,1000,3000,np.max(tm1)]
##colors=[(255,255,255)]+colors
##n_nins=[10]+n_bins
#plt.colorbar()
#plt.title('Thickness after 1000yrs')
#titlestr='Ant_run1_fin_thkBAD.png'
#plt.savefig('/home/andrew/github/pism/pism/ARC/figures/'+titlestr)

#### Surf Vel
#plt.figure(figsize=(12,10))
#plt.imshow(tm1)
#colors = [(255,255,255),(0,0,0),(100,50,50),(200,100,100),(255,255,255)]
#n_bins = [10,20,1000,3000,np.max(tm1)]
##colors=[(255,255,255)]+colors
##n_nins=[10]+n_bins
#plt.colorbar()
#plt.title('Thickness after 1000yrs')
#titlestr='Ant_run1_fin_thk.png'
#plt.savefig('/home/andrew/github/pism/pism/ARC/figures/'+titlestr)


#dset = netCDF4.Dataset(infile,mode='r')
#
#print dset.variables.keys()
#
#vol=dset.variables['ice_volume']
#fvol=vol[-1]
#
#iarea = dset.variables['ice_area_glacierized']
#farea=iarea[-1]