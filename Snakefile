configfile: "config/config.yaml"

SAMPLES = config["samples"]

include: "rules/FastQC.smk"
include: "rules/MultiQC.smk"
include: "rules/Trim_Galore.smk"
include: "rules/HISAT2.smk"
include: "rules/SAMtools.smk"

rule all:
    input:
    # Stage 1 - FASTQ QC assessment
        expand("FastQC/raw/{sample}_R1_001_fastqc.html", sample=SAMPLES),
        expand("FastQC/raw/{sample}_R2_001_fastqc.html", sample=SAMPLES),
        "MultiQC/raw/multiqc_report.html",
    # Stage 2 - Trim_Galore trimming and trimmed FASTQ QC assessment
        expand(config["outdir"] + "/{sample}_R1_001_val_1.fq.gz", sample=SAMPLES),
        expand(config["outdir"] + "/{sample}_R2_001_val_2.fq.gz", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_R1_001_val_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_R2_001_val_2_fastqc.html", sample=SAMPLES),
        "MultiQC/trimmed/multiqc_report.html",
    # Stage 3 - HISAT2 indexing/mapping, SAM=>BAM, & read quantitation
        expand("reference/index/genome.{n}.ht2", n=range(1, 9)),
        "reference/splice_sites.tsv",
        "reference/exons.tsv",
        expand("HISAT2/{sample}.sam", sample=SAMPLES),
        expand("HISAT2/{sample}_sorted.bam", sample=SAMPLES),
        expand("HISAT2/{sample}_sorted.bam.bai", sample=SAMPLES),
        expand("logs/SAMtools/{sample}_flagstat.txt", sample=SAMPLES),
