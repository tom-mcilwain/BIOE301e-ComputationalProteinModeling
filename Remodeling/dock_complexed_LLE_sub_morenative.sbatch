#!/bin/bash
#SBATCH --job-name=glob_mn_s
#SBATCH --error=docking_global_morenative_short_%j.err
#SBATCH --qos=normal
#SBATCH --array=0-19
#SBATCH --time=40:00:00
#SBATCH -p normal
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=8000
ml load rosetta

srun rosetta_scripts.static.linuxgccrelease -s native_helix_rbd_complex_relaxed_renumbered.pdb -parser:protocol remodeled_helix_docking_global_short.xml -ex1 -ex2 -out:prefix docking_morenative${SLURM_ARRAY_TASK_ID}_ -nstruct 20 -out:file:silent docked_native.silent -native native_helix_rbd_complex_relaxed_renumbered.pdb > docking_morenative.log

for file in complexed_LLE_sub_morenative_pdbs_top12/*; do srun rosetta_scripts.static.linuxgccrelease -s $file -parser:protocol remodeled_helix_docking_global_short.xml -ex1 -ex2 -out:prefix docking_morenative${SLURM_ARRAY_TASK_ID}_ -nstruct 20 -out:file:silent docked_${file:40:23}.silent -native native_helix_rbd_complex_relaxed_renumbered.pdb >> docking_morenative.log; done

