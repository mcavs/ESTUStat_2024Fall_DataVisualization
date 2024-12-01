# ---------------------------------------------------------------------------
# Data Visualization Lab 6
# Exercises for Week 8
# Nov 25, 2024
# ---------------------------------------------------------------------------
# Since the {TRmaps} package can be installed from GitHub,
# the {devtools} package, which facilitates package installation 
# from GitHub, must be installed first.
# You can check the package details at https://github.com/htastan/TRmaps.
install.packages("devtools")
library(devtools)

# Use the {devtools} package to install the {TRmaps} package.
devtools::install_github("htastan/TRmaps") 
#:: means use the function from a specific package
library(TRmaps)

# Additionally, the {sf} package needs to be installed. This is necessary 
# for visualizing spatial data types.
install.packages("sf")
library(sf)

# The tr_nuts3 data contains the information required to create visualizations 
# at the provincial level in Turkey.
data("tr_nuts3")

# Let's create a simple visualization at the provincial level.
ggplot(tr_nuts1) + 
  geom_sf()

# Let's create a simple visualization at the district level.
ggplot(tr_ilce) + 
  geom_sf()

# ---------------------------------------------------------------------------
# Creating a Choropleth at the Provincial Level      
# ---------------------------------------------------------------------------
# Loading the 2015 Turkey Happiness Index dataset at the provincial level
# from the TRMaps package
data("trdata2015")

# Creating a dataset consisting only of the province and happiness index variables.
tr_happiness <- trdata2015 |> 
  select(province, happiness_level)

# Merging the created dataset with spatial data points.
tr_happiness2 <- left_join(tr_nuts3, tr_happiness, by = c("name_tr" = "province"))

# Visualizing the happiness index on the map of Turkey.
ggplot(tr_happiness2) + 
  geom_sf(aes(fill = happiness_level)) +
  theme_void()

# ---------------------------------------------------------------------------
# Creating a Choropleth at the District Level        
# ---------------------------------------------------------------------------
# Load the dataset containing population information at the district level.
data("trpopdata_ilce")

# Creating a dataset consisting only of district codes and population variables.
ilce_pop_2019 <- trpopdata_ilce |> 
  filter(year == 2019) |> 
  select(no, pop) 

# Merging the created dataset with spatial data points.
ilce_pop_2019_comb <- left_join(tr_ilce, ilce_pop_2019, by = c("tuik_no" = "no"))

# Finally, adding newly created area and population density variables to the dataset.
ilce_pop_2019_comb <- ilce_pop_2019_comb |> 
  mutate(area = st_area(ilce_pop_2019_comb)) |> 
  mutate(density = pop / (Shape_Area * 10000), 
         logdensity = log(density))

# Creating a population density map for Istanbul.
ilce_pop_2019_comb |> filter(adm1 == "TUR034") |>
  ggplot() +
  geom_sf(aes(fill = density)) + 
  scale_fill_viridis_c(trans = "log10", 
                       breaks=c(0, 100, 1000, 10000)) +
  labs(fill = "Population Density") + 
  theme_void()
