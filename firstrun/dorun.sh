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
then SIAe=2.0; fi

if [ -z ${SSAe+1} ];
then SSAe=0.65; fi

if [ -z ${PPQ+1} ];
then PPQ=0.25; fi

if [ -z ${TEFO+1} ];
then TEFO=0.25; fi

if [ -z ${TGPhi+1} ];
then TGPhi=15.0,40.0,-700,-100; fi

#if [ -z ${TFGO+1} ];		#What is this??
#then TFGO=15.0,40,-700,-100; fi

if [ -z ${ecalvK+1} ];
then ecalvK=5e15; fi

if [ -z ${tcalvt+1} ];
then tcalvt=50; fi

if [ -z ${lapr+1} ];
then lapr=8; fi

#Options to enable:
if [ -z ${nsbm+1} ];
then nsbm=" ";
else nsbm="-no_subgl_basal_melt"; fi

if [ -z ${bdef+1} ];
then bdefstr=" ";
else bedfstr="-bed_def "$bdef; fi


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
#nsbm=  (empty)
#bdef=  (empty)
#mx= 	1157
#my=	994

mpiexec -n $NN pismr -i $Inboot -bootstrap \
  -regrid_file $Inspin \
  -regrid_vars bwat,bmelt,dbdt,litho_temp,mask,temp_pa,enthalpy \
  -Mx 1157 -My 994 -Mz 121 -Lz 6000 -Mbz 20 -Lbz 2000 \
  -z_spacing quadratic -zb_spacing equal \
  -skip -skip_max 20 \
  -grid.correct_cell_areas false -grid.registration corner \
  -ys -$Yst -ye 0 \
  -surface given -surface_given_file $Inboot \
  -atmosphere given,lapse_rate -atmosphere_given_file $Inboot \
  -atmostphere_lapse_rate_file $Inboot -temp_lapse_rate $lapr\
  -sia_e $SIAe -ssa_e $SSAe -stress_balance ssa+sia \
  -topg_to_phi $TGPhi -pseudo_plastic -pseudo_plastic_q $PPQ \
  -till_effective_fraction_overburden $TEFO \
  -calving float_kill \
  -calving eigen_calving -eigen_calving_K $ecalvK \
  -calving thickness_calving -thickness_calving_threshold $tcalvt \
  -subgl $nsbm $bdefstr \
  -tauc_slippery_grounding_lines -ts_file ts_$Outfile -ts_times -$Yst:yearly:0 \
  -extra_file ex_$Outfile -extra_times -$Yst:50:0 \
  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,strain_rates,discharge_,deviatoric_stresses \
  -o $Outfile



#mpiexec -n 8 pismr -i ../end_evol-5km_Ant_spinup_W65.nc -bootstrap -Mx 301 -My 561 -Mz 201 -Mbz 21 -z_spacing equal -Lz 4000 -Lbz 2000 -skip -skip_max 20 -grid.correct_cell_areas false -grid.registration corner -ys -500 -ye 0 -surface given -surface_given_file pism_Greenland_5km_v1.1.nc -calving ocean_kill -ocean_kill_file pism_Greenland_5km_v1.1.nc -sia_e 3.0 -stress_balance ssa+sia -topg_to_phi 15.0,40.0,-300.0,700.0 -pseudo_plastic -pseudo_plastic_q 0.25 -till_effective_fraction_overburden 0.02 -tauc_slippery_grounding_lines -ts_file ts_test.nc -ts_times -500:yearly:0 -extra_file ex_test.nc -extra_times -500:100:0 -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc -o test.nc
