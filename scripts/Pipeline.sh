#!/bin/zsh

SECONDS=0

#Change to Project Path
cd /Users/thorsten/code/ThorstenCodes/Bioinformatics_TK/Projects/RNASeq_Pipeline/

###################################
######### FAST QC #################
###################################

#This is a loop running FASTQC quality control over all .fastq files in the data directory before trimming. Activate it if you didn't run it at all but later you don't want to run it again everytime.
# for file in data/*.fastq; do
# fastqc "$file" -o data/
# done

# Next we trim reads using trimmomatic. The following is if you have single end reads:
# TRAILING trims to remove up to 10 base pairs from the end of the read if they are low quality
# -phred33 converts the quality score to phred33 format
java -jar ../../Tools/Trimmomatic-0.39/trimmomatic-0.39.jar SE data/demo.fastq data/demo_trimmed.fastq TRAILING:10 -phred33
echo "Trimmomatic for Single End finished running!"

# We run fastqc again to see what effect had trimming on the fastq files (we only do this here with the single end reads)
fastqc data/demo_trimmed.fastq -o data/

####################################
# if you have paired end reads:####
####################################

for R1 in data/*1.fastq; do
  # This is a string substitution. Sow we get both paired reads and save them as variable. Here we replace the end of the fastq file ('1.fastq') with '2.fastq'. R1 is defined through the loop!
  # String substitution: ${variable/pattern/replacement}
  R2=${R1/1.fastq/2.fastq} #we are still in the loop!

  # Extract the base name of the file using basename (to remove the Path) and suffix (1.fastq) which is also removed, so in the end only everything before the 1.fastq is in the variable
  BASE=$(basename "$R1" 1.fastq)

  # With paired end reads trimmomatic generates 4 output files. Paired are the paired reads after trimming but if during trimming a read beomce to short, it could be that it gets removed and the other read would stand alone.
  # Those reads are collected in "unpaired.fastq". Therefore we need to define 4 output files:
  OUT_R1_PAIRED="data/${BASE}1_paired.fastq"
  OUT_R1_UNPAIRED="data/${BASE}1_unpaired.fastq"
  OUT_R2_PAIRED="data/${BASE}2_paired.fastq"
  OUT_R2_UNPAIRED="data/${BASE}2_unpaired.fastq"

  # Run Trimmomatic PE
  # TRAILING trims up to 5 base pairs from the end of the read if they are low quality
  # LEADING trims up to 5 base pairs from the beginning of the read if they are low quality
  # MINLEN Drops reads that are shorter then 36 bp after trimming

  java -jar ../../Tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
    -threads 4 \
    "$R1" "$R2" \
    "$OUT_R1_PAIRED" "$OUT_R1_UNPAIRED" \
    "$OUT_R2_PAIRED" "$OUT_R2_UNPAIRED" \
    LEADING:5 TRAILING:5 MINLEN:36 -phred33
done

echo "Trimmomatic for paired end reads has finished running!"

#######################################
######################################
#####################################


#echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
