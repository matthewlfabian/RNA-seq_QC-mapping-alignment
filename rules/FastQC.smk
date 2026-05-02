rule FastQC_raw:
    input:
        r1 = "FASTQ/raw/{sample}_R1_001.fastq.gz",
        r2 = "FASTQ/raw/{sample}_R2_001.fastq.gz"
    output:
        html1 = "FastQC/raw/{sample}_R1_001_fastqc.html",
        html2 = "FastQC/raw/{sample}_R2_001_fastqc.html",
        zip1  = "FastQC/raw/{sample}_R1_001_fastqc.zip",
        zip2  = "FastQC/raw/{sample}_R2_001_fastqc.zip"
    threads: 2
    resources:
        mem_mb = 4000,
        runtime = "01:00:00"
    conda: "../envs/FastQC.yaml"
    log:
        "logs/FastQC/raw/{sample}.log"    
    shell:
        "fastqc -t {threads} -o FastQC/raw/ {input.r1} {input.r2}"

rule FastQC_trimmed:
    input:
        r1 = "FASTQ/trimmed/{sample}_R1_001_val_1.fq.gz",
        r2 = "FASTQ/trimmed/{sample}_R2_001_val_2.fq.gz"
    output:
        html1 = "FastQC/trimmed/{sample}_R1_001_val_1_fastqc.html",
        html2 = "FastQC/trimmed/{sample}_R2_001_val_2_fastqc.html",
        zip1  = "FastQC/trimmed/{sample}_R1_001_val_1_fastqc.zip",
        zip2  = "FastQC/trimmed/{sample}_R2_001_val_2_fastqc.zip"
    threads: 2
    resources:
        mem_mb = 4000,
        runtime = "01:00:00"
    conda: "../envs/FastQC.yaml"
    log:
        "logs/FastQC/trimmed/{sample}.log"
    shell:
        "fastqc -t {threads} -o FastQC/trimmed/ {input.r1} {input.r2}"
