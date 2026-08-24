library(GenomicFeatures)
library(rtracklayer)
library(GenomicRanges)
library(edgeR)
library(ggplot2)
library(dplyr)
library(pheatmap)
library(ggrepel)

args <- commandArgs(trailingOnly = TRUE)
results_dir <- if (length(args) > 0) args[[1]] else "results"
counts_file <- file.path(results_dir, "featurecounts", "counts.txt")

fc <- read.delim(
  counts_file,
  comment.char = "#",
  check.names = FALSE
)

head(fc)
dim(fc)
colnames(fc)

count_matrix <- fc[, c(
  "SRR25276746.bam",
  "SRR25276747.bam",
  "SRR25276748.bam",
  "SRR25276749.bam"
)]

rownames(count_matrix) <- fc$Geneid

colnames(count_matrix) <- c(
  "SRR25276746",
  "SRR25276747",
  "SRR25276748",
  "SRR25276749"
)

count_matrix <- as.matrix(count_matrix)

dim(count_matrix)
head(count_matrix)

groups <- c(
  "Ssh1",
  "Ssh1",
  "SC",
  "SC"
)

metadata <- data.frame(
  sample_id = colnames(count_matrix),
  condition = factor(
    groups,
    levels = c("SC", "Ssh1")
  ),
  stringsAsFactors = FALSE
)

metadata

identical(
  colnames(count_matrix),
  metadata$sample_id
)

write.csv(
  count_matrix,
  file.path(results_dir, "count_matrix.csv")
)
