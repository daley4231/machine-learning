library(tidyverse)
library(tidymodels)

d <- read_csv("lab-1/data/ngsschat-processed-data.csv")

d

train_test_split <- initial_split(d, prop = .70)
data_train <- training(train_test_split)
data_test <- testing(train_test_split)

train_test_split
data_train
data_test

my_rec <- recipe(code ~ ., data = data_train)
my_rec

# specify model
my_mod <-
    logistic_reg() %>% 
    set_engine("glm") %>%
    set_mode("classification")
# specify workflow
my_wf <-
    workflow() %>%
    add_model(my_mod) %>% 
    add_recipe(my_rec)

fitted_model <- fit(my_wf, data = data_train)
final_fit <- last_fit(fitted_model, train_test_split)

final_fit

final_fit %>%
    collect_metrics()

