process FEATURECOUNTS {

    tag "featureCounts"

    cpus 8

    publishDir "${params.outdir}/featurecounts", mode: 'copy'

    input:
    path bam_files

    output:
    path "counts.txt", emit: counts
    path "counts.txt.summary", emit: summary

    script:
    """
    featureCounts \
        -T ${task.cpus} \
        -p \
        -t exon \
        -g gene_id \
        -a ${params.gtf} \
        -o counts.txt \
        ${bam_files.join(' ')}
    """
}
