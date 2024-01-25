#paired end script

#first argument  path to fastq  reads 1
#second argument is path to fastq reads 2
#thrid argument  path to bowtie  genome (i.e. /home/genomefiles/human/bowtie2/mm9 )
#fourth argument is  prefix for output

#### some notes:
# this needs to be run in individual directories bc there are temp files made with generic names
# this  is for paired end sequencing
# this also does not remove intermediate files that will not be used for later analysis, I should create a cleaning script too


READ1=$1
READ2=$2
INDEX=$3
PREFIX=$4

sam=`echo $PREFIX .sam | sed 's/ //g'`
sam_filter=`echo $sam .filter.sam | sed 's/ //g'`
bam=`echo $sam .filter.sam.bam | sed 's/ //g'`
bam_sort=`echo $sam .filter.sam.bam.sorted.bam | sed 's/ //g'`
nodup=`echo $sam .filter.sam.bam.sorted.bam.nodup.bam | sed 's/ //g'`
bed=`echo $sam .bed | sed 's/ //g'`
#bedgraph=`echo $bed .bedgraph | sed 's/ //g'`
bw=`echo $PREFIX .bw | sed 's/ //g'`


bowtie2 -p 10 -x $INDEX -1 $READ1 -2 $READ2 -S $sam -q
samtools view -Sh $sam | grep -e "^@" -e "XM:i:[012][^0-9]" | grep -v "XS:i:" > $sam_filter
samtools view -S -b $sam_filter > $bam
samtools sort $bam -o $bam_sort
samtools rmdup -s $bam_sort $nodup
samtools index $nodup
bedtools bamtobed -i $nodup > $bed
bamCoverage --bam $nodup -o $bw



#old variables
#PREFIX=$1
#READ1=`echo $PREFIX .fastq | sed 's/ //g'`

#old bw argument where $3 is chromosome size file 
#bedtools genomecov -bg -i $bed -g $3 > $bedgraph
#bedGraphToBigWig $bedgraph $3 $bw

