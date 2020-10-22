setwd("C:/Users/jesse/OneDrive - UW-Madison/2020 Fall Semester/811 Intro to R/ps811-exercises/exercise 5")

# MS: the correct function that you supposedly used (for your later code to work at all below) is:
# national <- read.csv("national.csv")

#Load packages
install.packages('dplyr')
library(dplyr)
library(purrr)
library(tidyr)
library(tidyverse)


#Problem 1
# MS: you are trying to find the number of rows in the dataset. It seems like you already found the number of rows in the dataset and plugged the number in...check answer key...
for (i in 1:79) {
  i/1995
}
# There are 79 variables in 1995 observations


#Problem 2
# MS: awesome
#using base R:
tapply(
  X = national$christianity_protestant,
  INDEX = list(national$state),
  FUN = mean,
  na.rm = TRUE
)

#using Tidyverse:
national %>%
  group_by(state) %>%
  summarize(
    mean_nom = mean(christianity_protestant, na.rm = TRUE)
  )


#Problem 3
# MS: great
sapply(national, class)


#Problem 4
# MS: cool
log(national$buddhism_all)


#Problem 5
# MS: this is not a function...check answer key
unique(national$year[national$christianity_all>300000])


#Problem 6
# MS: great
national %>%
  group_by(code) %>%
  nest()


#Problem 7 ##
# MS: you can remove this part
nested_national <- national %>%
  group_by(state) %>%
  nest() %>%
  print()
# MS: .x = data and since dual_religion is the dependent variable, it should go on the left side of the equation, and judaism_percent, being the independent variable, should go on the right
# check answers
nested_models <- nested_national %>%
  mutate_at(
    model = map(
      .x = national,
      .f = ~ lm (judaism_percent ~ dual_religion, data = .x)
      )
  ) %>%
  print()  
#this one didn't work
#tried a more basic version
# MS: this is not a loop but a command
model <- lm(judaism_percent ~ dual_religion, data = national)


#Problem 8 ##
# MS: this needs to refer to the model in Problem 7...check answers
nested_coefs <- model %>%
  mutate(coefs = map(model, coefficients)) %>%
  print()

nested_coefs$coefs
# MS: once you resolve the issue above, you should be good to go
#This didn't work for me

#Tried a simpler version
# MS: you never defined "model" so it won't work...
coefficients <- c(summary(model)$coefficients[1],summary(model)$coefficients[2])


#Problem 9
# MS: this won't work because you need to grab the coefficients within the nested_coefs object
print(coefficients)


#Problem 10
# MS: You are unnesting here. Check answer key for reference to model column.
coefs <- nested_coefs %>%
  unnest(coefs) %>%
  print()


#Problem 11
# MS: good!
coefs <- nested_coefs %>%
  unnest(coefs) %>%
  print()