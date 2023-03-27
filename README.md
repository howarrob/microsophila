# microsophila

Please add these lines to your bashrc:

export MICROSOPHILA_STORAGE_PATH=/path/to/device/with/lots/of/space  
export MICROSOPHILA_INSTALL_PATH=/another/path/possibly/same # e.g. INSTALL_PATH=~ or INSTALL_PATH=$STORAGE_PATH
export PATH="$PATH:$MICROSOPHILA_INSTALL_PATH/bowtie2" # path is created once bowtie2 is installed

Once your .bashrc contains these lines, don't forget to "source" it (e.g. source ~/.bashrc).
