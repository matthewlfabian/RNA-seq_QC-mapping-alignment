# --illumina: trim Illumina adapter sequences
# --clip_R1 15 --clip_R2 15: trim the 1st 15 bp from the left & right borders of each read

rule Trim_Galore:
    input:
        r1 = "FASTQ/raw/{sample}_1.fastq.gz",
        r2 = "FASTQ/raw/{sample}_2.fastq.gz"
    output:
        r1 = "FASTQ/trimmed/{sample}_1.fastq.gz",
        r2 = "FASTQ/trimmed/{sample}_2.fastq.gz"
    conda: "../envs/BBDuk.yaml"
    shell:
        "bbduk.sh in1={input.r1} in2={input.r2} "
        "out1={output.r1} out2={output.r2} "
        "qtrim=r trimq=15 ftm=5 minlength=100 ftl=10 trimpolygright=5"
