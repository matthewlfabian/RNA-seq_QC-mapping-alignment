rule rMATS:
    input:
        bams  = expand("HISAT2/{sample}_sorted.bam", sample=SAMPLES),
        index = expand("HISAT2/{sample}_sorted.bam.bai", sample=SAMPLES),
        gtf   = config["ref_annotations"]
    output:
        directory("rMATS/output")
    params:
        b1          = ",".join(expand("HISAT2/{sample}_sorted.bam",
                        sample=config["conditions"]["control"])),
        b2          = ",".join(expand("HISAT2/{sample}_sorted.bam",
                        sample=config["conditions"]["test"])),
        read_length = config["read_length"]
    threads: 8
    resources:
        mem_mb  = 64000,
        runtime = 480
    conda: "../envs/rMATS.yaml"
    log:
        "logs/rMATS.log"
    shell:
        "mkdir -p rMATS/output rMATS/tmp && "
        "echo '{params.b1}' > rMATS/b1.txt && "
        "echo '{params.b2}' > rMATS/b2.txt && "
        "rmats.py "
        "--b1 rMATS/b1.txt "
        "--b2 rMATS/b2.txt "
        "--gtf {input.gtf} "
        "--od rMATS/output/ "
        "--tmp rMATS/tmp/ "
        "-t paired "
        "--readLength {params.read_length} "
        "--nthread {threads} "
        "> {log} 2>&1"
