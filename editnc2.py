# -*- coding: utf-8 -*-
"""
Created on Tue Apr  3 14:09:31 2018

@author: andrewjohnson
"""

import numpy as np
import netCDF4
import sys
from glob import glob
from matplotlib import pyplot as plt

infile = '/home/andrewjohnson/runs/ex_Ant_run8.nc'

dset = netCDF4.Dataset(infile,mode='r')
print dset.variables