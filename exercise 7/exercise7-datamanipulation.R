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

# my working directory using "here" package is set to C:/Users/jesse/OneDrive - UW-Madison/2020 Fall Semester/811 Intro to R/ps811-exercises



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

# ms: this could just be (skip the tibble()):
current_supreme_court <- data.frame(justice, state, position, replacing, year_confirmed, senate_conf_vote, nominated_by)
current_supreme_court


# Problem 2: justices.csv

# download data and load
justice_data <- read.csv(here("exercise 7/justices.csv"))


# ## can also download data via readr package
# library (readr)
# 
# # assign url object
# urlfile <- "https://raw.githubusercontent.com/marcyshieh/ps811/master/data/justices.csv"
# 
# # import dataset via url
# mydata<-read_csv(url(urlfile))



# Problem 3: merge justices.csv and SCDB_2020_01_justiceCentered_Citation.dta

# download dataset and load
scotus_data <- read_dta(here("exercise 7/SCDB_2020_01_justiceCentered_Citation.dta"))

# looked at data
view(justice_data)
names(justice_data)
view(scotus_data)
names(scotus_data)
table(justice_data$post_mn)
table(scotus_data$decisionDirection)
table(justice_data$justiceName)
table(scotus_data$justiceName)

# merge datasets - I think I'm supposed to do this via the justiceName variable?
full_data <- inner_join(justice_data, scotus_data, by = "justiceName")
# could not view(full_data)

# ms: I would suggest doing it by justiceName and term because you're trying to link these two variables

# ms: full data showed up for me but my laptop might just have more memory than you...don't worry about it! the data is in!


# Problem 4: filter to justices with Martin-Quinn scores

# filter new dataset to look at mq scores
scored_justices <- full_data %>% 
  select("justiceName", "post_mn", "decisionDirection") %>%
    filter(!is.na("post_mn"))

# checked for NAs in "post_mn" variable:
scored_justices %>% 
  select("justiceName", "post_mn", "decisionDirection") %>%
  anyNA("post_mn")
 
# returns TRUE so I don't think I'm filtering this correctly
## Marcy said this is correct so far

# ms: you're filtering this correctly because the anyNA() isn't part of the tidyverse package, so it's not taking in the inputed variable.

# ms: when you do:
anyNA("post_mn")
# ms: you can see that it comes out as FALSE


# Ethan sent me his code and I go through it here to solve the rest of the assignment because I got stuck after working on this for 2 hours
# I believe this counts as citing my sources? 

# ms: thanks for citing Ethan!


# join dataset (from)
joined_justices <- full_join(scotus_data, justice_data, by=c("justiceName", "term"))

# filter to justices with Martin-Quinn Scores (from Ethan)
filter(joined_justices, post_mn == TRUE)

# ms: i'd do the following instead:
joined_justices <- filter(joined_justices, !is.na(post_mn))


# Problem 5: find the mean Martin-Quinn score for each term

# filter from dataset, then group by term year, then summarise means (from Ethan)
mqscore_term<- joined_justices %>%
  group_by(term) %>%
  summarise(mean = mean(post_mn, na.rm = TRUE))

# print results (from Ethan)
print(mqscore_term, n = nrow(mqscore_term))



# Problem 6: find the mean decision direction for each term and rescale to Martin-Quinn score 

# mutate data so the values work like mq scores (from Ethan)
# noticing that this also follow's Marcy's lecture resource
joined_justices <- mutate(joined_justices,
                          decisionDirection = case_when(
                            decisionDirection == 1 ~ 1, #conservative
                            decisionDirection == 2 ~ -1, #liberal
                            decisionDirection == 3 ~ 0)) #unspecified

# create new variable for decisions grouped by term to match mq data (from Ethan)
decision_byterm <- joined_justices %>%
  group_by(term) %>%
  summarise(mean = mean(decisionDirection, na.rm = TRUE))

# print out results
print(decision_byterm, n = nrow(decision_byterm))



# Problem 7: compare the mean Martin-Quinn scores and vote directions

# compare mq scores and vote direction (from Ethan)
compare_mq_decision <- inner_join(mqscore_term, decision_byterm,
                                  by="term")

# Ethan noted that this results in a new variable that kept NAs

# ms: it's keeping the NAs because he did a full_join() in Problem 4 and kept both the justicesName and terms and continued slicing the data from that object he created and keeping all term years

# add column names to new variable to make it easier to understand (from Ethan)
colnames(compare_mq_decision) <- c("term", "MQ Score", "Vote Direction")

# view data (from Ethan)
view(compare_mq_decision)

# plot data to view visual comparison
plot(compare_mq_decision$`MQ Score`, compare_mq_decision$`Vote Direction`)

# The plot shows a pretty good correlation between the decisionDirection variable from the scotus dataset and the Martin-Quinn scores from the justices dataset (linear regression line  between the two)
