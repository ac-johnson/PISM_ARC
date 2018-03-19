#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Feb 27 18:01:29 2018

@author: andrew
"""

#print dset3.file_format
import numpy as np
import netCDF4

infile = '/home/andrew/maps/PISM_1km_v3.nc'
#infile4= 'PISM_1km.nc'
#infile3 = '/home/andrew/github/pism/pism/examples/std-greenland/pism_Greenland_5km_v1.2.nc'
infile2 = '/home/andrew/github/pism/pism/examples/std-greenland/pism_Greenland_5km_v1.1.nc'
#dset = netCDF4.Dataset('/home/andrew/github/pism/pism/ARC/PISM_1km_v1.nc',mode='w',format='NETCDF4_CLASSIC')
dset = netCDF4.Dataset(infile,mode='r+')
#dset4 = netCDF4.Dataset(infile4)
dset2 = netCDF4.Dataset(infile2)
#dset = netCDF4.Dataset(infile3)

#tg1 = var

#print dset.dimensions.keys()
#print dset2.file_format
#print dset2.dimensions.keys()
#print dset3.file_format



#print dset
#print dset.dimensions.keys()
#print dset2.dimensions.keys()
#print dset2.dimensions[u'x1']

#print dset.dimensions[u'y']

#print 'dset:'
#print dset.variables.keys()
#print ' '
#print 'dset2:'
#print dset2.variables.keys() 
#
tg1 = dset.variables[u'topg']
cmb = dset.variables[u'climatic_mass_balance']
ist = dset.variables[u'ice_surface_temp']
bhf = dset.variables[u'bheatflx']

#tg1d=(tg1[:]).data
cmbd=(cmb[:]).data
ist=(ist[:]).data
bhfd=(bhf[:]).data

#print dset.variables()


#tg4 = dset.variables[u'topg']
#tg3 = dset3.variables[u'topg']
#
#print ' ' 
#print np.shape(tg1)
#print ' '
#print np.min(tg2[0])
#print ' '
#
#tg1s = tg1[:]

#tg1s = (tg1[:])
#tg1d =tg1s.data
#tg1d[tg1s.mask]=-5000.
#(tg1[:]).data=tg1d
#tg1[:]=tg1d


#### topg #####

#print np.min(tg1s)
#print np.min(tg1s.MaskedData)
#tg1s = tg1s.data
#tg1s[np.isnan(tg1s)] = -5000.

tg1s = (tg1[:])
tg1d =tg1s.data
tg1m = tg1s.mask
tg1d[tg1s.mask]=-5000.
tg1[:]=tg1d

#cmb.units='kg m-2 s-1'
#print 'updated:'
#print cmb[:]


#test=np.isnan(tg1s)

#tg1s = tg1s.getValue()

#tg1s=np.ma.getdata(tg1)
#tg1new = tg1s.data
#tg1new = np.zeros(np.shape(tg1[:,:]))
#tg1new[tg1new==0]=float('nan')
#print np.shape(tg1new)
#print tg1new
#print tg1s[0][:]
#tg1new[tg1s==False]=tg1s


#tg1new = np.ma.getdata(tg1s)
#print np.max(tg1new)
#print np.min(tg1new)
#print type(tg1new)
#tg1s2 = tg1s.compressed()
#tg1s[tg1s=='--']=float('nan')
#print np.shape(tg1s)
#print [tg1s=='--']
#print tg1s[0]
#tg1v2 = dset.variables[u'topg']
#print tg1v2[0]

#### cmb #####

#cmb.units='kg m-2 s-1'
#print 'updated:'
#print cmb[:]

#year = 31557600.
#cmbd = (cmb[:]).data
##print cmbd
#cmbd = cmbd*1000./year 
#print cmbd
#cmb[:]=cmbd

#print cmb
#print cmb[:]

##### ist #####

#ist.units = 'Kelvin'
#istd = (ist[:]).data
#print istd
#istd += 273.15
#print istd
#ist[:]=istd

##### bhf #####

#bhf.units='mW m-2'

dset.close()

#print tg3[0]
#print float('nan')
#print 'Other variable:'
#thkl = dset2.variables[u'thk']
#print thkl[0][0]
#print np.shape(thkl)