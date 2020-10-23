# installed packages for haven and magrittr
 # install.packages("haven")
 # install.packages("magrittr")

# load libraries
library("here")
library("haven")
library("magrittr")
library("tidyverse")
library("tidyr")
library("dplyr")


# Problem 1: create a dataframe

# create vectors for each column
justice <- c("Clarence Thomas", "Ruth Bader Ginsburg", "Stephen Breyer", "John Roberts", "Samuel Alito", "Sonia Sotomayor", "Elena Kagan", "Neil Gorsuch", "Brett Kavanaugh")
state <- c("GA", "NY", "MA", "MD", "NJ", "NY", "MA", "CO", "MD")
position <- c("Associate Justice", "Associate Justice", "Associate Justice", "Chief Justice", "Associate Justice", "Associate Justice", "Associate Justice", "Associate Justice", "Associate Justice")
replacing <- c("Thurgood Marshall", "Byron White", "Harry Blackmun", "William Rehnquist", "Sandra Day O'Conner", "David Souter", "John Paul Stevens", "Antonin Scalia", "Anthony Kennedy")
year_confirmed <- c(1991, 1993, 1994, 2005, 2006, 2009, 2010, 2017, 2018)
senate_conf_vote <- c("52-48", "96-3", "87-9", "78-22", "58-42", "68-31", "63-37", "54-45", "50-48")
nominated_by <- c("George H.W. Bush", "Bill Clinton", "Bill Clinton", "George W. Bush", "George W. Bush", "Barack Obama", "Barack Obama", "Donald Trump", "Donald Trump")

# create dataframe
current_supreme_court <- tibble(justice, state, position, replacing, year_confirmed, senate_conf_vote, nominated_by)
print(current_supreme_court)

# changed to dataframe
supremecourt_df <- as.data.frame(current_supreme_court)
view(supremecourt_df)


#### DONT HAVE THE DATA YET
# Problem 2: justices.csv

# download data and load
justice_data <- read.csv(here("exercise 7/justices.csv"))


# Problem 3: merge justices.csv and SCDB_2020_01_justiceCentered_Citation.dta


# Problem 4: filter to justices with Martin-Quinn scores

# Problem 5: find the mean Martin-Quinn score for each term

# Problem 6: find the mean decision direction for each term and rescale to Martin-Quinn score 

# Problem 7: compare the mean Martin-Quinn scores and vote directions
