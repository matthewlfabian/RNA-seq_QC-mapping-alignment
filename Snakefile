configfile: "config/config.yaml"

SAMPLES = config["samples"]

include: "rules/FastQC.smk"
include: "rules/MultiQC.smk"
include: "rules/Trim_Galore.smk"
include: "rules/HISAT2.smk"

rule all:
    input:
    # FASTQ QC assessment
        expand("FastQC/raw/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/raw/{sample}_2_fastqc.html", sample=SAMPLES),
        "MultiQC/raw/multiqc_report.html",
    # Trim_Galore trimming and trimmed FASTQ QC assessment
        expand(config["outdir"] + "/{sample}_R1_001_val_1.fq.gz", sample=SAMPLES),
        expand(config["outdir"] + "/{sample}_R2_001_val_1.fq.gz", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_2_fastqc.html", sample=SAMPLES),
        "MultiQC/trimmed/multiqc_report.html",
    # HISAT2 indexing
        expand("reference/index/genome.{n}.ht2", n=range(1, 9)),
        "reference/splice_sites.tsv",
        "reference/exons.tsv",
    # HISAT2 mapping
        expand("HISAT2/{sample}.sam", sample=SAMPLES),
