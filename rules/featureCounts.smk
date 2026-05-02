rule featureCounts:
    input:
        bams = expand("HISAT2/{sample}_sorted.bam", sample=SAMPLES),
        gtf  = config["ref_annotations"]
    output:
        counts = "featureCounts/counts.txt",
        summary = "featureCounts/counts.txt.summary"
    threads: 8
    conda: "../envs/featureCounts.yaml"
    log:
        "logs/featureCounts.log"
    shell:
        "featureCounts "
        "-T {threads} "
        "-p --countReadPairs "
        "-t exon "
        "-g gene_id "
        "-a {input.gtf} "
        "-o {output.counts} "
        "{input.bams} "
        "> {log} 2>&1"
