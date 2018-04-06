#!/bin/sh

#SBATCH --partition=NonePART
#SBATCH --ntasks=NoneNN
#SBATCH --tasks-per-node=24
#SBATCH --mail-user=acjohnson16@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output=pismr.%j


echo "nodes: "NoneNN
echo "parition: "NonePART

ulimit -s unlimited
ulimit -l unlimited

# Load any desired modules, usually the same as loaded to compile
. /etc/profile.d/modules.sh
# module purge
# module load toolchain/pic-intel/2016b
# module load slurm

cd NoneSLURM_SUBMIT_DIR
# Generate a list of allocated nodes; will serve as a machinefile for mpirun
srun -l /bin/hostname | sort -n | awk '{print None2}' > ./nodes.NoneSLURM_JOB_ID
# Launch the MPI application

mpiexec -n NoneNN -machinefile ./nodes.NoneSLURM_JOB_ID pismr -i NoneInspin \
  -Mx Nonemx -My Nonemy \
  -skip -skip_max 20 \
  -bed_smoother_range 5e3 \
  -grid.correct_cell_areas false -grid.registration corner \
  -ys -NoneYst -ye NoneYet \
  -surface given -surface_given_file NoneInboot \
  -atmosphere given,lapse_rate -atmosphere_given_file NoneInboot \
  -atmostphere_lapse_rate_file NoneInboot -temp_lapse_rate Nonelapr \
  -ocean constant -ocean.sub_shelf_heat_flux_into_ice Nonesshfi \
  -sia_e NoneSIAe -ssa_e NoneSSAe -stress_balance ssa+sia \
  -topg_to_phi NoneTGPhi -pseudo_plastic -pseudo_plastic_q NonePPQ \
  -pseudo_plastic_uthreshold NonePPUt \
  -till_effective_fraction_overburden NoneTEFO \
  Nonecalvstr \
  -eigen_calving_K NoneecalvK -thickness_calving_threshold Nonetcalvt \
  -subgl -kill_icebergs Nonensbm Nonebdef \
  -tauc_slippery_grounding_lines -ts_file "NoneOutlocts_NoneOutfm" -ts_times -NoneYst:yearly:NoneYet \
  -extra_file "NoneOutlocex_NoneOutfm" -extra_times -NoneYst:100:NoneYet \
  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,tendency_of_ice_amount_due_to_discharge,dHdt \
  -o "NoneOutlocNoneOutfm"

# Clean up the machinefile
rm ./nodes.NoneSLURM_JOB_ID
