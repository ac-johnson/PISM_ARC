export Outfm=Ant_1yr_fk.nc
/export set_fk=1

#export SSAe=1.0
#export PPQ=1
#export TGPhi=10.0,30.0,-700,-100
#export ecalvK=
#export PPUt=100
#export SIAe=2

export mx=1119
export my=997
export Inspin=$CENTER1/maps/end_evol-5km_Ant_spinup_W65.nc
#export Inspin=$CENTER1/maps/Ant_1yr_fk.nc
#export Inboot=$Inspin
export Inboot=$CENTER1/maps/PISM_1km_v3.nc
export Yst=0
export Yet=1
export Outloc=$CENTER1/maps/

./dorunCHINOOK.sh

#alternative
#mx=560
#my=499
