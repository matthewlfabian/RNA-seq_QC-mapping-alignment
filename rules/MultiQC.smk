rule MultiQC_raw:
    input:
        expand("FastQC/raw/{sample}_R1_001_fastqc.html", sample=SAMPLES),
        expand("FastQC/raw/{sample}_R2_001_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/raw/multiqc_report.html"
    resources:
        mem_mb = 4000,
        runtime = "00:30:00"
    conda: "../envs/MultiQC.yaml"
    log:
        "logs/MultiQC/raw.log"
    shell:
        "multiqc FastQC/raw/ -o MultiQC/raw/ > {log} 2>&1"

rule MultiQC_trimmed:
    input:
        expand("FastQC/trimmed/{sample}_R1_001_val_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_R2_001_val_2_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/trimmed/multiqc_report.html"
    resources:
        mem_mb = 4000,
        runtime = "00:30:00"
    conda: "../envs/MultiQC.yaml"
    log:
        "logs/MultiQC/trimmed.log"
    shell:
        "multiqc FastQC/trimmed/ -o MultiQC/trimmed/ > {log} 2>&1"
