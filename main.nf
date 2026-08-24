#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.samplesheet = "$baseDir/samplesheet.csv"
params.outdir = "$baseDir/results"
params.index = "$baseDir/reference/subread_index/grch38_index"
params.star_index = "$baseDir/reference/STAR_index"
params.gtf = "$baseDir/reference/star_reference/gencode.v50.primary_assembly.annotation.gtf"
params.star_executable = "STAR"

include {
    FASTQC
} from './modules/fastqc'

include {
    TRIM
} from './modules/trim'

include {
    FASTQC_TRIMMED
} from './modules/fastqc_trimmed'

include {
    ALIGN
} from './modules/align'

include {
    STAR_ALIGN
} from './modules/align_star'
include {
    FEATURECOUNTS
} from './modules/featurecounts'
workflow {
    samples_ch = channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->
            tuple(
                row.sample,
                row.condition,
                file(row.read1),
                file(row.read2)
            )
        }
    FASTQC(samples_ch)

    TRIM(samples_ch)

    FASTQC_TRIMMED(TRIM.out.reads)

    ALIGN(TRIM.out.reads)

    STAR_ALIGN(TRIM.out.reads)
FEATURECOUNTS(
    STAR_ALIGN.out.bam
        .map { _, _, bam -> bam }
        .collect()
)
}
