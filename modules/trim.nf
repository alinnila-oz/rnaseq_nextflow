process TRIM {

    tag "$sample"

    cpus 8

    publishDir "${params.outdir}/trimmed", mode: 'copy'

    input:
    tuple val(sample), val(condition), path(read1), path(read2)

    output:
    tuple val(sample), val(condition), path("*_1_trimmed.fastq"), path("*_2_trimmed.fastq"), emit: reads
    path "*_fastp.html"
    path "*_fastp.json"

    script:
    """
    fastp \
        -i ${read1} \
        -I ${read2} \
        -o ${sample}_1_trimmed.fastq \
        -O ${sample}_2_trimmed.fastq \
        --length_required 36 \
        -h ${sample}_fastp.html \
        -j ${sample}_fastp.json \
        -w ${task.cpus}
    """

}
