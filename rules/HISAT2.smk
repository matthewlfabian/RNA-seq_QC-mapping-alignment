rule HISAT2_index:
    input:
        fasta = config["ref_assembly"],
        gtf   = config["ref_annotations"]
    output:
        splice_sites = "reference/splice_sites.tsv",
        exons        = "reference/exons.tsv",
        index        = expand("reference/index/genome.{n}.ht2", n=range(1, 9))
    threads: 8
    conda: "../envs/HISAT2.yaml"
    log:
        "logs/HISAT2_index.log"
    shell:
        "hisat2_extract_splice_sites.py {input.gtf} > {output.splice_sites} && "
        "hisat2_extract_exons.py {input.gtf} > {output.exons} && "
        "hisat2-build -p {threads} "
        "--ss {output.splice_sites} "
        "--exon {output.exons} "
        "{input.fasta} reference/index/genome "
        "> {log} 2>&1"
