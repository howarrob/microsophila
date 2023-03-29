#!/bin/bash

#SBATCH --time=01:00:00   # walltime
#SBATCH --ntasks=32 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=1GB # memory per CPU core

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  accession_name="SRR1525774" # <<< or hard-code value here
  read -p "No accession name was provided, would you like to use $accession_name as input? (y/n)" $yn
  [[ $yn -ne "y" ]] && exit 1
fi

bowtie_bin_path="$MICROSOPHILA_INSTALL_PATH/bowtie2"
input_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/with_host"
output_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/microbiome"

# TODO:
# provide read length, fragment size (probably unnecessary since we only care about unmapped reads)
# may want to do some tuning for targeting microbiome reads.

# output directory must exist
if [[ ! -d "$output_path" ]]; then
  mkdir "$output_path"
fi

"$bowtie_bin_path/bowtie2" --threads 32 \
                         -x "$MICROSOPHILA_STORAGE_PATH/ref/drosophila_index" \
                         -1 "$input_path/${accession_name}_1.fastq" \
                         -2 "$input_path/${accession_name}_2.fastq" \
                         -U "$input_path/${accession_name}.fastq" \
                         -S /dev/null \
                         --un-conc "$output_path/microbiome_reads.fastq" \
                         --un "$output_path/microbiome_reads.fastq"

# if successful, copy bowtie2 output to output directory
if [[ $? -eq 0 ]]; then
  cp slurm-${SLURM_JOB_ID}.out "$output_path/bowtie2_output.txt"
fi
