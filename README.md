# microsophila

Please add these lines to your bashrc:

export STORAGE_PATH=/path/to/device/with/lots/of/space  
export INSTALL_PATH=/another/path/possibly/same # e.g. INSTALL_PATH=~ or INSTALL_PATH=$STORAGE_PATH
export PATH="$PATH:$INSTALL_PATH/bowtie2" # path is created once bowtie2 is installed

Once your .bashrc contains these lines, don't forget to "source" it (e.g. source ~/.bashrc).
