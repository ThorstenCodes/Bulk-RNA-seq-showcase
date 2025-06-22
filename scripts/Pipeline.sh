#!/bin/zsh

SECONDS=0

#Change to Project Path
cd /Users/thorsten/code/ThorstenCodes/Bioinformatics_TK/Projects/RNASeq_Pipeline/

#This is a loop running FASTQC quality control over all .fastq files in the data directory
for file in data/*.fastq; do
fastqc "$file" -o data/
done

# Next we trim reads using trimmomatic. The following is if you have single end reads:
java -jar /Users/thorsten/code/ThorstenCodes/Bioinformatics_TK/Tools/Trimmomatic-0.39/trimmomatic-0.39.jar SE data/demo.fastq data/demo_trimmed.fastq

# if you have paired end reads:
java -jar /Users/thorsten/code/ThorstenCodes/Bioinformatics_TK/Tools/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  data//sample_R2.fastq \
  data/sample_R1_paired.fastq data/sample_R1_unpaired.fastq \
  data/sample_R2_paired.fastq data/sample_R2_unpaired.fastq \
  ILLUMINACLIP:adapters.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
