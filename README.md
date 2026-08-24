# RNA-seq Nextflow pipeline

This DSL2 Nextflow pipeline performs paired-end RNA-seq quality control, adapter and quality trimming, STAR and Subread alignment, and gene-level quantification with featureCounts.

## Requirements

- Nextflow
- FastQC
- fastp
- STAR
- Subread (`featureCounts`)

The reference genome, annotation, and aligner indexes are intentionally not stored in this repository. Create them locally and pass their paths with the parameters below.

## Input

Copy `samplesheet.csv` and update the `read1` and `read2` paths. The CSV must contain:

```text
sample,condition,read1,read2
```

Reads are expected to be paired-end FASTQ files.

## Run

```bash
nextflow run main.nf \
  --samplesheet samplesheet.csv \
  --star_index /path/to/STAR_index \
  --index /path/to/subread_index_prefix \
  --gtf /path/to/annotation.gtf \
  --outdir results
```

Use `--star_executable /path/to/STAR` when STAR is not on `PATH`.

Outputs are written under `results/`, including trimmed reads, FastQC reports, aligned BAM files, and featureCounts tables. Runtime files and outputs are ignored by Git.
