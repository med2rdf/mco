# Mouse Chromosome Ontology

The Mouse Chromosome Ontology (MCO) provides simple and stable URIs for mouse reference genome versions to semantically identify mouse chromosomes.

Basic class `mco:MouseChromosome` is inherited by each chromosome class such as `mco:2` and `mco:GenomeBuild` is inherited by each build version such as `mco:GRCm39`. Then, for example, the mouse chromosome 2 of the GRCm39 version is represented as `mco:2\/GRCm39` (<http://identifiers.org/mco/2/GRCm39>) which is defined as an instance of `mco:2` with build version `mco:GRCm39`. Each instance of a chromosome has links to external resources such as INSDC, RefSeq, UCSC etc. so that users can be navigated to the chromosome sequence and its annotations.

```
mco:2
        rdfs:label      "Mouse chromosome 2" ;
        rdfs:subClassOf mco:MouseChromosome .

mco:2\/GRCm39
        rdf:type        mco:2 ;
        mco:build       mco:GRCm39 ;
        mco:length      46709983 ;
        skos:altLabel   "GPC_000001313" ;
        mco:insdc       <http://identifiers.org/insdc/CM000995.3> ;
        mco:refseq      <http://identifiers.org/refseq/NC_000068.8> ;
        mco:ucsc        <http://genome.ucsc.edu/cgi-bin/hgTracks?db=mm39&position=chr2> ;
        mco:ensembl     <http://rdf.ebi.ac.uk/resource/ensembl/mus_musculus/GRCm39/2> ,
                        <http://www.ensembl.org/Mus_musculus/Location/Chromosome?r=2> .
```

### Contributors

* Toshiaki Katayama (Database Center for Life Science)
* Toyoyuki Takada (RIKEN BioResource Research Center)
* The Med2RDF project <http://med2rdf.org/>
* VISC <https://github.com/dbcls/visc/>

