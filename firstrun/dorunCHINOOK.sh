#!/bin/bash

#Required vars:
#	NN	cores
#	Yst	year start
#	Inspin	input file from spinup
#	Inboot	input bootstrap file
#	Outfile	output file

#Vars set to defaults if unset:
#	SIAe	sia_e val
#	SSAe	ssa_e val
#	TGPhi	topg_to_phi val
#	PPQ	psuedo_plastic_q val
#	TEFO	till_effective_fraction_overburden val
#	ecalvK	eigen_calving_K val
#	tcalvt	thickness_calving_threshold val
#	lapr	lapse_rate var
#	nsbm	no_subgl_basal_melt
#		Note: If this val is set to anything then it will be
#		turned on
#	bdef	bed_def val
#		Note: If this val is set to anything then a string of
#		"-bed_def "$bdef will be created and used


### Check and set vars ###

if [ -z ${NN+1} ];
then echo "Set NN number of cores!"; fi

if [ -z ${SIAe+1} ];
then export SIAe=2.0; fi

if [ -z ${SSAe+1} ];
then export SSAe=0.65; fi

if [ -z ${PPQ+1} ];
then export PPQ=0.25; fi

if [ -z ${TEFO+1} ];
then export TEFO=0.25; fi

if [ -z ${TGPhi+1} ];
then export TGPhi=15.0,40.0,-700,-100; fi

#if [ -z ${TFGO+1} ];		#What is this??
#then TFGO=15.0,40,-700,-100; fi

if [ -z ${ecalvK+1} ];
then export ecalvK=5e15; fi

if [ -z ${tcalvt+1} ];
then export tcalvt=50; fi

if [ -z ${lapr+1} ];
then export lapr=8; fi

#Options to enable:
if [ -z ${nsbm+1} ];
then export nsbm="";
else export nsbm="-no_subgl_basal_melt"; fi

if [ -z ${bdef+1} ];
then export bdefstr="";
else export bedfstr="-bed_def "$bdef; fi

if [ -z ${set_fk}+1 ];
then export calvstr="-calving float_kill,eigen_calving,thickness_calving";
else export calvstr="-calving eigen_calving,thickness_calving"; fi


#default vals:

#SIAe=2.0
#SSAe=0.65
#PPQ=0.25
#TGPhi=15.0,40.0,-700,-100
#TEFO=0.02
#lapr=8 K/km
#ecalvK = 5e15
#tcalvt = 50m
#Inspin=end_evol-5km_Ant_spinup_W65.nc
#Inboot=PISM_1km.nc
#nsbm=  (empty) #yes basal melt
#bdef=  (empty) #no bed def
#mx= 	1157
#my=	994
#TO SET: mantle viscosity of 1e20

sbatch dorun.slurm



#mpiexec -n 8 pismr -i ../end_evol-5km_Ant_spinup_W65.nc -bootstrap -Mx 301 -My 561 -Mz 201 -Mbz 21 -z_spacing equal -Lz 4000 -Lbz 2000 -skip -skip_max 20 -grid.correct_cell_areas false -grid.registration corner -ys -500 -ye 0 -surface given -surface_given_file pism_Greenland_5km_v1.1.nc -calving ocean_kill -ocean_kill_file pism_Greenland_5km_v1.1.nc -sia_e 3.0 -stress_balance ssa+sia -topg_to_phi 15.0,40.0,-300.0,700.0 -pseudo_plastic -pseudo_plastic_q 0.25 -till_effective_fraction_overburden 0.02 -tauc_slippery_grounding_lines -ts_file ts_test.nc -ts_times -500:yearly:0 -extra_file ex_test.nc -extra_times -500:100:0 -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc -o test.nc
