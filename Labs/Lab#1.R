# ---------------------------------------------------------------------------
# Data Visualization Lab 1
# Exercises for Week 3
# Oct 7, 2024
# ---------------------------------------------------------------------------

install.packages("ggplot2") # to use ggplot visualization tools
install.packages("dplyr") # to use the new pipe (|>) operator and perform data manipulation operations
install.packages("tidyverse")
library(ggplot2)
library(dplyr)
library(tidyverse)

# ---------------------------------------------------------------------------
# Visualization of the movie dataset found on page 45 of Wilke's book
# ---------------------------------------------------------------------------
# First, we need to define the data in tibble format:

movie <- tibble(name = c("Star Wars",
                         "Jumanji",
                         "Pitch Perfect 3",
                         "Greatest Showman",
                         "Ferdinand"),
                revenue = c(71565498,
                            36169328,
                            19928525,
                            8805843,
                            7316746))

# Let's examine the dataset
filmler

# To draw a barplot, we need to use the "geom_bar()" layer:
library(ggplot2)
ggplot(movie, aes(x = name, y = revenue)) +
  geom_bar()

# The code above returns an error because we did not specify the stat argument in the geom_bar() layer.
# The stat argument is typically used with the options "identity" or "count".
ggplot(movie, aes(x = name, y = revenue)) +
  geom_bar(stat = "identity")

# The "count" option for the stat argument can be used when there is a discrete variable in the dataset.
# Otherwise, you will encounter an error if you use this option.
ggplot(movie, aes(x = name, y = revenue)) +
  geom_bar(stat = "count") 

# In the plot above, you will notice that the values on the y-axis are in a different format.
# For example, 2e+07 is converted to decimal form as 2 x 10^7. Converting all values on the axis to decimal
# form allows us to obtain a more readable plot
ggplot(movie, aes(x = name, y = revenue)) +
  geom_bar(stat = "identity") + 
  scale_y_continuous(labels = scales::comma)

# Another step we need to take for this plot to be more easily readable is to sort the bars in 
# ascending or descending order based on their lengths. We can decide which option to choose 
# according to the content of the message.
ggplot(movie, aes(x = reorder(name, +revenue), y = revenue)) +
  geom_bar(stat = "identity")

# You will see that the reorder() function we use to sort the bars causes an error message for the 
# solution we use to change the format of the label values on the y-axis. To solve this problem, 
# you can use the solution below:
ggplot(movie, aes(x = reorder(name, +revenue), y = revenue)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

# As you can see, there can be multiple solutions to a problem that arises, and in some cases, not all solutions may work. 
# When you encounter such issues, remember that your first resource should be Google or stackoverflow.com.

# The last step we need to take for this plot is to arrange the axis titles and add the plot title.
ggplot(movie, aes(x = reorder(name, +revenue), y = revenue)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) + 
  labs(x       = "Movie",
       y       = "Revenue ($)",
       title   = "Highest Grossing Movies from December 22 to 24, 2017",
       caption = "Data source: Box Office Mojo") + 
  theme_bw()

# One of the main issues you may encounter in such plots is that the bar labels on the axis containing 
# the categorical variable can be very long, leading to overlapping and making them difficult to read. 
# A common but poor practice to solve this problem is to rotate the bar labels by 45 or 90 degrees, 
# which actually makes them harder to read.
ggplot(movie, aes(x = reorder(name, +revenue), y = revenue)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) + 
  labs(x       = "Movie",
       y       = "Revenue ($)",
       title   = "Highest Grossing Movies from December 22 to 24, 2017",
       caption = "Data source: Box Office Mojo") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) 
  

# Instead, switching the positions of the axes is a better solution to avoid making the plot harder to read.
ggplot(movie, aes(x = reorder(name, +revenue), y = revenue)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) + 
  labs(x       = "Movie",
       y       = "Revenue ($)",
       title   = "Highest Grossing Movies from December 22 to 24, 2017",
       caption = "Data source: Box Office Mojo") + 
  coord_flip() +
  theme_bw()

# ---------------------------------------------------------------------------
# Visualization of the US median income dataset found on page 49 of Wilke's book
# ---------------------------------------------------------------------------
# First, let's convert the continuous 'age' variable in the US_income_age dataset into a categorical variable.
# For this, we can use the within() function.

US_age_cat <- within(US_income_age, {   
  age.cat <- NA 
  age.cat[25 <= age & age <= 34] <- "25-34"
  age.cat[35 <= age & age <= 44] <- "35-44"
  age.cat[45 <= age & age <= 54] <- "45-54"
  age.cat[55 <= age & age <= 64] <- "55-64"
  age.cat[65 <= age & age <= 74] <- "65-74"})

final_US_income <- US_age_cat |> 
  drop_na() |> 
  group_by(age.cat) |> 
  summarise(moi = median(income))

ggplot(final_US_income, aes(x = age.cat, y = moi)) + 
  geom_bar(stat = "identity")

# If we try to draw the plot above without using the drop_na() function while preparing the data, 
# that is, without excluding missing observation values, you will see a bar labeled NA on the x-axis.

