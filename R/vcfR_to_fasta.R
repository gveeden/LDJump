vcfR_to_fasta = function(seqName, refName = NULL, ext.ind = T, cons = F, ext.haps = T, cores = cores, SNP_ID_default = SNP_ID_default, start = NULL) {
  input = vcfR::read.vcfR(file = paste(seqName, ".vcf", sep=""), limit = 1e+07, nrows = -1, skip = 0, cols = NULL, convertNA = F, verbose = T)
  pop = vcfR::addID(input, sep="_", ID_default=SNP_ID_default)
  ref = ape::read.dna(file = refName, format = "fasta")
  pop.dnabin = vcfR::vcfR2DNAbin(pop, extract.indels = ext.ind, consensus = cons, extract.haps = ext.haps, ref.seq = ref, start.pos = start, cores = cores, verbose = TRUE)
  ### with consensus = T we have 1 sequence per individual ####
  ape::write.FASTA(x = pop.dnabin, file = paste0(seqName, ".fa", sep = ""))
  print(paste(seqName, "converted to fasta file: ", seqName, ".fa", sep = ""))
}
