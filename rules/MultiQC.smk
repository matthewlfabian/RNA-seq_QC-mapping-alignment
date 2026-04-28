rule MultiQC_raw:
    input:
        expand("FastQC/raw/{sample}_R1_001_fastqc.html", sample=SAMPLES),
        expand("FastQC/raw/{sample}_R2_001_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/raw/multiqc_report.html"
    conda: "../envs/MultiQC.yaml"
    shell:
        "multiqc FastQC/raw/ -o MultiQC/raw/"

rule MultiQC_trimmed:
    input:
        expand("FastQC/trimmed/{sample}_R1_001_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_R2_001_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/trimmed/multiqc_report.html"
    conda: "../envs/MultiQC.yaml"
    shell:
        "multiqc FastQC/trimmed/ -o MultiQC/trimmed/"
