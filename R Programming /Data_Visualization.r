library(tidyverse)

# build chart 
# discrete = ไม่ต่อเนื่อง
# continuous =่ ต่อเนื่อง

ggplot(data = mtcars,
       mapping = aes(x = mpg)) +  #aes is fpr choose data for chart 
  geom_histogram()


ggplot(data = mtcars,
       mapping = aes(x = mpg)) +  
  geom_density(col = "Red")


ggplot(data = mtcars,
       mapping = aes(x = mpg)) +  
  geom_boxplot(fill = "Blue1")

# base layer
base <- ggplot(data = mtcars,
               mapping = aes(x = mpg))
base + geom_histogram(fill = "gold4")
base + geom_freqpoly(bins = 10, col = "salmon2")
base + geom_bar()

student <- data.frame(id = 1:5,
                      gender = c("M", "M", "M", "F", "F"))
student

ggplot(data = student, aes(gender)) + 
  geom_bar(fill = c("Red3", "Blue3"))

## two variavles chart both discrete

ggplot(mtcars, aes(hp, mpg)) +
  geom_point()

ggplot(mtcars, aes(hp, mpg)) +
  geom_smooth() +
  geom_point( size = 2, col = "blue4", alpha = 0.5) +
  geom_rug()

ggplot(mtcars, aes(hp, mpg)) + 
  geom_smooth(method = "lm", col= "salmon3", fill= "gold4", size =2) +
  geom_point(col = "black") +
  theme_minimal() #theme foe change background


## two chart continuous and discrete 
View(diamonds)
glimpse(diamonds) #use for preview dataset 


ggplot(diamonds, aes(carat, price)) +
  geom_smooth(col="red", fill="pink2") +
  geom_point(size = 0.01, alpha = 0.01, col="black")

ggplot(diamonds, aes(carat, price)) +
  geom_smooth(col="red", fill="pink2") +
  geom_point(size = 0.01, alpha = 0.01, col="blue") +
  coord_flip() #for change side x y 

ggplot(diamonds, aes(cut, price)) +
  geom_point(size = 10, col = "black", alpha = 0.02)

ggplot(diamonds, aes(cut, price)) +
  geom_violin() + 
  theme_classic()


## summarize data => build geom_col
agg_price_by_cut <- diamonds %>%
  group_by(cut) %>%
  summarise( med_price = median(price))

p1 <- ggplot(agg_price_by_cut,
             aes(cut, med_price)) +
  geom_col(fill= "salmon2") +
  theme_minimal()

# qplot -> quick plot
##ggplot2
p2 <- qplot( x=carat,
             y= price,
             data = diamonds,
             geom = "point",
             col = "blue")

p3 <- qplot(x=cut,
            data=diamonds,
            geom = "bar")
#library patchwork
library(patchwork)
(p1 + p2)/ p3
p1/p2/p3

ggplot(diamonds, aes(carat, price)) +
  geom_point(col = "blue4", alpha = 0.05, size = 0.5)

# sample n 
ggplot(sample_n(diamonds,5000), aes(carat, price)) + 
  geom_point()

# sample %n
set.seed(11)
ggplot(sample_frac(diamonds,0.03), aes(carat, price)) + 
  geom_point()

ggplot(sample_frac(diamonds,0.99), 
       aes(carat, price, col = cut)) + 
  geom_point() +
  theme_minimal() +
  scale_color_manual(
    values = c("red", "salmon", "pink", "green4", "blue2")
  )


ggplot(sample_frac(diamonds,0.99), 
       aes(carat, price, col = cut)) + 
  geom_point() +
  theme_minimal() +
  scale_color_brewer(type = "div",
                     palette = 4)

ggplot(sample_frac(diamonds,0.2), 
       aes(carat, price, col = price)) +
  geom_point(alpha=0.5) +
  theme_minimal() +
  scale_color_gradient(low = "gold2", 
                       high = "blue")


#facet
# segment the chart into group 
diamonds %>% 
  count(cut)

ggplot(sample_frac(diamonds, 0.1),
       aes(carat, price, col = price)) +
  geom_point(alpha = 0.8) +
  theme_minimal() +
  scale_color_gradient(low = "gold2", 
                       high = "blue") +
  facet_wrap(~cut, ncol = 2) 


ggplot(sample_frac(diamonds, 0.99),
       aes(carat, price, col = price)) +
  geom_point(alpha = 0.8) +
  theme_minimal() +
  scale_color_gradient(low = "gold2", 
                       high = "blue") +
  facet_grid(cut ~ clarity)

##########################################

#labels
ggplot(mtcars, aes(hp, mpg)) +
  geom_point() +
  theme_minimal() +
  labs(
    title = "My plot", 
    subtitle = "Plot Plot",
    x = "Horse Power", 
    y = "Miles per Gallon",
    caption = "Make BY : Beam"
  )

#simple bar chart 
ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar() +
  theme_minimal()

ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar(position = "fill") +
  theme_minimal()

ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar(position = "dodge") +
  theme_minimal()

ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar(position = "identity") +
  theme_minimal()

ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar(position = "stack") +
  theme_minimal()


#install more theme for ggplot 

library(ggthemes)

ggplot(diamonds, aes(cut, fill=color)) +
  geom_bar(position = "stack") +
  theme_wsj()
