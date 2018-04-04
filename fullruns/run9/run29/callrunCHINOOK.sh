#export Outfm=Ant_run54.nc
#export set_fk=1

export SSAe=0.30
export PPQ=0.25
export TGPhi=15.0,40.0,-700,-100
export ecalvK=5e15
export PPUt=100
export SIAe=2

export mx=560
export my=499
export Inspin=$CENTER1/maps/end_evol-5km_Ant_spinup_W65.nc
#export Inspin=$CENTER1/maps/Ant_1yr_fk.nc
#export Inboot=$Inspin
export Inboot=$CENTER1/maps/PISM_1km_v3.nc
export Yst=0
export Yet=1000
export Outloc=$CENTER1/runs/

./dorunCHINOOK.sh

#alternative
#mx=560
#my=499
