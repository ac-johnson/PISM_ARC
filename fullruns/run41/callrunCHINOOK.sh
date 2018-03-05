#export NN=24
#export PART="debug"
export mx=560
export my=499
#export Inspin=$CENTER1/maps/end_evol-5km_Ant_spinup_W65.nc
export Inspin=$CENTER1/runs/Ant_1yr_fk.nc
#export Inboot=$Inspin
export Inboot=$CENTER1/maps/PISM_1km_v3.nc
export Yst=0
export Yet=1000
export Outloc=$CENTER1/runs/
export Outfm=Ant_run41.nc
export set_fk=1
export SIAe=4
export SSAe=1.5
export PPQ=1
export TGPhi=1.0,15.0,-700,-100

./dorunCHINOOK.sh

#alternative
#mx=560
#my=499
