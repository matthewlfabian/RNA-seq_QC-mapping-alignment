# Steps: FastQC & report => trimming via Trim Galore => FastQC & report => HISAT2 indexing

configfile: "config/config.yaml"

SAMPLES = config["samples"]

include: "rules/FastQC.smk"
include: "rules/MultiQC.smk"
include: "rules/BBDuk.smk"
include: "rules/SPAdes.smk"
include: "rules/QUAST.smk"
include: "rules/Prokka.smk"

rule all:
    input:
    # Stage 1: raw FASTQ QC assessment; comment out when complete
        #expand("FastQC/raw/{sample}_1_fastqc.html", sample=SAMPLES),
        #expand("FastQC/raw/{sample}_2_fastqc.html", sample=SAMPLES),
        #"MultiQC/raw/multiqc_report.html"
    # Stage 2: trimming and trimmed FASTQ QC assessment; uncomment to continue
        expand(config["outdir"] + "/{sample}_1.fastq.gz", sample=SAMPLES),
        expand(config["outdir"] + "/{sample}_2.fastq.gz", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_2_fastqc.html", sample=SAMPLES),
        "MultiQC/trimmed/multiqc_report.html",
    # Stage 3: assembly & QC assessment; uncomment to continue
        expand("SPAdes/{sample}/scaffolds.fasta", sample=SAMPLES),
        expand("QUAST/{sample}/report.html", sample=SAMPLES),
    # Stage 4: annotation; uncomment to continue
        expand("Prokka/{sample}/{sample}.gff", sample=SAMPLES),
        expand("Prokka/{sample}/{sample}.faa", sample=SAMPLES),
        expand("Prokka/{sample}/{sample}.gbk", sample=SAMPLES),
