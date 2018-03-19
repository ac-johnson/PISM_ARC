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

fileloc = '/home/andrew/runs/'
filename = 'ts_Ant_run*.nc'

#infiles = glob(fileloc+filename)
#print infiles

file1 = '/home/andrew/runs/newruns/Ant_1yr_10km_fk.nc'
file2 = '/home/andrew/runs/newruns/Ant_run5.nc'
file3 = '/home/andrew/runs/newruns/ts_Ant_run5.nc'

dset1 = netCDF4.Dataset(file1,mode='r')
dset2 = netCDF4.Dataset(file2,mode='r')


thkmap1 = (dset1.variables['thk'])[:]
thkmap2 = (dset2.variables['thk'])[:]

tdiffmap = thkmap2-thkmap1
tdiffmap = tdiffmap[0,:,:]
#tdiffmap=tdiffmap.transpose()
tdiffmap=np.flipud(tdiffmap)

plt.figure(figsize=(6,5))
plt.imshow(tdiffmap,cmap='RdBu')
colors = [(255,0,0),(255,150,150),(150,150,255),(0,0,255)]
n_bins = [np.min(tdiffmap),-1,1,np.max(tdiffmap)]
plt.colorbar()
plt.title('Defaults float-kill (2ka)')
titlestr='run5_thk_diff.png'
plt.savefig('/home/andrew/github/pism/pism/ARC/figures/'+titlestr)



#dset = netCDF4.Dataset(infile,mode='r')
#
#print dset.variables.keys()
#
#vol=dset.variables['ice_volume']
#fvol=vol[-1]
#
#iarea = dset.variables['ice_area_glacierized']
#farea=iarea[-1]