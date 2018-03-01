export NN=24
export PART="debug"
export mx=1119
export my=997
export Inspin=$CENTER1/map/end_evol-5km_Ant_spinup_W65.nc
export Inboot=$CENTER1/map/PISM_1km_v4.nc
export Yst=1
export Outloc=$CENTER1/runs/
export Outfm=Ant_1yr_fk.nc

./dorunCHINOOK.sh

#alternative
#mx=560
#my=499
