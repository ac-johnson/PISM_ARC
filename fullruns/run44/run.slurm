#!/bin/sh

#SBATCH --partition=t1small
#SBATCH --ntasks=48
#SBATCH --tasks-per-node=24
#SBATCH --mail-user=acjohnson16@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output=pismr.%j


echo "nodes: "48
echo "parition: "t1small

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
#echo "ecalvK: "1e17

mpiexec -n 48 -machinefile ./nodes.$SLURM_JOB_ID pismr -i $CENTER1/maps/PISM_1km_v3.nc -bootstrap \
  -regrid_file $CENTER1/maps/end_evol-5km_Ant_spinup_W65.nc \
  -regrid_vars bwat,bmelt,dbdt,litho_temp,mask,temp_pa,enthalpy \
  -Mx 560 -My 499 -Mz 121 -Lz 6000 -Mbz 20 -Lbz 2000 \
  -z_spacing quadratic -zb_spacing equal \
  -skip -skip_max 20 \
  -bed_smoother_range 5e3 \
  -grid.correct_cell_areas false -grid.registration corner \
  -ys -0 -ye 1000 \
  -surface given -surface_given_file $CENTER1/maps/PISM_1km_v3.nc \
  -atmosphere given,lapse_rate -atmosphere_given_file $CENTER1/maps/PISM_1km_v3.nc \
  -atmostphere_lapse_rate_file $CENTER1/maps/PISM_1km_v3.nc -temp_lapse_rate 8 \
  -ocean constant -ocean.sub_shelf_heat_flux_into_ice 0.5 \
  -sia_e 2.0 -ssa_e 0.65 -stress_balance ssa+sia \
  -topg_to_phi 15.0,40.0,-700,-100 -pseudo_plastic -pseudo_plastic_q 0.25 \
  -pseudo_plastic_uthreshold 100 \
  -till_effective_fraction_overburden 0.02 \
  -calving eigen_calving,thickness_calving \
  -eigen_calving_K 1e17 -thickness_calving_threshold 50 \
  -subgl -kill_icebergs $nsbm  \
  -tauc_slippery_grounding_lines -ts_file "$CENTER1/runsts_Ant_run44.nc" -ts_times -0:yearly:1000 \
  -extra_file "$CENTER1/runsex_Ant_run44.nc" -extra_times -0:100:1000 \
  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,tendency_of_ice_amount_due_to_discharge,dHdt \
  -o "$CENTER1/runsAnt_run44.nc"

# Clean up the machinefile
rm ./nodes.$SLURM_JOB_ID
