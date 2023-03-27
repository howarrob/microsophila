#!/bin/bash

# use sufficient python version:
# TODO: make this step system-agnostic
module load python/3.8 # make BYU ORC system python be version 3.8
version=$(python --version)
if [[ ! $version =~ "Python 3.8" ]]; then
  echo "Are you sure $version will work?"
  # works with python 3.8, but not 3.6.
  # 3.6 apparently lacks certain development files
  # (e.g. error mentions "Python.h") which are
  # needed to build biom-format.
fi

# create and activate virtual env
python -m venv "$MICROSOPHILA_INSTALL_PATH/metaphlan_env"
source "$MICROSOPHILA_INSTALL_PATH/metaphlan_env/bin/activate"

# install dependencies
pip install numpy biopython

# optional: visually confirm installed python packages:
# pip freeze # should see numpy and biopython

# add bowtie2 to user path (if absent)
if [[ ! "$PATH" =~ "bowtie2" ]]; then
  # Note: unless you add the following line to your own .bashrc,
  # metaphlan will fail in future shell sessions.
  export PATH="$PATH:$MICROSOPHILA_INSTALL_PATH/bowtie2"
fi
# confirm bowtie2 added to path
if [[ ! "$PATH" =~ "bowtie2" ]]; then
  echo "Failed to add bowtie2 to path. Cannot proceed with metaphlan install." && exit 1
fi

# install metaphlan
pip install metaphlan # this install will install many additional packages...

# download and build database. This is the step which requires bowtie2
# As a cautionary tale, I've run it without bowtie2 in PATH and it didn't
# warn me, it just proceeded to download the files, but didn't build them.
# Subsequently, I tried to run metaphlan, which crashed, reporting that
# a .pkl file should be found among the database files. Turns out this
# is only the case if the database files were build by bowtie2 as part
# of "metaphlan --install". Solved by adding bowtie2 to PATH, removing
# database files, and running "metaphlan --install" a second time. This
# time, the .pkl file did appear. I presume it is an output of bowtie2
# (perhaps bowtie2-build?).
mkdir "$MICROSOPHILA_STORAGE_PATH/metaphlan_database"
metaphlan --install --bowtie2db "$MICROSOPHILA_STORAGE_PATH/metaphlan_database"
