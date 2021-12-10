#!/bin/bash
#SBATCH --job-name=glob_mutant_s
#SBATCH --error=docking_global_mutant_short_%j.err
#SBATCH --qos=normal
#SBATCH --array=0-19
#SBATCH --time=40:00:00
#SBATCH -p normal
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=8000
ml load rosetta

for file in mutant_complexes/*; do srun rosetta_scripts.static.linuxgccrelease -s $file -parser:protocol mutant_helix_docking.xml -in:file:override_rot_lib_path ncaa_rotamer_libraries -ex1 -ex2 -out:prefix docking_mutants${SLURM_ARRAY_TASK_ID}_ -nstruct 1 -native native_helix_rbd_complex_relaxed_renumbered.pdb >> docking_mutants.log; done