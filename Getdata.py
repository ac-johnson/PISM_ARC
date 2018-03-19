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

## Set up string to gather infiles ##

fileloc = '/home/andrew/runs/'
filename = 'ts_Ant_run*.nc'

infiles = glob(fileloc+filename)
print infiles

#infile = '/home/andrew/runs/ts_Ant_run1.nc'

## Set up loop to perform these ops

dset = netCDF4.Dataset(infile,mode='r')

print dset.variables.keys()

vol=dset.variables['ice_volume']
fvol=vol[-1]

iarea = dset.variables['ice_area_glacierized']
farea=iarea[-1]