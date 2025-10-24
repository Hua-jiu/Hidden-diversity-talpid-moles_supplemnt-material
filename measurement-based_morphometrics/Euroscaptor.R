##PCA
library(dplyr)
library(ggplot2)
library(readxl)
library(Morpho)

euroscaptor <- read_excel("/hpcfile/home/xsn/Euroscaptor_PCA/euroscaptor_log10.xlsx")
data <- euroscaptor[, 2:16]
 species_names <- euroscaptor[[1]]
 pca_result <- prcomp(data, scale. = TRUE)
  pca_scores <- as.data.frame(pca_result$x)
  pca_scores <- as.data.frame(pca_result$x)
  pca_scores$species <- species_names
 palette <- c( "#A6CEE3FF", "#1F78B4FF", "#B2DF8AFF", "#33A02CFF", "#FB9A99FF", "#E31A1CFF", "#FDBF6FFF", "#FF7F00FF", "#CAB2D6FF")
  pca_hull_data <- pca_scores %>%
        group_by(species) %>%
        do(hull = .[chull(.$PC1, .$PC2), ])
  pca_hull_data <- bind_rows(pca_hull_data$hull)
  pca_plot <- ggplot(pca_scores, aes(x = PC1, y = PC2, color = species)) +
        geom_point(size = 3) +
        geom_polygon(data = pca_hull_data, aes(x = PC1, y = PC2, group = species, fill = species), alpha = 0.2, color = NA) +
        scale_color_manual(values = palette) +
        scale_fill_manual(values = palette) +
        theme_minimal() +
       labs(title = expression("PCA of 9 " * italic("Euroscaptor") * " species - craniomandibular variables"),
                        x = "Principal Component 1",
                        y = "Principal Component 2")
 pca_plot <- pca_plot + theme(
    plot.title = element_text(size = 22, hjust = 0.5),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16),
    axis.text = element_text(size = 13),
    legend.text = element_text(size = 17)
  )
  print(pca_plot)
ggsave("PCA_euroscaptor.pdf", plot = pca_plot, width = 12, height = 8)

##CVA

  euroscaptor <- read_excel("/hpcfile/home/xsn/Euroscaptor_PCA/euroscaptor_log10.xlsx")
   data <- euroscaptor[, 2:16]
   species_names <- euroscaptor[[1]]
   cva_result <- CVA(data, group = species_names)
   cva_scores <- as.data.frame(cva_result$CVscores) 
   cva_scores$species <- species_names
   df <- data.frame(CV1 = cva_scores[, 1], CV2 = cva_scores[, 2], species = cva_scores$species)
   palette <- c( "#A6CEE3FF", "#1F78B4FF", "#B2DF8AFF", "#33A02CFF", "#FB9A99FF", "#E31A1CFF", "#FDBF6FFF", "#FF7F00FF", "#CAB2D6FF")
   hull_data <- df %>%
         group_by(species) %>%
         do(hull = .[chull(.$CV1, .$CV2), ])
   
     # 将凸包数据转换为可绘制的格式
     hull_data <- bind_rows(hull_data$hull)
   
     # 绘制CVA图，并添加凸包
     cva_plot <- ggplot(df, aes(x = CV1, y = CV2, color = species)) +
         geom_point(size = 3) +
         geom_polygon(data = hull_data, aes(x = CV1, y = CV2, group = species, fill = species), 
                                         alpha = 0.2, color = NA) +
         scale_color_manual(values = palette) +
         scale_fill_manual(values = palette) +
         theme_minimal() +
         labs(title = expression("CVA of 9 " * italic("Euroscaptor") * " species - craniomandibular variables"),
                         x = "Canonical Variate 1",
                         y = "Canonical Variate 2")
   cva_plot <- cva_plot + theme(
     plot.title = element_text(size = 22, hjust = 0.5),
     axis.title.x = element_text(size = 16),
     axis.title.y = element_text(size = 16),
     axis.text = element_text(size = 13),
     legend.text = element_text(size = 17)
   )
     # 输出绘图结果
     print(cva_plot)
 ggsave("CVA_euroscaptor.pdf", plot = cva_plot, width = 12, height = 8)

