# ==============================================================================
# Morphometric Analysis for Parascaptor
# ==============================================================================
# This script performs Principal Component Analysis (PCA) and Canonical Variate
# Analysis (CVA) on craniomandibular morphometric data for Parascaptor species.
# ==============================================================================

# Load required libraries
library(dplyr) # Data manipulation
library(ggplot2) # Data visualization
library(readxl) # Reading Excel files
library(Morpho) # Morphometric analysis tools
library(MASS) # For Linear Discriminant Analysis (lda)
library(tidyr) # For data tidying (unnest function)

# ==============================================================================
# PRINCIPAL COMPONENT ANALYSIS (PCA)
# ==============================================================================

# Set work folder
setwd("./Hidden-diversity-talpid-moles_supplemnt-material/measurement-based_morphometrics")

# Read the morphometric data from Excel file (log10 transformed data)
parascaptor <- read_excel("./para_log10.xlsx")

# Extract morphometric variables (columns 2-16)
data <- parascaptor[, 2:16]

# Extract species names (first column)
species_names <- parascaptor[[1]]

# Perform PCA with scaling (standardization)
pca_result <- prcomp(data, scale. = TRUE)

# Extract PCA scores and add species information
pca_scores <- as.data.frame(pca_result$x)
pca_scores$species <- species_names

# Define color palette for species visualization
palette <- c("#636EFA", "#EF553B", "#00CC96")

# Calculate convex hull for each species group
pca_hull_data <- pca_scores %>%
  group_by(species) %>%
  do(hull = .[chull(.$PC1, .$PC2), ])

# Combine hull data into a single data frame
pca_hull_data <- bind_rows(pca_hull_data$hull)

# Create PCA plot with convex hulls
pca_plot <- ggplot(pca_scores, aes(x = PC1, y = PC2, color = species)) +
  geom_point(size = 3) +
  geom_polygon(
    data = pca_hull_data,
    aes(x = PC1, y = PC2, group = species, fill = species),
    alpha = 0.2, color = NA
  ) +
  scale_color_manual(values = palette) +
  scale_fill_manual(values = palette) +
  theme_minimal() +
  labs(
    title = expression("PCA of " * italic("Parascaptor") * " species - craniomandibular variables"),
    x = "Principal Component 1",
    y = "Principal Component 2"
  ) +
  theme(
    plot.title = element_text(size = 22, hjust = 0.5),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16),
    axis.text = element_text(size = 13),
    legend.text = element_text(size = 17)
  )

# Display the PCA plot
print(pca_plot)

# Save PCA plot as PDF file
ggsave("./PCA_Parascaptor.pdf", plot = pca_plot, width = 12, height = 8)

# ==============================================================================
# CANONICAL VARIATE ANALYSIS (CVA)
# ==============================================================================

# Read the morphometric data (same dataset as PCA)
parascaptor <- read_excel("./para_log10.xlsx")
data <- parascaptor[, 2:16]
species_names <- parascaptor[[1]]

# Perform PCA as a preprocessing step for CVA
pca_result <- prcomp(data, scale. = TRUE)

# Extract shape data (all PCs except the first one)
shape_data <- pca_result$x[, -1]

# Perform Linear Discriminant Analysis (LDA) for CVA
cva_results <- lda(shape_data, grouping = species_names)

# Extract CVA scores from the LDA results
cva_scores <- predict(cva_results)$x

# Create data frame for ggplot visualization
df <- data.frame(
  CV1 = cva_scores[, 1],
  CV2 = cva_scores[, 2],
  species = species_names
)

# Define color palette for species visualization (same as PCA)
palette <- c("#636EFA", "#EF553B", "#00CC96")

# Calculate convex hull for each species group in CVA space
# This creates a polygon around each species cluster
hull_data <- df %>%
  group_by(species) %>%
  do(hull = .[chull(.$CV1, .$CV2), c("CV1", "CV2")]) %>%
  unnest(cols = c(hull))

# Create CVA plot with convex hulls
cva_plot <- ggplot(df, aes(x = CV1, y = CV2, color = species)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_polygon(
    data = hull_data,
    aes(x = CV1, y = CV2, group = species, fill = species),
    alpha = 0.2, color = NA
  ) +
  scale_color_manual(values = palette) +
  scale_fill_manual(values = palette) +
  theme_minimal() +
  labs(
    title = expression("CVA of " * italic("Parascaptor") * " species - craniomandibular variables"),
    x = "Canonical Variate 1",
    y = "Canonical Variate 2"
  ) +
  theme(
    plot.title = element_text(size = 22, hjust = 0.5),
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16),
    axis.text = element_text(size = 13),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  )

# Display the CVA plot
print(cva_plot)

# Save CVA plot as PDF file
ggsave("./CVA_Parascaptor.pdf", plot = cva_plot, width = 12, height = 8)
