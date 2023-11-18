## Data Transfoemation

library(dplyr)

## select, filter, mutate, arrange, summarise, group_by
imdb_df <- read_csv("imdb.csv")


# review data structure 
glimpse(imdb_df)

# head data freame
head(imdb_df, 10)
tail(imdb_df, 10)

select(imdb_df,MOVIE_NAME, SCORE)
select(imdb_df, 1, 5)

select(imdb_df, names = MOVIE_NAME, SC = SCORE)

imdb_df %>%
  select(names = MOVIE_NAME, 
         released_year = YEAR, 
         SCORE) %>%
  arrange(desc(SCORE)) %>%
  head(10)

# filter data 
filter(imdb_df, SCORE >= 9 | SCORE <= 8.8)

names(imdb_df) <- tolower(names(imdb_df))
names(imdb_df)

imdb_df %>%
  select(movie_name, score, length) %>%
  filter(score == 8.3 | score == 9 )

imdb_df %>%
  select(movie_name, score, length) %>%
  filter(score %in% c(9, 8.3))

# filter string
imdb_df %>%
  select(movie_name, genre, rating) %>%
  filter( genre == "Drama")

grepl("Drama", imdb_df$genre) #case sensitive 

imdb_df %>%
  select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb_df$genre))

# Create new column 
imdb_new <- imdb_df %>%
  mutate(score_group = if_else(score >= 9, "High Score", "Low Score"), 
         length_group = if_else(length >= 120, "Long Movie", "Short Movie"))



# arrand for sort 
imdb_new %>%
  arrange(rating,  desc(length))

# summary
imdb_new%>%
  summarise(AVG_SCORE = mean(score), 
            STD = sd(score))

# Join
favourite_films <- data.frame(id = c(5,10, 15, 20, 25))

favourite_films %>%
  inner_join(imdb_df, by = c("id" = "no"))

favourite_films %>%
  right_join(imdb_df, by = c("id" = "no"))




# ------------------- Data Transformation by using buildin dataset in R mtcars -----------------------------------

library(tidyverse)
## tibble vs data frame

mtcars
mtcars_tibble <- tibble(mtcars)
mtcars_tibble
class(mtcars_tibble)

mtcars_tibble %>%
  mutate(new = gear**2)

#sample n
sample_n(mtcars, size = 5)
sample_n(mtcars, size = 5, replace = T)

#sample frac
sample_frac(mtcars, 0.5, replace = T)
names(mtcars)


# sliice
mtcars %>%
  slice(6:10)

mtcars %>%
  slice(sample(nrow(mtcars), 10))

data_frame(mtcars)
data.frame(mtacrs)

apply(mtcars, )

filter(mtcars, mpg > 10)
filter[mtcars, mpg > 10]
mtcars[mtcars$mpg > 10, ]
mtcars[ , mtcars$mpg > 10]

select(mtcars, mpg, hp)
 mtcars %>%
   select(1,2:3,10)

 mtcars %>%
   select(11, everything())
 
