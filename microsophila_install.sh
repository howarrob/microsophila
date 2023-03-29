#!/bin/bash

if [[ -z $MICROSOPHILA_INSTALL_PATH || -z $MICROSOPHILA_STORAGE_PATH || ! $PATH =~ bowtie2 ]]; then
  echo "Missing environment variables. Please see instructions in README.md to add them to PATH."
  exit 1
fi

./setup_sratools.sh
./setup_bowtie2.sh
./setup_metaphlan.sh
