# Homework 2

You must pull a request for your report, which you have prepared in PDF format, with the necessary work done on the two cases you selected and named "FirstNameLastName.pdf" to this folder by 23:59 on November 3, 2024. 

**Case 1)** Using the apartments dataset in the DALEX package, perform visualizations that can answer the questions below:

- Visualize and interpret the average square meter (m2.price) prices of houses by districts. (10 + 10 points)
- Investigate and visualize how the average square meter (m2.price) prices of houses vary according to the number of rooms (no.rooms) in the house by districts, and provide your interpretation. (15 + 15 points)

**Case 2)** Using the Salaries dataset in the carData package, perform visualizations that can answer the questions below:

- Visualize and interpret the average salary according to academic rank (rank). (10 + 10 points)
- Investigate and visualize how the average salary varies by academic rank (rank) according to gender (sex), and provide your interpretation. (15 + 15 points)

**Case 3)** Using the Insurance dataset in the MASS package, perform visualizations that can answer the questions below:

- Visualize and interpret the average number of policies (Claims) according to age (Age). (10 + 10 points)
- Investigate and visualize how the average number of policies (Claims) varies by age (Age) according to the vehicle engine size (Group), and provide your interpretation. (15 + 15 points)

**Case 4)** Using the cu.summary dataset in the rpart package, perform visualizations that can answer the questions below:

- Visualize and interpret the average vehicle price (Price) by vehicle type (Type). (10 + 10 points)
- Investigate and visualize how the average vehicle price (Price) varies by vehicle type (Type) according to reliability (Reliability), and provide your interpretation. (15 + 15 points)

**Tips**

- Please pay attention to your comments, assignment titles, and subtitles. To provide better comments, remember that you should first familiarize yourself with the dataset. You can search Google for detailed information about the dataset.
- To call data from a package in R, first load the package using `install.packages("package_name")`, then call the package with `library(package_name)`, and finally call the dataset with `data(dataset_name)`. Make sure you see the dataset in the Environment screen.
- Ensure that the categorical variable you use during visualization is of factor type in R. You can check this through the console using the command `class(variable)`. If it is not, you should use `factor(variable)` in the place where you use the variable in the `ggplot()` function.
- If you encounter any issues, you can first try Googling or, as a second option, seek help through the Issues section (we can all look for answers to the questions here, and I would be very happy if we can answer what we know). 
