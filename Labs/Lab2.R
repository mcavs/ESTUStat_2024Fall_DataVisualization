# ---------------------------------------------------------------------------
# Data Visualization Lab 2
# Exercises for Week 4
# Oct 14, 2024
# ---------------------------------------------------------------------------
# Installing and loading the required packages
install.packages("DALEX") # to access the Titanic dataset
install.packages("dplyr") # to use the pipe operator
install.packages("ggplot2")
library(DALEX)
library(dplyr)
library(ggplot2)

# Loading the Titanic dataset
data(titanic)
# Now we can view the dataset using the titanic command.

# ----------------------------------------------------------------------------
# Visualization of the age distribution of passengers on the Titanic using a histogram
# ----------------------------------------------------------------------------
ggplot(titanic, aes(x = age)) + 
  geom_histogram()
# After using this command, you will have drawn the histogram, but you will also encounter an error. 
# This is due to the lack of a sufficient number of observations to calculate the histogram bins for high age values.

# We can draw histograms for different bin values by changing the binwidth argument in the geom_histogram layer.
ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 5)

# In the histograms you have drawn, you will see that the bins are not separated from each other. 
# This is because both the bins and the bin borders are drawn in black. 
# To change this, you need to modify the color and fill arguments in the geom_histogram layer.
ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 5, 
                 color = "black", 
                 fill = "yellow")

# Let's adjust the axis names and the graph title:
ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 5, color = "white", fill = "grey30") + 
  labs(x = "Age", 
       y = "Frequency",
       title = "Age Distribution of Titanic Passengers")

# Although the largest value label on the x-axis is 60, we see that there are observations greater than this value. 
# A similar situation is observed on the y-axis as well. Therefore, the axis limits need adjustment:
ggplot(titanic, aes(x = age)) + 
  geom_histogram(color = "white", fill = "black") +
  labs(x = "Age", 
       y = "Frequency",
       title = "Age Distribution of Titanic Passengers",
       subtitle = "Histogram") #+ 
#  lims(x = c(0, 80), y = c(0, 500))

# ----------------------------------------------------------------------------
# Drawing histograms of the age distribution of passengers on the Titanic with different binwidths
# ----------------------------------------------------------------------------
install.packages("gridExtra")
library(gridExtra)
library(ggplot2)

g1 <- ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 1, color = "white", fill = "grey30") + 
  labs(x = "Age", 
       y = "Frequency",
       title = "binwidth = 1")

g2 <- ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 3, color = "white", fill = "grey30") + 
  labs(x = "Age", 
       y = "Frequency",
       title = "binwidth = 3");

g3 <- ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 5, color = "white", fill = "grey30") + 
  labs(x = "Age", 
       y = "Frequency",
       title = "binwidth = 5");

g4 <- ggplot(titanic, aes(x = age)) + 
  geom_histogram(binwidth = 10, color = "white", fill = "grey30") + 
  labs(x = "Age", 
       y = "Frequency",
       title = "binwidth = 10");

grid.arrange(
  g1,
  g2,
  g3, 
  g4
)

# ----------------------------------------------------------------------------
# Visualization of the age distribution of passengers on the Titanic using kernel density estimation
# ----------------------------------------------------------------------------
ggplot(titanic, aes(x = age)) + 
  geom_density(fill = "skyblue", color = "skyblue") +
  labs(x = "Age", 
       y = "Density",
       title = "Age Distribution of Titanic Passengers",
       subtitle = "Kernel Density Estimation") #+ 
#  lims(x = c(0, 80), y = c(0, 0.04))

# ----------------------------------------------------------------------------
# Drawing kernel density plots of the age distribution of passengers on the Titanic with different bandwidths
# ----------------------------------------------------------------------------
k1 <- ggplot(titanic, aes(x = age)) + 
  geom_density(fill = "skyblue", 
               color = "skyblue",
               bw = 0.1) +
  labs(x = "Age", 
       y = "Density",
       title = "bandwidth = 0.1") + 
  lims(x = c(0, 80), y = c(0, 0.04))

