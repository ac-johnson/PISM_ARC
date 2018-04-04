# -*- coding: utf-8 -*-
"""
Created on Fri Mar 30 15:00:05 2018

@author: andrewjohnson
"""
import numpy as np

#Create defaults

d = {}

d['SIAe']=2.0
d['SSAe']=0.65
d['PPQ']=0.25
d['TEFO']=0.02
d['TGPhi']="15.0,40.0,-700,-100"
d['ecalvK']='5e15'
d['tcalvt']=50
d['lapr']=8         #lapse rate
d['PPUt']=100       #pseudo_plastic sliding threshold
d['nbsm']=''
d['bdef']=''
d['calvstr']="-calving eigen_calving,thickness_calving"
d['Yst']=0
d['Yet']=1000
d['sshfi']=0.5
d['Outloc']='$CENTER1/runs/'
#d['misc']=''

#d['-shelf_base_melt_rate']
#Or look at ocean.sub_shelf_heat_flux_into_ice  (default is 0.5 W m-2)

#print d
np.save('defaults.npy',d)


##if [ -z ${NN+1} ];
##then echo "Set NN number of cores!"; fi
#
#if [ -z ${SIAe+1} ];
#then export SIAe=2.0; fi
#
#if [ -z ${SSAe+1} ];
#then export SSAe=0.65; fi
#
#if [ -z ${PPQ+1} ];
#then export PPQ=0.25; fi
#
#if [ -z ${TEFO+1} ];
#then export TEFO=0.02; fi
#
#if [ -z ${TGPhi+1} ];
#then export TGPhi=15.0,40.0,-700,-100; fi
#
##if [ -z ${TFGO+1} ];		#What is this??
##then TFGO=15.0,40,-700,-100; fi
#
#if [ -z ${ecalvK+1} ];
#then export ecalvK=5e15; fi
#
#if [ -z ${tcalvt+1} ];
#then export tcalvt=50; fi
#
#if [ -z ${lapr+1} ];
#then export lapr=8; fi
#
#if [ -z ${PPUt+1} ];
#then export PPUt=100; fi
#
##Options to enable:
#if [ -z ${nsbm+1} ];
#then export nsbm="";
#else export nsbm="-no_subgl_basal_melt"; fi
#
#if [ -z ${bdef+1} ];
#then export bdefstr="";
#else export bedfstr="-bed_def "$bdef; fi
#
#if [ -z ${set_fk+1} ];
#then export calvstr="-calving eigen_calving,thickness_calving";
#else export calvstr="-calving float_kill,eigen_calving,thickness_calving"; fi