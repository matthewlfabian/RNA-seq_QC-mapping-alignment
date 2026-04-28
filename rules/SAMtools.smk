rule samtools:
    input:
        sam = "HISAT2/{sample}.sam"
    output:
        bam     = "HISAT2/{sample}.bam",
        sorted  = "HISAT2/{sample}_sorted.bam",
        index   = "HISAT2/{sample}_sorted.bam.bai",
        flagstat = "logs/samtools/{sample}_flagstat.txt"
    threads: 8
    conda: "../envs/samtools.yaml"
    log:
        "logs/samtools/{sample}.log"
    shell:
        "samtools view -@ {threads} -bS {input.sam} -o {output.bam} 2>> {log} && "
        "samtools sort -@ {threads} {output.bam} -o {output.sorted} 2>> {log} && "
        "samtools index {output.sorted} 2>> {log} && "
        "samtools flagstat {output.sorted} > {output.flagstat} 2>> {log}"
