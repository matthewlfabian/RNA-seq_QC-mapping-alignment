# RNA-seq_QC-mapping-alignment
Snakemake workflow for FASTQ trimming (Trim Galore) & QC (FastQC; MultiQC), indexing/mapping to reference genome (HISAT2), SAM=>BAM conversion & mapping QC (SAMtools),
& gene-level (featureCounts) & splice-aware (rMATS) quantitation for Illumina paired-end reads.

# Overview

This pipeline utilizes paired-end Illumina reads as initial input for the
following steps:

- Raw read quality assessment (FastQC, MultiQC)
- Adapter and quality trimming (Trim Galore)
- Post-trimming quality assessment (FastQC, MultiQC)
- Indexing of annotated reference genome (HISAT2)
- Read mapping to reference genome (HISAT2)
- SAM => BAM conversion & read mapping QC (SAMtools)
- Gene-level read quantitation (featureCounts)
- Splice-aware read quantitation (rMATS)

Snakemake is a workflow management tool that facilitates organization & 
reproducibility in bioinformatics workflows. Packages are designated via .yaml
files ("envs" directory), & their corresponding parameters are found in .smk files in the "rules"
directory. The "rule all" section of the Snakefile lists target (e.g., trimmed FASTQs) outputs for the workflow, 
& Snakemake automatically determines which part(s) of the workflow to run, skipping any step whose 
output file already exists.

This workflow uses the Snakemake SLURM executor plug-in, which utilizes Snakemake as a coordinator to run components of the workflow as independent, 
parallel jobs, where possible. For example, FASTQ trimming via Trim Galore for 12 samples will yield 13 separate jobs: 1 job for each of the paired FASTQs, plus 
1 job corresponding to the Snakemake coordinator job. The configurations for this approach are stored in profiles/slurm/config.yaml, & the rules for each component 
of the workflow (e.g., Trim_Galore.smk) specify the resource requirements for that component.


# Dependencies

All dependencies are managed automatically via Conda using the 
environment files in the `envs/` directory.

- FastQC
- MultiQC
- Trim Galore
- HISAT2
- SAMtools
- featureCounts
- rMATS

# Setup
1.) If Snakemake isn't preloaded on your HPCC, install Snakemake:

  conda env create -f envs/snakemake.yaml

2.) Install the SLURM plug-in for Snakemake:

  pip install snakemake-executor-plugin-slurm

3.) In a parent directory of your choice, clone the repository, which automatically creates a folder for the Snakemake pipeline:

  git clone https://github.com/matthewlfabian/RNA-seq_QC-mapping-alignment.git
  
4.) Navigate to the newly created directory & verify the installed repository:

  git remote -v

5.) Edit "config/config.yaml" to include your strain/sample names. For example, for paired-end reads, 
strain/sample names from FASTQ files are identified as follows: <strain_1>_1.fastq.gz, <strain_1>_2.fastq.gz, <strain_2>_2.fastq.gz, etc.

  samples:
    - SAMPLE1
    - SAMPLE2
    - ...

6.) In your Snakemake directory, create the subdirectories "FASTQ" & "FASTQ/raw", then place your raw FASTQ files (matching the sample
  names above) in "FASTQ/raw".

7.) In your Snakemake directory, create the subdirectory "reference", then place your reference genome assembly FASTA (e.g., "ref_assembly.fasta")
& annotations GTF file (e.g., "ref_annotations.gtf"). The GTF file should have a column, "gene_ID", assigning coordinates to gene IDs.

8.) Edit "config/config.yaml" to include the assembly FASTA (ref_assembly: "reference/<your reference assembly>.fasta") & annotations GTF 
(ref_annotation: "reference/<your reference annotations>.gtf") for your reference genome, per step 5.).



# Running the Pipeline

This pipeline is designed to be run in 3 stages: 1.) initial quality assessment of raw FASTQs; 2.) FASTQ trimming and quality assessment of trimmed reads; 
@ 3.) indexing/mapping to reference genome, SAM=>BAM conversion, & gene-level & splice-aware read quantitation. By utilizing the comment mark (#) in the Snakefile, 
the workflow can be run stepwise, permitting the review of FastQC/MultiQC reports before subsequent steps. The workflow can be run 
in full by "uncommenting" all stages in the Snakefile. Snakemake must be activated (i.e., "conda activate snakemake") before running the workflow. To run the Snakemake workflow on a HPCC:

```bash
conda activate snakemake
snakemake --cores 10 --use-conda
```

At any stage, a "dry run" can be conducted to verify the logic of the workflow:

To preview what Snakemake will run without executing anything:

```bash
snakemake --dry-run --cores 10 --use-conda
```

To visualize the workflow structure via a directed acyclic graph (DAG):

```bash
snakemake --dag | dot -Tpng > docs/dag.png
```


#### Stage 1: Raw read quality assessment
To run FastQC and MultiQC on raw reads, then review the MultiQC report 
before proceeding to FASTQ trimming, "comment out" (add "#") Stages 2-3
in the Snakefile, "rules" section, & run Snakemake. Review `MultiQC/raw/multiqc_report.html` 
before continuing.

#### Stage 2: Trimming & trimmed read quality assessment
To proceed with trimming and a subsequent MultiQC report, "uncomment" Stage 2
in the Snakefile & run Snakemake. Review `MultiQC/trimmed/multiqc_report.html` before 
continuing.

#### Stage 3: Mapping to indexed reference genome, SAM=>BAM conversion, & read quantitation
To proceed with remaining steps, "uncomment" all of Stage 3 in the Snakefile & run
Snakemake.

# Adjusting parameters
By editing the .smk files for each package in the "rules" subdirectory, parameters can be 
individually adjusted as desired. TBD


# Other information

### Author

Matthew L. Fabian, Ph.D.


### References
