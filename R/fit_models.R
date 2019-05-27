fit_models <- function(formula, data) {
  
  fit.glmm <- lme4::glmer(formula, 
                          data = data, 
                          family = "poisson", 
                          offset = log(tj))
  
  sjPlot::tab_model(fit.glmm)
  
}