# Paired-End Sequencing Analysis Script

This script is designed for analyzing paired-end sequencing data using Bowtie2 for alignment and generating several downstream outputs such as SAM, BAM, BED, and BigWig files. It also includes some notes on its usage and certain considerations.

## Usage

1. Ensure you have the necessary dependencies installed, including `bowtie2`, `samtools`, `bedtools`, `bamCoverage` (from deepTools), and other relevant tools.
2. Save the script content to a file, e.g., `paired_og.sh`.
3. Make the script executable:
   ```bash
   chmod +x paired_og.sh
   ```
4. Run the script with the required arguments:
   ```bash
   ./paired_og.sh <path_to_read1.fastq> <path_to_read2.fastq> <path_to_bowtie2_index> <output_prefix>
   ```

## Arguments

1. `<path_to_read1.fastq>`: Path to the fastq file containing the first set of paired-end reads.
2. `<path_to_read2.fastq>`: Path to the fastq file containing the second set of paired-end reads.
3. `<path_to_bowtie2_index>`: Path to the Bowtie2 index of the reference genome.
4. `<output_prefix>`: Prefix for the output files.

## Outputs

The script generates the following output files in the working directory:

- `<output_prefix>.sam`: SAM file containing the alignment results.
- `<output_prefix>.filter.sam`: SAM file filtered to exclude unwanted entries.
- `<output_prefix>.filter.sam.bam`: BAM file generated from the filtered SAM file.
- `<output_prefix>.filter.sam.bam.sorted.bam`: Sorted BAM file.
- `<output_prefix>.filter.sam.bam.sorted.bam.nodup.bam`: BAM file with duplicate reads removed.
- `<output_prefix>.bed`: BED file converted from the BAM file.
- `<output_prefix>.bw`: BigWig file generated from the BAM file using `bamCoverage` from deepTools.

## Notes

- Run this script in individual directories as it creates temporary files with generic names.
- The script is specifically designed for paired-end sequencing.
- Intermediate files that are not used for later analysis are not removed. Consider creating a cleaning script for this purpose.
- Ensure that all required tools are installed and accessible in the system's PATH.

