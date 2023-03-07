## 1) Test variability of nuclear genes in BOLD data

cd /media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun

mkdir Genes && cd Genes

## split genes in separate files
awk '/^>/ {split($0,a,"|"); gsub("\r", "", a[3]); file=a[3]".fasta"} { print > file }' /media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/bold_fasta.fas

echo '''

library(DECIPHER)
library(ape)
library(pegas)
library(PopGenome)
library(knitr)


filepath <- "/media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/Genes"

predict_files <- list.files(filepath, pattern=".fasta") 
ID=gsub(".fasta","",predict_files)

OUT=list("ID"=c(),"N"=c(),"Length"=c(),"NucDiv"=c(),"Theta"=c())

# Get vector of predict.txt files
predict_files <- list.files(filepath, pattern="predict.txt") 

# Get vector of full paths for predict.txt files
predict_full <- file.path(filepath, predict_files) 

for (i in ID){

    OUT[["ID"]]<-c(OUT[["ID"]],i)

    # Multiple alignment with DECIPHER
    fas1 <- paste0("/media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/Genes/",i,".fasta")
    seqs <- readDNAStringSet(fas1)
    seqs <- RemoveGaps(seqs, "all")
    seqs <- OrientNucleotides(seqs)
    aligned <- AlignSeqs(seqs)
    # BrowseSeqs(aligned, highlight=0)
    
    Length=length(myalign[[1]])
    OUT[["Length"]]<-c(OUT[["Length"]],Length)

    ## convert to ape/Pegas
    myalign <- as.DNAbin(aligned)
    base.freq(myalign)
    seg.sites(myalign)

    ## Nucleotide Diversity
    N<-round(nuc.div(myalign),3)
    OUT[["NucDiv"]]<-c(OUT[["NucDiv"]],N)

    ## Segregating Sites (Theta)
    s <- length(seg.sites(myalign))
    n <- length(myalign)
    T<-round(theta.s(s,n)/Length,3)
    OUT[["Theta"]]<-c(OUT[["Theta"]],T)
    OUT[["N"]]<-c(OUT[["N"]],n)
}

## Make table
sink("/media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/Genes.stats")
print(kable(as.data.frame(OUT)))
sink()
''' >/media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/Genes.r

Rscript /media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/Genes.r