# We need to make a few adjustments to the plot to give it its final form:
ggplot(final_US_income, aes(x = age.cat, y = moi)) + 
  geom_bar(stat = "identity") + 
  labs(x       = "Age",
       y       = "Median Income ($)",
       title   = "2016 Median Income by Age Ranges of American Households",
       caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# If we try to sort the bars in the plot above in ascending or descending order based on the values they represent, 
# it becomes difficult to interpret the income changes based on age, which we have transformed into an ordered 
# categorical variable. Drawing conclusions about income changes based on the increase or decrease in age becomes challenging. 
# However, this situation may not always hold true. Even though the relevant variable is ordered and categorical, 
# we can perform the sorting operation based on the message we want to convey, contrary to its structure. 
# I want to warn you that this situation is not something we will encounter very frequently in practice.

ggplot(final_US_income, aes(x = reorder(age.cat, +moi), y = moi)) + 
  geom_bar(stat = "identity") + 
  labs(x       = "Age",
       y       = "Median Income ($)",
       title   = "2016 Median Income by Age Ranges of American Households",
       caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# Let's create a grouped bar chart using the same dataset.
# For this, we need to prepare the data again. Let's focus on some states for the grouping. 
# We can select the observations corresponding to the states using the filter() function, 
# and then use group_by() to calculate the median income for the grouped data by age and state,
# allowing us to access the data we will use for visualization.
final_US_income2 <- US_age_cat |>
  drop_na() |> 
  filter(state %in% c("Michigan", "Colorado", "Virginia", "Texas")) |>
  group_by(age.cat, state) |> 
  summarise(moi = median(income))

# To draw a grouped bar chart, we need to use two arguments. In aes(), we should specify the variable for 
# grouping using the 'fill' argument, and in the geom_bar() layer, we need to set the 'position' argument 
# to the value "dodge".
ggplot(final_US_income2, aes(x = age.cat, y = moi, fill = state)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  labs(x       = "Age",
       y       = "Median Income ($)",
       fill    = "State",
       title   = "2016 Median Income by Age Ranges of American Households",
       caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# We can sort the age groups in ascending or descending order using the reorder() function.
ggplot(final_US_income2, aes(x = reorder(age.cat, +moi), y = moi, fill = state)) + 
  geom_bar(stat = "identity", position = "dodge") + 
    labs(x       = "Age",
       y       = "Median Income ($)",
       fill    = "State",
       title   = "2016 Median Income by Age Ranges of American Households",
       caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# Alternatively, you can obtain a multi-panel plot based on a desired variable by using the facet_wrap() layer.
ggplot(final_US_income2, aes(x = age.cat, y = moi)) + 
  geom_bar(stat = "identity") + 
   labs(x       = "Age",
        y       = "Median Income ($)",
        fill    = "State",
        title   = "2016 Median Income by Age Ranges of American Households",
        caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  facet_wrap(~final_US_income2$state) + 
  theme_bw()

# Let's create a stacked bar plot using the same dataset.
# Here, we can use the dataset we prepared for the grouped bar plot:
# The only different step we need to take to draw the plot is to specify the 'position' argument 
# in the geom_bar() layer as "stack".
ggplot(final_US_income2, aes(x = age.cat, y = moi, fill = state)) + 
  geom_bar(stat = "identity", position = "stack") + 
    labs(x       = "Age",
         y       = "Median Income ($)",
         fill    = "State",
         title   = "2016 Median Income by Age Ranges of American Households",
         caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# ---------------------------------------------------------------------------
# Dot Plot Exercises
# ---------------------------------------------------------------------------
# We will use the "US_income_age" dataset for the applications in this section.
# Let's start by drawing a bar plot before the dot plot.

final_US_income3 <- US_income_age %>%
  drop_na() %>%
  group_by(state) %>%
  summarise(mean_income = mean(income))

ggplot(final_US_income3, aes(x = mean_income, y = state)) + 
  geom_bar(stat = "identity") + 
  labs(x = "Mean Income ($)",
       y = "State",
       fill = "State",
       title = "Average Income of American Households by State in 2016",
       caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# Since it is difficult to read the plot, the bars need to be sorted according to the values they represent.
ggplot(final_US_income3, aes(x = mean_income, y = reorder(state, +mean_income))) + 
  geom_bar(stat = "identity") + 
   labs(x = "Median Income ($)",
        y = "State",
        fill = "State",
        title = "Average Income of American Households by State in 2016",
        caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()

# Despite making all the necessary adjustments we have seen so far on this plot, the close values 
# of the states and the tightly packed long bars do not create a good (distinguishable) appearance. 
# In such cases, using a dot plot instead of a bar plot is a better choice. We can use the 
# geom_point() layer to create the dot plot.
ggplot(final_US_income3, aes(x = mean_income, y = reorder(state, +mean_income))) + 
  geom_point() + 
   labs(x = "Median Income ($)",
        y = "State",
        fill = "State",
        title = "Average Income of American Households by State in 2016",
        caption = "Data source: US Census Bureau (https://github.com/clauswilke/dviz.supp/blob/master/data/US_income_age.rda)") + 
  theme_bw()
