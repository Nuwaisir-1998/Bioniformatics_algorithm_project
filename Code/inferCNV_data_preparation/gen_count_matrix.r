library(Matrix)
matrix_dir = "/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Lung_adenocarcinoma/SC/GSM5699777/"
barcode.path <- paste0(matrix_dir, "GSM5699777_TD1_barcodes.tsv.gz")
features.path <- paste0(matrix_dir, "GSM5699777_TD1_features.tsv.gz")
matrix.path <- paste0(matrix_dir, "GSM5699777_TD1_matrix.mtx.gz")
mat <- readMM(file = matrix.path)
feature.names = read.delim(features.path,
                           header = FALSE,
                           stringsAsFactors = FALSE)
barcode.names = read.delim(barcode.path,
                           header = FALSE,
                           stringsAsFactors = FALSE)
colnames(mat) = barcode.names$V1
rownames(mat) = feature.names$V1

# mat.data<-as.matrix(mat.data)
write.csv2(mat, "/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Lung_adenocarcinoma/SC/GSM5699777/mat_data.csv")
