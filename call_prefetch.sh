#!/bin/bash

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  accession_name="SRR1525774" # <<< or hard-code name here
  read -p "No accession name was provided, would you like to prefetch $accession_name? (y/n)" $yn
  [[ $yn -ne "y" ]] && exit 1
fi

# if this is a new accession, create accession directory and prefetch reads.
# tolerate case where accession directory exists, but SRA files aren't contained therein.
if [[ ! -d "$MICROSOPHILA_STORAGE_PATH/$accession_name/sra" ]]; then
  if [[ ! -d "$MICROSOPHILA_STORAGE_PATH/$accession_name" ]]; then
    mkdir "$MICROSOPHILA_STORAGE_PATH/$accession_name"
  fi
  mkdir "$MICROSOPHILA_STORAGE_PATH/$accession_name/sra"
else
  # the reads have probably already been prefetch'd
  echo "Failed to prefetch reads. Directory \"$accession_name/sra\" already exists."
  echo "Have this accession's reads already been prefetch'd?"
  exit 1
fi

output_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/sra"

'$MICROSOPHILA_INSTALL_PATH/sratoolkit/bin/prefetch" $accession_name -O "$output_path"

# check prefetch's exit status to confirm that download was successful
if [[ $? -ne 0 ]]; then
  echo "*!*!* prefetch returned non-zero exit code. Considering task unsuccessful. *!*!*"
  rmdir "$output_path" || echo "Couldn't clean up ${output_path}, please help me!"
fi
