process STAR_ALIGN {

    tag "$sample"

    cpus 8

    publishDir "${params.outdir}/star_aligned", mode: 'copy'

    input:
    tuple val(sample), val(condition), path(read1), path(read2)

    output:
    tuple val(sample), val(condition), path("${sample}.bam"), emit: bam

    script:
    """
    ${params.star_executable} \
        --runThreadN ${task.cpus} \
        --genomeDir ${params.star_index} \
        --readFilesIn ${read1} ${read2} \
        --outFileNamePrefix ${sample}_ \
        --outSAMtype BAM SortedByCoordinate

    mv ${sample}_Aligned.sortedByCoord.out.bam ${sample}.bam
    """
}
