# Preliminary analyses for the TETTRIS barcoding project

## 1) Genomic information
As a first step, I checked NCBI for available Genomic resources for pollinator groups that might become our focus taxonomic groups:

-   _Syrphidae_ (hoverflies): [COX1](https://www.ncbi.nlm.nih.gov/nuccore/?term=txid34680%5BOrganism%5D+and+COX1); [Genomes](https://www.ncbi.nlm.nih.gov/data-hub/genome/?taxon=34680)
-   _Apoidea_ (wild bees): [COX1](https://www.ncbi.nlm.nih.gov/nuccore/?term=txid34735%5BOrganism%5D+and+COX1+and+not+Apis%5Borganism%5D); [Genomes](https://www.ncbi.nlm.nih.gov/data-hub/genome/?taxon=34735)

The current (21/09/2022) genome lists (also as Excel file) and unprocessed COX-1 FASTA files can be found in the [data](data) folder


## 2) Summary of nuclear gene data available @ BOLD

Here, I used Luise's multifasta dataset and split it by Gene names in multiple files using awk

```bash

awk '/^>/ {split($0,a,"|"); gsub("\r", "", a[3]); file=a[3]".fasta"} { print > file }' /media/inter/mkapun/projects/TETTRIS_barcoding/data/BOLD_TestRun/bold_fasta.fas
```
For each of these multifasta datasets, I then performed multiple alignment in _R_ using the _DECIPHER_ package and calculated _Nucleotide Diversity_ and _Theta S_ (Segregating Sites) using the _APE_ package. The corresponding script can be found [here](shell/main.sh)

See the results below:


| ID     |    N | Length |    NucDiv |      Theta |
| :----- | ---: | -----: | --------: | ---------: |
| 18S    |    6 |    530 | 0.0109391 |   7.445256 |
| 28S    |   20 |    685 | 0.0345909 | 124.022629 |
| AATS   |   20 |   1325 | 0.1034826 |  56.092053 |
| CAD    |   10 |    558 | 0.1711985 | 259.105064 |
| CK1    |   19 |   1893 | 0.0586454 |  43.775470 |
| COI-3P |   20 |    633 | 0.1100472 |  71.876751 |
| COI-5P |   20 |    828 | 0.1044795 |  59.474488 |
| PER    |   17 |    648 | 0.1479957 |  72.469577 |
| RBM15  |   20 |    572 | 0.1243333 | 123.177020 |
| TULP   |   17 |   1201 | 0.0889489 |  48.510247 |
