# installed the here package first

# load packages
library("here")
library(tidyverse)
library(tidyr)
library(dplyr)
library(purrr)

# Base R first
# can't find the dataset, not sure if any of this below will work rn


# load data
food_data <- read.csv(here("exercise 6/food_coded.csv"))

# extract the first 95 rows
food_data_95 <- food_data[1:95, ]

# look at variables using name
food_data_95[ , c("GPA", "calories_chicken", "drink", "fav_cuisine", "father_profession", "mother_profession")]

# look at variables using column index/number
food_data_95[ , c(######)]

# create new variable, convert scale from 1-10 to 1-100
  food_data_95$healthy2 <- food_data_95$healthy * 10, 
  
# filter to female students, GPA above 3.0
subset(food_data_95, female==1 & GPA > 3.0),

# arrange favorite cuisine in alphabetical order
food_data_95[order(food_data_95$fav_cuisine), ],

# find mean and standard deviation and summarize
data.frame(chicken_calories.mean = mean(food_data_95$chicken_calories, na.rm = TRUE),
           chicken_calories.sd = sd(food_data_95$chicken_calories, na.rm = TRUE),
           tortilla_calories.mean = mean(food_data_95$tortilla_calories, na.rm = TRUE),
           tortilla_calories.sd = sd(food_data_95$tortilla_calories, na.rm = TRUE),
           turkey_calories.mean = mean(food_data_95$turkey_calories, na.rm = TRUE),
           turkey_calories.sd = sd(food_data_95$turkey_calories, na.rm = TRUE),
           waffle_calories.mean = mean(food_data_95$waffle_calories, na.rm = TRUE),
           waffle_calories.sd = sd(food_data_95$waffle_calories, na.rm = TRUE)),

# summarize GPA and weight within gender and cuisine variables
aggregate(formula = cbind(gender, GPA) ~ weight + cuisine,
          data = food_data_95,
          FUN = function(x){
            c(mean = mean(x), sd = sd(x))
          })


# not sure I did this one above correctly
# example from Marcy's lecture
aggregate(formula = cbind(budget, gross) ~ country + genres, 
          data = movie_metadata_100, 
          FUN = function(x){
            c(mean = mean(x), sd = sd(x))
          })




# Tidyverse 

# load data
facebook_data <- read.csv(here("exercise 6/facebook-fact-check.csv"))

# extract last 500 rows
facebook_data_500tidy <- facebook_data %>%
  top_n(-500)

# look at even numbered columns
dplyr::select(facebook_data_500tidy, share_count, comment_count)

# mutate post types, this didn't work
post_type_coded %>%
  select (facebook_data_500tidy, Post.Type) %>%
  mutate(
           link = 1,
           photo = 2,
           text = 3,
           video = 4)

# arrange page names in reverse order
arrange(facebook_data_500tidy, desc(Page))


# find the mean and standard deviation and summarize
summarise(facebook_data_500tidy,
          share_count.mean = mean(share_count, na.rm = TRUE),
          share_count.sd = sd(share_count, na.rm = TRUE),
          reaction_count.mean = mean(reaction_count, na.rm = TRUE),
          reaction_count.sd = sd(reaction_count, na.rm = TRUE),
          comment_count.mean = mean(comment_count, na.rm = TRUE),
          comment_count.sd = sd(comment_count, na.rm = TRUE))


# summarize the data above for the mainstream values (in variable category)
facebook_data_500tidy %>% 
  group_by(mainstream, Category) %>% 
  summarise(share_count.mean = mean(share_count, na.rm = TRUE),
            share_count.sd = sd(share_count, na.rm = TRUE),
            reaction_count.mean = mean(reaction_count, na.rm = TRUE),
            reaction_count.sd = sd(reaction_count, na.rm = TRUE),
            comment_count.mean = mean(comment_count, na.rm = TRUE),
            comment_count.sd = sd(comment_count, na.rm = TRUE)) %>% 
  ungroup()

#this isn't working and I'm not sure why



## problems 5 and 8 are not complete