k2 <- ggplot(titanic, aes(x = age)) + 
  geom_density(fill = "skyblue", 
               color = "skyblue",
               bw = 2) +
  labs(x = "Age", 
       y = "Density",
       title = "bandwidth = 2") + 
  lims(x = c(0, 80), y = c(0, 0.04))

k3 <- ggplot(titanic, aes(x = age)) + 
  geom_density(fill = "skyblue", 
               color = "skyblue",
               bw = 3) +
  labs(x = "Age", 
       y = "Density",
       title = "bandwidth = 3") + 
  lims(x = c(0, 80), y = c(0, 0.04))

k4 <- ggplot(titanic, aes(x = age)) + 
  geom_density(fill = "skyblue", 
               color = "skyblue",
               bw = 5) +
  labs(x = "Age", 
       y = "Density",
       title = "bandwidth = 5") + 
  lims(x = c(0, 80), y = c(0, 0.04))

grid.arrange(
  k1,
  k2,
  k3, 
  k4
)

# ----------------------------------------------------------------------------
# Visualization of the age distribution of passengers on the Titanic by gender using a stacked histogram
# ----------------------------------------------------------------------------
ggplot(titanic, aes(x = age, fill = gender)) + 
  geom_histogram(color = "black") +
  labs(x = "Age", 
       y = "Frequency",
       title = "Age Distribution of Titanic Passengers by Gender",
       subtitle = "Stacked Histogram",
       fill = "Gender") + 
  scale_fill_discrete(labels = c("Female", "Male")) +
  lims(x = c(0, 80), y = c(0, 300)) + 
  theme_bw()

# ----------------------------------------------------------------------------
# Visualization of the age distribution of passengers on the Titanic by gender using kernel density estimation
# ----------------------------------------------------------------------------
ggplot(titanic, aes(x = age, fill = gender)) + 
  geom_density() +
  labs(x = "Age", 
       y = "Density",
       title = "Age Distribution of Titanic Passengers by Gender",
       subtitle = "Kernel Density Estimation",
       fill = "Gender") + 
  scale_fill_discrete(labels = c("Female", "Male")) +
  lims(x = c(0, 80), y = c(0, 0.04))

# In the graph obtained using the code above, the age distribution curves by gender overlap, 
# making it difficult to see the overall picture of the background level. 
# To resolve this, the colors need to be made transparent. 
# This requires changing the value of the alpha argument in the geom_density() layer. 
# The alpha argument takes values between 0 and 1: 
# 0 represents the most transparent value and 1 represents the most opaque value.
ggplot(titanic, aes(x = age, fill = gender)) + 
  geom_density(alpha = 0.5) +
  labs(x = "Age", 
       y = "Density",
       title = "Age Distribution of Titanic Passengers by Gender",
       subtitle = "Kernel Density Estimation",
       fill = "Gender") + 
  scale_fill_discrete(labels = c("Female", "Male")) +
  lims(x = c(0, 80), y = c(0, 0.04)) + 
  theme_bw()

# ----------------------------------------------------------------------------
# Visualization of the age distribution of passengers on the Titanic by gender using a stacked kernel density estimation graph
# ----------------------------------------------------------------------------
# To create a stacked kernel density estimation graph, the position argument in the geom_density layer 
# needs to be set to "fill". With this selection, the stacking operation is performed according to the fill variable in the ggplot layer.
ggplot(titanic, aes(x = age, fill = gender)) + 
  geom_density(position = "fill") +
  labs(x = "Age", 
       y = "Density",
       title = "Age Distribution of Titanic Passengers by Gender",
       subtitle = "Stacked Kernel Density Estimation",
       fill = "Gender") + 
  scale_fill_discrete(labels = c("Female", "Male"))  