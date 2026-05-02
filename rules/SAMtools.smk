rule samtools:
    input:
        sam = "HISAT2/{sample}.sam"
    output:
        bam     = "HISAT2/{sample}.bam",
        sorted  = "HISAT2/{sample}_sorted.bam",
        index   = "HISAT2/{sample}_sorted.bam.bai",
        flagstat = "logs/SAMtools/{sample}_flagstat.txt"
    threads: 8
    conda: "../envs/SAMtools.yaml"
    log:
        "logs/SAMtools/{sample}.log"
    shell:
        "samtools view -@ {threads} -bS {input.sam} 2>> {log} | "
        "samtools sort -@ {threads} -o {output.sorted} 2>> {log} && "
        "samtools index {output.sorted} 2>> {log} && "
        "samtools flagstat {output.sorted} > {output.flagstat} 2>> {log}"
