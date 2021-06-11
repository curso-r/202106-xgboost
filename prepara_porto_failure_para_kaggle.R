library(tidyverse)

# carregar csv full -------------------------------------------------------
set.seed(19880923)
porto <- readr::read_csv("porto-seguro-safe-driver-prediction/train.csv") %>%
  mutate(id = sample(id, n()))

# separar treino/teste ----------------------------------------------------
set.seed(19880923)
porto_test_idx <- sample.int(nrow(porto), size = 100000)

porto_train <- porto[-porto_test_idx,]
porto_test <- porto[porto_test_idx,]

# separar teste/gabarito --------------------------------------------------
porto_gabarito <- porto_test %>% select(id, target)
porto_test$target <- NULL

# fazer submissao exemplo -------------------------------------------------
porto_exemplo_de_submissao <- porto_gabarito
porto_exemplo_de_submissao$target <- 1/(1 + exp(-(porto_test$ps_car_13 + 1e-6)))

# salva -------------------------------------------------------------------
write_csv(porto_train, "porto-seguro-safe-driver-prediction/porto_train.csv")
write_csv(porto_test, "porto-seguro-safe-driver-prediction/porto_test.csv")
write_csv(porto_gabarito, "porto-seguro-safe-driver-prediction/porto_gabarito.csv")
write_csv(porto_exemplo_de_submissao, "porto-seguro-safe-driver-prediction/porto_exemplo_de_submissao.csv")
