rule HISAT2_index:
    input:
        fasta = config["ref_assembly"],
        gtf   = config["ref_annotations"]
    output:
        splice_sites = "reference/splice_sites.tsv",
        exons        = "reference/exons.tsv",
        index        = expand("reference/index/genome.{n}.ht2", n=range(1, 9))
    threads: 8
    resources:
        mem_mb = 100000,      # 100GB — adjust for your genome size
        runtime = 480
    conda: "../envs/HISAT2.yaml"
    log:
        "logs/HISAT2_index.log"
    shell:
        "hisat2_extract_splice_sites.py {input.gtf} > {output.splice_sites} 2>> {log} && "
        "hisat2_extract_exons.py {input.gtf} > {output.exons} 2>> {log} && "
        "hisat2-build -p {threads} "
        "--ss {output.splice_sites} "
        "--exon {output.exons} "
        "{input.fasta} reference/index/genome "
        ">> {log} 2>&1"

rule hisat2_align:
    input:
        r1    = "FASTQ/trimmed/{sample}_R1_001_val_1.fq.gz",
        r2    = "FASTQ/trimmed/{sample}_R2_001_val_2.fq.gz",
        index = expand("reference/index/genome.{n}.ht2", n=range(1, 9))
    output:
        sam = temp("HISAT2/{sample}.sam")    # temp — deleted after SAMtools finishes
    threads: 8
    resources:
        mem_mb = 32000,
        runtime = "04:00:00"
    conda: "../envs/HISAT2.yaml"
    log:
        "logs/hisat2_align/{sample}.log"
    shell:
        "hisat2 -p {threads} "
        "-x reference/index/genome "
        "--dta "
        "-1 {input.r1} "
        "-2 {input.r2} "
        "-S {output.sam} "
        "> {log} 2>&1"
