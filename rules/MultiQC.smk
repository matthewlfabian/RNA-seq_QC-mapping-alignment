rule MultiQC_raw:
    input:
        expand("FastQC/raw/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/raw/{sample}_2_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/raw/multiqc_report.html"
    conda: "../envs/MultiQC.yaml"
    shell:
        "multiqc FastQC/raw/ -o MultiQC/raw/"

rule MultiQC_trimmed:
    input:
        expand("FastQC/trimmed/{sample}_1_fastqc.html", sample=SAMPLES),
        expand("FastQC/trimmed/{sample}_2_fastqc.html", sample=SAMPLES)
    output:
        "MultiQC/trimmed/multiqc_report.html"
    conda: "../envs/MultiQC.yaml"
    shell:
        "multiqc FastQC/trimmed/ -o MultiQC/trimmed/"
