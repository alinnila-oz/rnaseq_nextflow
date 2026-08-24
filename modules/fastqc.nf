process FASTQC {

    tag "$sample"

    cpus 8

    publishDir "${params.outdir}/fastqc", mode: 'copy'

    input:
    tuple val(sample), val(condition), path(read1), path(read2)

    output:
    tuple val(sample), val(condition), path("*_fastqc.html"), path("*_fastqc.zip")

    script:
    """
    fastqc \
        ${read1} \
        ${read2} \
        -t ${task.cpus}
    """
}
