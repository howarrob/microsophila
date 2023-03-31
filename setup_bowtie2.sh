# see also: offical docs: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml
# download pre-built binaries
wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.5.1/bowtie2-2.5.1-linux-x86_64.zip/download

# extract pre-built binaries
unzip download

# get the name of the directory that was just extracted (e.g. bowtie2-2.5.1-linux-x86_64)
name_to_replace=$(unzip -l download | head -4 | tail -1 | awk '{print $4}')

# rename package to bowtie2
mv $name_to_replace bowtie2

# remove .zip file
rm download

# set up reference sequence
mkdir "$MICROSOPHILA_STORAGE_PATH/ref"
dm_ref_path="$MICROSOPHILA_STORAGE_PATH/ref/d_melanogaster"
mkdir "$dm_ref_path"

# download
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz > "$dm_ref_path/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz"
gunzip "$dm_ref_path/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz"

# build index
bowtie2-build -f "$dm_ref_path/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna" "$dm_ref_path/bt2_index"
