# ---------------------------------------------------------------------------
# Data Visualization Lab 4
# Exercises for Week 6
# Nov 11, 2024
# ---------------------------------------------------------------------------
# loading the necessary packages
library(ggplot2)
library(dplyr)

# loading the mtcars dataset
# for detailed information about the dataset, check here:
# https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/mtcars
data("mtcars")

# ----------------------------------------------------------------------------
# Drawing a scatter plot
# ----------------------------------------------------------------------------

# Let's visualize the association between horsepower (hp) and 
# miles per gallon (mpg) variables in the mtcars dataset:

# to do this, we can use either the plot() function or the ggplot package.
# visualization using plot():
plot(mtcars$hp, mtcars$mpg,
     xlab = "hp",
     ylab = "mpg",
     main = "Visualization of the association between mpg and hp")

# visualization using ggplot:
ggplot(mtcars, aes(x = hp, y = mpg)) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp")

# let's also examine this association by considering the transmission type of the cars.
# this way, we can see if the association between these two variables 
# differs depending on the transmission type (automatic or manual):

ggplot(mtcars, aes(x = hp, y = mpg, colour = am)) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp")

# when you use the above commands, you'll notice that the transmission type (am) 
# variable, which has only two values, is visualized as if it has five different 
# values between 0 and 1. The reason for this is that the transmission type 
# variable is not defined as a categorical variable. In such cases, 
# we can use the factor() function to convert the variable into a categorical one.

ggplot(mtcars, aes(x = hp, y = mpg, colour = factor(am))) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp")

# when you run the above commands, you'll see that the labels for the 
# color aesthetics representing the transmission type are 0 and 1. 
# To make this more understandable, we need to identify whether the 
# 0 and 1 labels represent automatic or manual transmission. 
# For this, we can refer to the link provided at the top of this document.

ggplot(mtcars, aes(x = hp, y = mpg, colour = factor(am))) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp by transmission type",
       colour = "Transmission Type") + 
  scale_colour_discrete(labels = c("Automatic", "Manual"))

# to create the same visualization in a side-by-side layout, 
# we need to use the facet_grid feature:

ggplot(mtcars, aes(x = hp, y = mpg)) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp by transmission type") + 
  facet_grid(~am)

# when you run the above commands, you'll notice that the labels for 
# each grid created for the transmission type need adjustment. 
# Therefore, the 0 and 1 values of the transmission type variable 
# should be changed to "Automatic" and "Manual". The following 
# code can be used for this transformation:

mtcars$am <- ifelse(mtcars$am == 1, "Manual", "Automatic")

ggplot(mtcars, aes(x = hp, y = mpg)) + 
  geom_point() + 
  labs(title = "Visualization of the association between mpg and hp by transmission type") + 
  facet_grid(~am)

# In almost all analyses, the associations between all continuous 
# variables in the dataset are explored. The most useful tool for this 
# purpose is a scatter matrix. First, the continuous variables in the 
# dataset need to be identified.

# after checking the detailed information about the dataset, 
# we find that mpg, disp, hp, drat, and wt are continuous variables. 
# A scatter matrix can be drawn by selecting only the columns containing these variables:

plot(mtcars[, c(1,3:6)])
plot(mtcars[, c(1,3)])


# ----------------------------------------------------------------------------
# Drawing a correlogram
# ----------------------------------------------------------------------------

# The GGally, corrgram, and ellipse packages provide functions 
# for drawing correlograms. For detailed information, check here: 
# https://www.r-graph-gallery.com/correlogram.html

library(GGally)
ggcorr(mtcars[, c(1,3:6)]) 


# To make the correlogram more readable, we can use shape aesthetics. 
# For this, we can use the plotcorr function from the ellipse package. 
# First, we need to calculate the correlation coefficients of the variables 
# in the dataset using the cor() function. Let's assign this to the cor_mtcars object.
# After that, we can pass this object to the plotcorr function to generate the visual:

library(ellipse)
library(MetBrewer)
cor_mtcars <- cor(mtcars[, c(1,3:6)])
plotcorr(cor_mtcars[order(cor_mtcars[,1]), order(cor_mtcars[,1])])
