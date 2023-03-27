# see also: instructions found at https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit
# download pre-built binaries from NCBI
wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

# extract pre-built binaries
tar vxzf sratoolkit.tar.gz
# get the name of the directory that was just extracted (e.g. sratoolkit.3.0.1-ubuntu64)
name_to_replace=$(tar tf sratoolkit.tar.gz | head -1)
mv $name_to_replace sratoolkit
rm sratoolkit.tar.gz

# optional:
# test that binaries work on your system and that the download and extraction were successful:
# fastq-dump --stdout -X 2 SRR390728
