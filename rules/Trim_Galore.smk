# --illumina: trim Illumina adapter sequences
# --clip_R1 15 --clip_R2 15: trim the 1st 15 bp from the left & right borders of each read
rule Trim_Galore:
    input:
        r1 = "FASTQ/raw/{sample}_R1_001.fastq.gz",
        r2 = "FASTQ/raw/{sample}_R2_001.fastq.gz"
    output:
        r1 = "FASTQ/trimmed/{sample}_R1_001_val_1.fq.gz",
        r2 = "FASTQ/trimmed/{sample}_R2_001_val_2.fq.gz"
    threads: 4
    resources:
        mem_mb = 16000,
        runtime = "02:00:00"
    conda: "../envs/Trim_Galore.yaml"
    log:
        "logs/Trim_Galore/{sample}.log"
    shell:
        "trim_galore --illumina --paired --clip_R1 15 --clip_R2 15 "
        "--cores {threads} "
        "-o FASTQ/trimmed/ "
        "{input.r1} {input.r2} "
        "> {log} 2>&1"
