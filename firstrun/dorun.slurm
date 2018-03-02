#!/bin/sh

#SBATCH --partition=$PART
#SBATCH --ntasks=$NN
#SBATCH --tasks-per-node=24
#SBATCH --mail-user=acjohnson16@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output=pismr.%j

ulimit -s unlimited
ulimit -l unlimited

# Load any desired modules, usually the same as loaded to compile
. /etc/profile.d/modules.sh
# module purge
# module load toolchain/pic-intel/2016b
# module load slurm

cd $SLURM_SUBMIT_DIR
# Generate a list of allocated nodes; will serve as a machinefile for mpirun
srun -l /bin/hostname | sort -n | awk '{print $2}' > ./nodes.$SLURM_JOB_ID
# Launch the MPI application
#sh $HOME/PISM_ARC/firstrun/callrunCHINOOK.sh
mpirun -np $NN -machinefile ./nodes.$SLURM_JOB_ID pismr -i $Inboot -bootstrap \
#  -regrid_file $Inspin \
  -regrid_vars bwat,bmelt,dbdt,litho_temp,mask,temp_pa,enthalpy \
  -Mx $mx -My $my -Mz 121 -Lz 6000 -Mbz 20 -Lbz 2000 \
  -z_spacing quadratic -zb_spacing equal \
  -bed_smoother_range 5e3 \
  -skip -skip_max 20 \
  -grid.correct_cell_areas false -grid.registration corner \
  -ys -$Yst -ye 0 \
  -surface given -surface_given_file $Inboot \
  -atmosphere given,lapse_rate -atmosphere_given_file $Inboot \
  -atmostphere_lapse_rate_file $Inboot -temp_lapse_rate $lapr \
  -sia_e $SIAe -ssa_e $SSAe -stress_balance ssa+sia \
  -topg_to_phi $TGPhi -pseudo_plastic -pseudo_plastic_q $PPQ \
  -till_effective_fraction_overburden $TEFO \
  -calving float_kill,eigen_calving,thickness_calving \
  -eigen_calving_K $ecalvK -thickness_calving_threshold $tcalvt \
  -subgl $nsbm $bdefstr \
  -tauc_slippery_grounding_lines -ts_file "${Outloc}ts_${Outfm}" -ts_times -$Yst:yearly:0 \
  -extra_file "${Outloc}ex_${Outfm}" -extra_times -$Yst:1:0 \
  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,tendency_of_ice_amount_due_to_discharge,dHdt \
  -o "$Outloc$Outfm"
#mpirun -n 24 -machinefile ./nodes.$SLURM_JOB_ID pismv -test G -y 200
# Clean up the machinefile
rm ./nodes.$SLURM_JOB_ID

