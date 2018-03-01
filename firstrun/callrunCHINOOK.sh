#export NN=8
export mx=1157
export my=994
export Inspin=$CENTER1/map/end_evol-5km_Ant_spinup_W65.nc
export Inboot=$CENTER1/map/PISM_1km_v4.nc
export Yst=1
export Outloc=$CENTER1/runs/
export Outfm=Ant_1yr_fk.nc

./dorunCHINOOK.sh
