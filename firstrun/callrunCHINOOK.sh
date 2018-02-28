#export NN=8
export Inspin=$CENTER1/map/end_evol-5km_Ant_spinup_W65.nc
export Inboot=$CENTER1/map/PISM_1km_v4.nc
export Yst=1
export Outfile=$CENTER1/runs/Ant_1yr_fk.nc

./dorunCHINOOK.sh
