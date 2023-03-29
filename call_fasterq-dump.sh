#!/bin/bash

#SBATCH --time=00:30:00   # walltime
#SBATCH --ntasks=6 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=6GB # memory per CPU core

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  accession_name="SRR1525774" # <<< or hard-code value here
  read -p "No accession name was provided, would you like to use $accession_name as input? (y/n)" $yn
  [[ $yn -ne "y" ]] && exit 1
fi

accession_path="$MICROSOPHILA_STORAGE_PATH/$accession_name"
sra_bin_path="$MICROSOPHILA_INSTALL_PATH/sratoolkit/bin"

"$sra_bin_path/fasterq-dump" "$accession_path/sra/$accession_name" \
                        -O "$accession_path/with_host" \
                        -t "$accession_path/with_host" \
                        -e 6
