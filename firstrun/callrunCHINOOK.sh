#export NN=24
#export PART="debug"
export mx=1119
export my=997
export Inspin=$CENTER1/maps/end_evol-5km_Ant_spinup_W65.nc
#export Inboot=$Inspin
export Inboot=$CENTER1/maps/PISM_1km_v3.nc
export Yst=0.1
export Outloc=$CENTER1/runs/
export Outfm=Ant_1yr_fk_debug.nc
#export set_fk=0

./dorunCHINOOK.sh

#alternative
#mx=560
#my=499
