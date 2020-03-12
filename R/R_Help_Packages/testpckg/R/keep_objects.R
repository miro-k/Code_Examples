#' @title Keep selected objects
#'
#' @description Keep selected objects in the environment, remove all else.
#'
#' @param x Character string of object names
#'
#' @return NA
#'
#' @examples
#' o1 <- "Object 1"; #' o2 <- "Object 2"; #' o3 <- "Object 3" 
#' keep_objects(c("o1","o2"))
#' keep_objects("o1")
#' 
#' @export
#' 
keep_objects <- function(x) {
   
   rm(list = setdiff(ls(globalenv()), x), envir = globalenv())
}
