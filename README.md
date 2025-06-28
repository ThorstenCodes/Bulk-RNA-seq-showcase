# RNA-Seq Pipeline: From Raw Reads to Count Matrix

This repository contains a fully functional and beginner-friendly RNA-seq pipeline, expanded in detail beyond the excellent Bioinformagician's tutorial. It demonstrates how to process bulk RNA-seq data — from raw FASTQ files all the way to a count matrix — using widely adopted tools.

## 🔬 Pipeline Overview

The pipeline includes the following steps:

**Quality Control** <br>
Tool: FastQC <br>
Assess the quality of your raw reads.

**Trimming Low-Quality Bases** <br>
Tool: Trimmomatic <br>
Supports both single-end and paired-end reads.

**Genome Alignment** <br>
Tool: HISAT2 <br>
Align reads to a reference genome.

**Quantification** <br>
Tool: featureCounts <br>
Generate a count matrix for downstream differential expression analysis.

## 📒 Jupyter Notebook

A Jupyter Notebook is included to:

- Provide setup instructions for local Git repositories and how to commit changes to GitHub.
- Show how to simulate human RNA-seq FASTQ files using ART, useful for training purposes when access to real data is limited.
- Offer useful Visual Studio Code tips (e.g., how to quickly comment/uncomment blocks of code).

## 🛠️ Notes

Many code blocks are commented out intentionally:

- To prevent re-running steps that only need to be executed once (e.g., tool installation, directory setup).
- To support flexibility between single-end and paired-end read processing.

It is recommended to start with the Jupyter Notebook for setups (if you need it) and then refer to the scripts (Pipeline.sh) for more detailed comments on each step of the Pipeline.

## 🙏 Acknowledgments

Special thanks to Bioinformagician for the inspiration and base tutorial that this repository builds upon. If you're just getting started with RNA-seq analysis, her videos are a great resource. 



