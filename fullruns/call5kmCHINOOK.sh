runstart=1
runend=3

#export mx=560
#export my=499

export NN=288
export PART=t1standard

for i in $(seq $runstart $runend);
do export Outfm="Ant_run"$i".nc";
cd $HOME/PISM_ARC/fullruns/run$i
./callrunCHINOOK.sh
done
