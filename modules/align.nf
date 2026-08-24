process ALIGN {

    tag "$sample"

    cpus 8

    publishDir "${params.outdir}/aligned", mode: 'copy'

    input:
    tuple val(sample), val(condition), path(read1), path(read2)

    output:
    tuple val(sample), val(condition), path("${sample}.bam"), emit: bam

    script:
    """
    subread-align \
        -t 0 \
        -T ${task.cpus} \
        -i ${params.index} \
        -r ${read1} \
        -R ${read2} \
        -o ${sample}

    mv ${sample} ${sample}.bam
    """
}
