#' Seizure Counts for Epileptics
#'
#' @description Thall and Vail (1990) give a data set on two-week 
#' seizure counts for 59 epileptics. The number of seizures was 
#' recorded for a baseline period of 8 weeks, and then patients 
#' were randomly assigned to a treatment group or a control group. 
#' Counts were then recorded for four successive two-week periods. 
#' The subject's age is the only covariate.
#'
#' @format his data frame has 295 rows and the following 5 columns:
#' \describe{
#'   \item{y}{the count for the 2-week period.}
#'   \item{trt}{treatment, "placebo" or "progabide"}
#'   \item{post}{post treatment. 0 for no, 1 for yes}
#'   \item{subject}{subject id}
#'   \item{tj}{time}
#' }
#' @source \url{https://cran.r-project.org/package=MASS}
"df_epil"