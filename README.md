# microsophila

## getting started

### Step 0: clone repo

git clone https://github.com/adknaupp/microsophila.git
*** note the directory where you cloned ***

### Step 1: set up environment variables
Please add these lines to your bashrc:

# this should be on a device with lots of space
export MICROSOPHILA_STORAGE_PATH="~/compute"
export MICROSOPHILA_INSTALL_PATH="~"
export PATH="$PATH:$MICROSOPHILA_INSTALL_PATH/bowtie2"

Your home directory is a good place to set as the install path. If you want, the storage and install paths can be the same. Once your .bashrc contains these lines, don't forget to "source" it (e.g. source ~/.bashrc).

### Step 2: run script "microsophila_install.sh"

The install script checks that you have exported the variables from step 1 before proceeding to install sratools, bowtie2, and MetaPhlAn (as well as the respective dependencies of each).

### Step 3: run script "create_dummy_accession.sh"

To avoid having to generate real data, this script creates a child directory of $MICROSOPHILA_STORAGE_PATH to use for testing. So far, it contains some empty directories and a MetaPhlAn profile file.
