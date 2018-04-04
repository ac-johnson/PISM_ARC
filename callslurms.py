# -*- coding: utf-8 -*-
"""
Created on Wed Apr  4 11:13:37 2018

@author: andrewjohnson
"""

import os

#callslurms

dorunlist = range(37,57)
dorunlist = ['run'+str(i) for i in dorunlist]

for run in dorunlist:
    os.system('cd fullruns/'+run+'; sbatch run.slurm')