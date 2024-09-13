#!/usr/bin/env ruby

puts File.read("mco_head.ttl")

mm39 = {}
mm10 = {}

def parse_chrom(chromfile, sizefile, hash)
  File.open(chromfile).each do |line|
    next if line[/^#/]
    chr, assembly, ensembl, genbank, refseq = line.strip.split("\t")
    next if chr[/_/]  
    number = assembly[/(X|Y|MT)/] ? assembly : assembly.to_i
    hash[number] = {
      :chr => chr,
      :ensembl => ensembl,
      :genbank => genbank,
      :refseq => refseq
    }
  end

  File.open(sizefile).each do |line|
    next if line[/^#/]
    chr, len = line.strip.split("\t")
    next if chr[/_/]
    assembly = chr.sub(/^chr/, '').sub('M', 'MT')
    number = assembly[/(X|Y|M)/] ? assembly : assembly.to_i
    hash[number] ||= {}
    hash[number][:length] = len.to_i  
  end
end
  
parse_chrom("mm39.chromAlias.txt", "mm39.chrom.sizes", mm39)
parse_chrom("mm10.chromAlias.txt", "mm10.chrom.sizes", mm10)

[(1..19).to_a, "X", "Y", "MT"].flatten.each do |num|
  puts "mco:#{num}"
  puts "\trdf:type\towl:Class ;"
  puts "\trdfs:label\t\"Mouse chromosome 1\" ;"
  puts "\trdfs:subClassOf\tmco:MouseChromosome ."
  puts

  puts "<http://identifiers.org/mco/#{num}/GRCm39>"
  puts "\trdf:type\tmco:#{num} ;"
  puts "\tmco:build\tmco:GRCm39 ;"
  puts "\tmco:length\t#{mm39[num][:length]} ;"
  puts "\tmco:insdc\t<http://identifiers.org/insdc/#{mm39[num][:genbank]}> ;"
  puts "\tmco:refseq\t<http://identifiers.org/refseq/#{mm39[num][:refseq]}> ;"
  puts "\tmco:ucsc\t<http://genome.ucsc.edu/cgi-bin/hgTracks?db=mm39&position=#{mm39[num][:chr]}> ;"
  puts "\tmco:ensembl\t<http://rdf.ebi.ac.uk/resource/ensembl/mus_musculus/GRCm39/#{num}> ,"
  puts "\t\t<http://ensembl.org/Mus_musculus/Location/Chromosome?r=#{num}> ."
  puts

  puts "<http://identifiers.org/mco/#{num}/GRCm38>"
  puts "\trdf:type\tmco:#{num} ;"
  puts "\tmco:build\tmco:GRCm38 ;"
  puts "\tmco:length\t#{mm10[num][:length]} ;"
  puts "\tmco:insdc\t<http://identifiers.org/insdc/#{mm10[num][:genbank]}> ;"
  puts "\tmco:refseq\t<http://identifiers.org/refseq/#{mm10[num][:refseq]}> ;"
  puts "\tmco:ucsc\t<http://genome.ucsc.edu/cgi-bin/hgTracks?db=mm39&position=#{mm10[num][:chr]}> ;"
  puts "\tmco:ensembl\t<http://rdf.ebi.ac.uk/resource/ensembl/mus_musculus/GRCm38/#{num}> ,"
  puts "\t\t<http://nov2020.archive.ensembl.org/Mus_musculus/Location/Chromosome?r=#{num}> ."
end

