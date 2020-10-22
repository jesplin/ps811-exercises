setwd("C:/Users/jesse/OneDrive - UW-Madison/2020 Fall Semester/811 Intro to R/ps811-exercises/exercise 5")
national <- read.csv("national.csv")

#Load packages
install.packages('dplyr')
library(dplyr)
library(purrr)
library(tidyr)
library(tidyverse)


#Problem 1
for (i in 1:79) {
  i/1995
}
# There are 79 variables in 1995 observations


#Problem 2
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
sapply(national, class)


#Problem 4
log(national$buddhism_all)


#Problem 5
unique(national$year[national$christianity_all>300000])


#Problem 6
national %>%
  group_by(code) %>%
  nest()


#Problem 7 ##
nested_national <- national %>%
  group_by(state) %>%
  nest() %>%
  print()

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
model <- lm(judaism_percent ~ dual_religion, data = national)


#Problem 8 ##
nested_coefs <- model %>%
  mutate(coefs = map(model, coefficients)) %>%
  print()

nested_coefs$coefs
#This didn't work for me

#Tried a simpler version
coefficients <- c(summary(model)$coefficients[1],summary(model)$coefficients[2])


#Problem 9
print(coefficients)


#Problem 10
coefs <- nested_coefs %>%
  unnest(coefs) %>%
  print()


#Problem 11
coefs <- nested_coefs %>%
  unnest(coefs) %>%
  print()