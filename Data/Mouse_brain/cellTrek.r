options(stringsAsFactors = F)
library("CellTrek")
library("dplyr")
library("Seurat")
library("viridis")
library("ConsensusClusterPlus")

brain_st_cortex <- readRDS("/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Mouse_brain/brain_st_cortex.rds")
brain_sc <- readRDS("/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Mouse_brain/brain_sc.rds")

## Rename the cells/spots with syntactically valid names
brain_st_cortex <- RenameCells(brain_st_cortex, new.names=make.names(Cells(brain_st_cortex)))
brain_sc <- RenameCells(brain_sc, new.names=make.names(Cells(brain_sc)))


# Get the features and save as CSV file
features <- rownames(brain_sc@assays$RNA@counts)
write.csv(features, file = "/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Mouse_brain/features.csv", row.names = FALSE)

# Get the barcodes and save as CSV file
barcodes <- colnames(brain_sc@assays$RNA@counts)
write.csv(barcodes, file = "/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Mouse_brain/barcodes.csv", row.names = FALSE)

# Get the count matrix and save as CSV file
# counts <- GetAssayData(object = brain_sc, slot = "RNA")
write.csv(brain_sc$RNA@data, file = "/home/nuwaisir/Corridor/MSC/Term_2/Bioinformatics_algorithms/Project/Data/Mouse_brain/counts.csv", row.names = TRUE, sep=',')


## Visualize the ST data
SpatialDimPlot(brain_st_cortex)

brain_traint <- CellTrek::traint(st_data=brain_st_cortex, sc_data=brain_sc, sc_assay='RNA', cell_names='cell_type')

brain_celltrek <- CellTrek::celltrek(st_sc_int=brain_traint, int_assay='traint', sc_data=brain_sc, sc_assay = 'RNA', 
                                     reduction='pca', intp=T, intp_pnt=5000, intp_lin=F, nPCs=30, ntree=1000, 
                                     dist_thresh=0.55, top_spot=5, spot_n=5, repel_r=20, repel_iter=20, keep_model=T)$celltrek

brain_celltrek$cell_type <- factor(brain_celltrek$cell_type, levels=sort(unique(brain_celltrek$cell_type)))

CellTrek::celltrek_vis(brain_celltrek@meta.data %>% dplyr::select(coord_x, coord_y, cell_type:id_new),
                       brain_celltrek@images$anterior1@image, brain_celltrek@images$anterior1@scale.factors$lowres)

