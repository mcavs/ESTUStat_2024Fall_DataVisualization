# ---------------------------------------------------------------------------
# Data Visualization Lab 3
# Exercises for Week 5
# Oct 21, 2024
# ---------------------------------------------------------------------------
# Creating the bridge dataset
bridge <- data.frame(material = rep(c("iron", "wood", "steel"), each = 4),
                     era = rep(c("crafts", "emerging", "mature", "modern"), 3),
                     number = c(5, 3, 3, 0,
                                13, 2, 0, 0,
                                0, 10 , 50, 19))
bridge 

# ----------------------------------------------------------------------------
# Pie Chart
# ----------------------------------------------------------------------------
# We can draw a pie chart using the pie() function.
# However, this function only works with numeric variables.
# If we want to visualize a categorical variable, we can use the table() 
# function to calculate the frequencies of the levels of the categorical variable 
# and obtain the pie chart.
# You can run the table() function separately to explore its functionality.

pie(table(bridge$material),
    main = "Bridges for the materials")

# You can find out how to customize pie charts here:
# http://homepages.gac.edu/~anienow2/MCS_142/R/R-piechart.html


# ----------------------------------------------------------------------------
# Multiple Pie Chart 1
# ----------------------------------------------------------------------------

marketshare <- data.frame(percent = c(17, 18, 20, 22, 23, 20, 20, 
                                      19, 21, 20, 23, 22, 20, 18, 17),
                          company = rep(LETTERS[1:5], 3),
                          year = rep(c("2015", "2016", "2017"), each = 5))

ggplot(data = marketshare, aes(x      = "", 
                               y      = percent, 
                               group  = year, 
                               colour = company, 
                               fill   = company)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) + 
  facet_grid(.~ year) +
  theme_void()


# ----------------------------------------------------------------------------
# Multiple Pie Chart 2
# ----------------------------------------------------------------------------

# The percentage distribution of goals scored by 4 teams after 12 weeks in the Super League
gol <- data.frame(Team = rep(c("Galatasaray", 
                               "Fenerbahçe",
                               "Beşiktaş",
                               "Trabzonspor"), each = 3),
                  Area = rep(c("Defense",
                               "Midfield",
                               "Attack"), 4),
                  goal_count = c(6, 61, 33,
                                 6, 71, 23,
                                 14, 53, 33,
                                 0, 74, 26))

ggplot(data = gol, aes(x = "", 
                       y      = goal_count, 
                       group  = Team, 
                       colour = Area, 
                       fill   = Area)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) + 
  facet_grid(.~ Team) +
  theme_void()

ggplot(gol, aes(fill = Area, 
                y    = goal_count, 
                x    = Team)) + 
  geom_bar(position = "stack", 
           stat     = "identity") +
  labs(y = "Percentage")

# ----------------------------------------------------------------------------
# Creating a stacked bar chart
# ----------------------------------------------------------------------------

ggplot(marketshare, aes(fill = company, 
                        y    = percent, 
                        x    = year)) + 
  geom_bar(position = "stack", 
           stat     = "identity")


# ----------------------------------------------------------------------------
# Creating a grouped bar chart
# ----------------------------------------------------------------------------

ggplot(marketshare, aes(fill = company, 
                        y    = percent, 
                        x.   = year)) + 
  geom_bar(position = "dodge", 
           stat     = "identity")

# ----------------------------------------------------------------------------
# Creating a percentage stacked bar chart
# ----------------------------------------------------------------------------

library(readr) # Required for importing data into R
library(dplyr) # Required for data manipulation

# First, let's pull the data; you can find the data in the 
# women_tidy.csv file located in the same folder on GitHub.
# You should use the location of the file on your computer as the URL.
# Alternatively, you can use the "Import Dataset" button.
#women <- read_csv("women_tidy.csv")

# Let's filter the rows for Turkey in the dataset, and 
# add the male ratio we need for plotting.
Turkey <- women_tidy |>
  filter(country == "Turkey", year > 2002) |>
  mutate(perc_men = 100 - perc_women)

# We need to pivot the data to make it tidy.
Turkey_pivoted <- Turkey[,3:5] |> pivot_longer(!year, 
                                                names_to  = "gender", 
                                                values_to = "percent")

# Let's create the plot using ggplot and 
# make the necessary adjustments.
ggplot(Turkey_pivoted, aes(fill = gender, 
                           y    = percent, 
                           x    = year)) + 
  geom_bar(position = "stack", 
           stat = "identity") +
  labs(x        = "Year",
       y        = "Relative Percentage (%)",
       fill     = "Gender",
       title    = "Gender Ratio in the Parliament of the Republic of Turkey",
       subtitle = "2003-2016") + 
  scale_fill_discrete(labels = c("Male", "Female")) +
  theme_bw()


# ----------------------------------------------------------------------------
# Creating a mosaic plot
# ----------------------------------------------------------------------------

library(ggplot2)
library(ggmosaic)
ggplot(bridge) +
  geom_mosaic(aes(x = product(era),
                  weight = number,
                  fill = material)) +
  labs(x    = "Era",
       y    = "",
       fill = "Material") +
  scale_fill_discrete(labels = c("Iron", "Steel", "Wood")) + 
  scale_x_productlist(labels = c("Handmade", "Early Period", "Maturity Period", "Modern")) + 
  theme_bw()

# You can find out how to customize mosaic plots here:
# https://cran.r-project.org/web/packages/ggmosaic/vignettes/ggmosaic.html

# ----------------------------------------------------------------------------
# Creating a treemap
# ----------------------------------------------------------------------------

library(treemapify)

ggplot(bridge, aes(area = number, 
                   fill = era, 
                   label = material,
                   subgroup = era)) +
  geom_treemap() +
  geom_treemap_text(colour = "black",
                    place = "centre",
                    size = 15) +
  scale_fill_brewer(palette = "Blues") +
  geom_treemap_subgroup_border(colour = "white", 
                               size = 5) +
  geom_treemap_subgroup_text(place = "centre", 
                             grow = TRUE,
                             alpha = 0.25, 
                             colour = "black",
                             fontface = "italic") +
  theme(legend.position = "none")

# You can find out how to customize treemaps here:
# https://www.r-graph-gallery.com/treemap.html
