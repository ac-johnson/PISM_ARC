#!/bin/sh

#SBATCH --partition=PART
#SBATCH --ntasks=NN
#SBATCH --tasks-per-node=24
#SBATCH --mail-user=acjohnson16@alaska.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output=pismr.%j


echo "nodes: "NN
echo "parition: "PART

ulimit -s unlimited
ulimit -l unlimited

# Load any desired modules, usually the same as loaded to compile
. /etc/profile.d/modules.sh
# module purge
# module load toolchain/pic-intel/2016b
# module load slurm

cd SLURM_SUBMIT_DIR
# Generate a list of allocated nodes; will serve as a machinefile for mpirun
srun -l /bin/hostname | sort -n | awk '{print 2}' > ./nodes.SLURM_JOB_ID
# Launch the MPI application

mpiexec -n NN -machinefile ./nodes.SLURM_JOB_ID pismr -i Inspin \
  -Mx mx -My my \
  -skip -skip_max 20 \
  -bed_smoother_range 5e3 \
  -grid.correct_cell_areas false -grid.registration corner \
  -ys -Yst -ye Yet \
  -surface given -surface_given_file Inboot \
  -atmosphere given,lapse_rate -atmosphere_given_file Inboot \
  -atmostphere_lapse_rate_file Inboot -temp_lapse_rate lapr \
  -ocean constant -ocean.sub_shelf_heat_flux_into_ice sshfi \
  -sia_e SIAe -ssa_e SSAe -stress_balance ssa+sia \
  -topg_to_phi TGPhi -pseudo_plastic -pseudo_plastic_q PPQ \
  -pseudo_plastic_uthreshold PPUt \
  -till_effective_fraction_overburden TEFO \
  calvstr \
  -eigen_calving_K ecalvK -thickness_calving_threshold tcalvt \
  -subgl -kill_icebergs nsbm bdef \
  -tauc_slippery_grounding_lines -ts_file "Outlocts_Outfm" -ts_times -Yst:yearly:Yet \
  -extra_file "Outlocex_Outfm" -extra_times -Yst:100:Yet \
  -extra_vars diffusivity,temppabase,tempicethk_basal,bmelt,tillwat,velsurf_mag,mask,thk,topg,usurf,hardav,velbase_mag,tauc,tendency_of_ice_amount_due_to_discharge,dHdt \
  -o "OutlocOutfm"

# Clean up the machinefile
rm ./nodes.SLURM_JOB_ID
the machinefile
rm ./nodes.$SLURM_JOB_ID
