#' A Results Output Function
#'
#' This function will display basic descriptive statistics for a dataframe
#' @param x an object from psych::corr.test()
#' @export
#' @examples
#' table_descriptives(x)

table_descriptives <- function(x){
  r <- x$r
  n <- x$n
  p <- x$p

  table <- data.frame(Variable = rep(rownames(r), each = 3), parameter = rep(c("r", "n", "p"), nrow(r)))

  for (name in rownames(r)){
    r[name,][name] <- NA
    n[name,][name] <- NA
    p[name,][name] <- NA
    p[which(lower.tri(p))] <- p[which(upper.tri(p))]

    for (pair in names(r[,name])){
      table[which(table$parameter=="r" & table$Variable==pair), name] <- round(r[pair,name], 2)
      table[which(table$parameter=="n" & table$Variable==pair), name] <- round(n[pair,name], 2)
      table[which(table$parameter=="p" & table$Variable==pair), name] <- round(p[pair,name], 2)
    }
    table[which(is.na(table[,name])),name] <- ""
  }

  table <- knitr::kable(table, digits=2, format="html", caption="Correlations")
  table <- kableExtra::kable_styling(table, full_width = FALSE, position = "left")
  table <- kableExtra::column_spec(table, 1, bold = TRUE)
  table <- kableExtra::collapse_rows(table, columns = 1:2, valign = "top")
  return(table)
}