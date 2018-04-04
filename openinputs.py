# -*- coding: utf-8 -*-
"""
Created on Fri Mar 30 11:49:07 2018

@author: andrewjohnson
"""

# How to set up PISM runs:
#
# Use the "CreateDefaults" script to create a numpy array of default values.
# Create an input CSV. The first line should be keys which align with the
#   keys from the defaults file, and then values entered for each run.

import csv
import numpy as np
import os

defaultfile = 'defaults.npy'
inputfile = 'Inputtest.csv'
outns = 'Ant_'              #out name start

#Values that must be in defaults list:
#    
#    runname,sfile,NN,PART,mx,my,Inspin,Inboot

#sfile = 'run.slurm'
#sfile = run_regrid.slurm

dorunlist = range(57)
dorunlist = ['run'+str(i) for i in dorunlist]

defaults = np.load(defaultfile).item()

#food = {"ham" : "yes", "egg" : "yes", "spam" : "no" }
#test = {"key1" : (3, "True", "blue"), "key2" : (1, "False", "red")}

#print food["ham"]
#test["key3"]=(2,,"green")
#print test["key1"][0]
#print test["key3"]

csvfile = open(inputfile)
readCSV = csv.reader(csvfile, delimiter=',')
readCSVd = csv.DictReader(csvfile)

def adddefaults(run,defaultfile):
    runkeys = run.keys()
    defaults = np.load(defaultfile).item()
    for key in defaults.keys():
        if key not in runkeys:
            run[key]=defaults[key]
        if not run[key]:
            run[key]=defaults[key]
            

for row in readCSVd:
    run = row
    if run['runname'] in dorunlist:
        run['Outfm']=outns+run['runname']+'.nc'

        adddefaults(run,defaultfile)

        sfile=run['sfile']
        os.system('cp '+sfile+' runtemp.slurm')
        os.system('rm fullruns/'+run['runname']+'/run.slurm')

        #Set up the sbatch tasks and partitions:
        #   (This cannot be done with variables other than just writing
        #   a new file)        
        f = open('runtemp.slurm','r+')
        s = f.read()
        for key in run.keys():
            s = s.replace('$'+key,str(run[key]))
            f.seek(0)

        f.seek(0)
        f.write(s)
        f.close()
        
        
        os.system('cp runtemp.slurm fullruns/'+run['runname']+'/run.slurm')
        os.system('rm runtemp.slurm')
        
        #os.system('sbatch fullruns/'+run['runname']+'/run.slurm')
    

#mpiexec -n $NN -machinefile ./nodes.$SLURM_JOB_ID pismr -i $Inspin \
#  -Mx $mx -My $my \
#  -skip -skip_max 20 \
#  -bed_smoother_range 5e3 \
#  -grid.correct_cell_areas false -grid.registration corner \
#  -ys -$Yst -ye $Yet \
#  -surface given -surface_given_file $Inboot \
#  -atmosphere given,lapse_rate -atmosphere_given_file $Inboot \
#  -atmostphere_lapse_rate_file $Inboot -temp_lapse_rate $lapr \
#  -sia_e $SIAe -ssa_e $SSAe -stress_balance ssa+sia \
#  -topg_to_phi $TGPhi -pseudo_plastic -pseudo_plastic_q $PPQ \
#  -pseudo_plastic_uthreshold $PPUt \
#  -till_effective_fraction_overburden $TEFO \
#  -calving $calvstr \
#  -eigen_calving_K $ecalvK -thickness_calving_threshold $tcalvt \
#  -subgl true $nsbm $bdefstr \
#  -tauc_slippery_grounding_lines -ts_file "${Outloc}ts_${Outfm}" -ts_times -$Yst:yearly:$Yet \
#  -extra_file "${Outloc}ex_${Outfm}" -extra_times -$Yst:100:$Yet \
#  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,tendency_of_ice_amount_due_to_discharge,dHdt \
#  -o "$Outloc$Outfm"


