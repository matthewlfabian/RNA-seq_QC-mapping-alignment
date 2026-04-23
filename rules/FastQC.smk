rule FastQC_raw:
    input:
        r1 = "FASTQ/raw/{sample}_R1_001.fastq.gz",
        r2 = "FASTQ/raw/{sample}_R2_001.fastq.gz"
    output:
        html1 = "FastQC/raw/{sample}_1_fastqc.html",
        html2 = "FastQC/raw/{sample}_2_fastqc.html"
    threads: 10
    conda: "../envs/FastQC.yaml"
    shell:
        "fastqc -t {threads} -o FastQC/raw/ {input.r1} {input.r2}"

rule FastQC_trimmed:
    input:
        r1 = "FASTQ/trimmed/{sample}_1.fastq.gz",
        r2 = "FASTQ/trimmed/{sample}_2.fastq.gz"
    output:
        html1 = "FastQC/trimmed/{sample}_1_fastqc.html",
        html2 = "FastQC/trimmed/{sample}_2_fastqc.html"
    threads: 10
    conda: "../envs/FastQC.yaml"
    shell:
        "fastqc -t {threads} -o FastQC/trimmed/ {input.r1} {input.r2}"
