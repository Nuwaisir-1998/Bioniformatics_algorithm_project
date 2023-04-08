library(HoneyBADGER)
data(gexp) ## tumor cells
data(ref) ## reference

require(biomaRt) ## for gene coordinates
#mart.obj <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = 'hsapiens_gene_ensembl', host = "jul2015.archive.ensembl.org") ## version used in manuscript
mart.obj <- useMart(biomart = "ENSEMBL_MART_ENSEMBL", dataset = 'hsapiens_gene_ensembl') ## current version 20210603- default version hg38

mart.obj <- useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", dataset="hsapiens_gene_ensembl") # specify the version hg19

print(gexp[1:5,1:5])
