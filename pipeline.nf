params.file='e_coli_seq.fastq'
dict='e_coli_genome.fna'

process analyzeAndAlign {
  input:
    path in_folder
  output:
    path 'bio_project/outputs/output.txt'

  """
  fastqc -o ${in_folder}/outputs/fastqc ${in_folder}/*.fastq;
  bwa mem ${in_folder}/${dict} ${in_folder}/${params.file} > ${in_folder}/outputs/output.sam
  samtools view -bo ${in_folder}/outputs/output.bam ${in_folder}/outputs/output.sam;
  samtools flagstat ${in_folder}/outputs/output.bam > ${in_folder}/outputs/output.txt
  """
}

process parse {
  input:
    path input
  output:
    stdout

  """
  echo $input
  percent=\$(grep -oP '[\\.\\d]+(?=%)' ${input})
  echo -n \$percent
  """
}

process processAndDisplay {
  input:
    val percent
    path in_folder
  output:
    stdout
  
  """
  if (( \$(echo "$percent >= 70.0" |bc -l) )); then
	echo OK
	samtools sort ${in_folder}/outputs/output.bam -o ${in_folder}/outputs/output.sorted.bam
	freebayes -f ${in_folder}/$dict ${in_folder}/outputs/output.sorted.bam > ${in_folder}/outputs/result.vcf
  else
	echo Not OK
  fi
  """
}

workflow {
  def inp = Channel.fromPath('/home/synchro/bio_project')
  res = analyzeAndAlign(inp) | parse 
  processAndDisplay(res,inp) | view{it.trim()}
}
