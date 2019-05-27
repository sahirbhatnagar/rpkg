context("run fit_model with packaged dataset df_epil")

data("df_epil")

fit <- try(fit_models(formula = y ~ trt*post + (1|subject), data = df_epil),
           silent = TRUE)

test_that("no error in fitting fit_models for the epilepsy data", {
  
  expect_false(inherits(fit, "try-error"))
  
})