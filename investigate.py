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

file = 

dset1 = netCDF4.Dataset(file1,mode='r')
#dset2 = netCDF4.Dataset(file4,mode='r')
