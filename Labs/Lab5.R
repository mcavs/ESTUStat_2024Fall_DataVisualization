# ---------------------------------------------------------------------------
# Data Visualization Lab 5
# Exercises for Week 7
# Nov 18, 2024
# ---------------------------------------------------------------------------
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
# ---------------------------------------------------------------------------
# Visualizing the time series
# Scatter plot
# ---------------------------------------------------------------------------

preprint <- read.csv("https://raw.githubusercontent.com/mcavs/ESTUStat_2022Guz_VeriGorsellestirme/refs/heads/main/Al%C4%B1%C5%9Ft%C4%B1rmalar/preprint.csv")

# Use only the data from the "bioRxiv" archive after September 6, 2013
preprint_bio <- preprint |>
  filter(archive == "bioRxiv") |>
  filter(date > "2013-09-06")

# Use the geom_point geometry layer to create a scatter plot:
ggplot(preprint_bio, aes(x = date, y = count)) +
  geom_point(color = "dodgerblue3") + 
  labs(x = "year",
       y = "preprints/month") + 
  theme_classic() # this layer is used to simplify the background

# ---------------------------------------------------------------------------
# Visualizing the time series
# Scatter + Line plot
# ---------------------------------------------------------------------------
ggplot(preprint_bio, aes(x = as.Date(date), y = count)) +
  geom_point(color = "dodgerblue3") + 
  geom_line(color = "dodgerblue3") +
  labs(x = "year",
       y = "preprints/month") + 
  theme(panel.grid.major.y = element_line(size = 1.5),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())

# ---------------------------------------------------------------------------
# Visualizing the time series
# Line plot
# ---------------------------------------------------------------------------
ggplot(preprint_bio, aes(x = date, y = count)) +
  geom_line(color = "dodgerblue3") +
  labs(x = "year",
       y = "preprints/month") + 
  theme_classic()

# ---------------------------------------------------------------------------
# Visualizing the time series
# Line + Area plot
# ---------------------------------------------------------------------------
ggplot(preprint_bio, aes(x = date, y = count)) +
  geom_line(color = "deepskyblue4", size = 1.4) +
  theme_classic() +
  geom_area(fill = "deepskyblue") +
  labs(x = "year",
       y = "preprints/month") 

# ---------------------------------------------------------------------------
# Visualizing multiple time series
# Scatter plot
# ---------------------------------------------------------------------------

# Use the data from 3 different archives after the same date:
preprint_arc3 <- preprint |>
  filter(archive %in% c("bioRxiv", "PeerJ Preprints", "arXiv q-bio")) |>
  filter(date > "2013-09-06")

# Use the color aesthetic to distinguish between different archives. 
# Map the relevant variable to the color argument within aes:
ggplot(preprint_arc3, aes(x = date, y = count, color = archive)) +
  geom_point() +
  theme_classic() +
  labs(x = "year",
       y = "preprints/month",
       color = "") # in some cases, a legend title is not needed.

# ---------------------------------------------------------------------------
# Visualizing multiple time series
# Scatter + Line plot
# ---------------------------------------------------------------------------
ggplot(preprint_arc3, aes(x = date, y = count, color = archive)) +
  geom_point() +
  geom_line() +
  theme_classic() +
  labs(x = "year",
       y = "preprints/month",
       color = "") 

# ---------------------------------------------------------------------------
# Visualizing multiple time series
# Line plot
# ---------------------------------------------------------------------------
ggplot(preprint_arc3, aes(x = date, y = count, color = archive)) +
  geom_line() +
  theme_classic() +
  labs(x = "year",
       y = "preprints/month",
       color = "") 

# ---------------------------------------------------------------------------
# Visualizing multiple time series
# Creating a facet plot
# ---------------------------------------------------------------------------

# Facet plots allow us to draw multiple groups on separate plots 
# instead of drawing them on a single plot, arranged vertically, 
# horizontally, or in a grid.

# To create a facet plot, add the facet_grid layer to the ggplot function. 
# Then specify the categorical variable by which you want to create the facet layout. 
# If you use the rows argument within the layer, the plots are arranged side-by-side; 
# if you use the cols argument, they are arranged vertically.

ggplot(preprint_arc3, aes(x = date, y = count)) +
  geom_line() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  labs(x = "year",
       y = "preprints/month") +
  facet_grid(rows = vars(archive))

# ---------------------------------------------------------------------------
# Horizontal facet plot layout
# ---------------------------------------------------------------------------
# To arrange facet plots side-by-side, specify the relevant variable in the 
# col argument within the facet_grid() function:

ggplot(preprint_arc3, aes(x = date, y = count)) +
  geom_line() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank()) +
  labs(x = "year",
       y = "preprints/month") +
  facet_grid(cols = vars(archive))

# ---------------------------------------------------------------------------
# Visualizing the trend
# ---------------------------------------------------------------------------
ggplot(preprint_bio, aes(x = date, y = count)) +
  geom_line() +
  geom_smooth(se = FALSE) +
  labs(x = "year",
       y = "preprints/month") + 
  theme_classic()

# ---------------------------------------------------------------------------
# Visualizing trend smoothing
# adjusting the smoothness
# ---------------------------------------------------------------------------
ggplot(preprint_bio, aes(x = date, y = count)) +
  geom_line() +
  geom_smooth(se = FALSE,
              span = 0.3) +
  labs(x = "year",
       y = "preprints/month") + 
  theme_classic()

# ---------------------------------------------------------------------------
# Visualizing trend smoothing for multiple time series
# ---------------------------------------------------------------------------
ggplot(preprint_arc3, aes(x = date, y = count, color = archive)) +
  geom_line() +
  geom_smooth(se = FALSE) +
  theme_classic() +
  labs(x = "year",
       y = "preprints/month",
       color = "")
```
