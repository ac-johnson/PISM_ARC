export NN=24
export mx=1119
export my=997
export Inspin=$HOME/maps/end_evol-5km_Ant_spinup_W65.nc
export Inboot=$HOME/maps/PISM_1km_v3.nc
#export Inboot=$Inspin
export Yst=1
export Outloc=$HOME/runs/
export Outfm=Ant_1yr_fk.nc
export set_fk=1
#export bdef=1


./dorun.sh

#mx= 	1157
#my=	994

#For square grid use:
#mx=1119
#my=997

#alternative mx: 290,560
#alternative my: 249,499
