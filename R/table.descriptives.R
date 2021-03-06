#' A Results Output Function
#'
#' This function will display basic descriptive statistics for a dataframe
#' @param x dataframe
#'
#' @templateVar fun table.descriptives
#' @template template-depr_fun
NULL

#' @templateVar old table.descriptives
#' @templateVar new table_descriptives
#' @template template-depr_pkg
#'
#' @export
#' @examples
#' table.descriptives(x)

table.descriptives <- function(x){
  .Deprecated("table_descriptives")
  x <- tidyr::gather(x, "Variable", "value")
  x <- dplyr::group_by(x, Variable)
  x <- dplyr::summarise(x,
                        n = n(),
                        Mean = mean(value, na.rm=TRUE),
                        SD = sd(value, na.rm=TRUE),
                        min = min(value, na.rm=TRUE),
                        max = max(value, na.rm=TRUE),
                        Skewness = e1071::skewness(value, na.rm = TRUE, type = 2),
                        Kurtosis = e1071::kurtosis(value, na.rm = TRUE, type = 2),
                        '% Missing' = 100*(length(which(is.na(value)))/n()))
  x <- knitr::kable(x, digits=2, format="html", caption="Descriptive Statistics")
  x <- kableExtra::kable_styling(x)
  return(x)
}
