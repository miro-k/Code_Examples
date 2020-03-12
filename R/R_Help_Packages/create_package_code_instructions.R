# ****************************************************************************************
#
# PREAMBLE
#
# ****************************************************************************************

rm(list = ls())

lapply(c("tidyverse",
         "magrittr",
         "devtools",
         "roxygen2"), library, character.only = TRUE)

rootdir <- file.path("C:", "Users", "MK", "Documents", "pCloud_Sync_offline")
pckgdir <- file.path(rootdir, "Projects", "Personal", "Project_R_Packages", "Packages")

# Initialize a new package ---------------------------------------------------------------

# Use 'utils' package to generate a skeleton package
utils::package.skeleton(name = "<package name string>", path = pckgdir)

# Use 'devtools' package to generate a skeleton package
# devtools::create("<package name string>")


# Use 'Roxygen' to generate (some) documentation -----------------------------------------

# Intro into 'Writing documentation with Roxygen2'


# Steps:
# 1. Remove 'NAMESPACE' file created automatically as a part of the skeleton package;
#    Roxygen will generate a new one for us.
# 2. Add comments to the content (functions) of the package; follow the example shown
#    on website above. Comments have to be of specific kind and format for Roxygen
#    to be able to generate documentation from them.
devtools::document(file.path(pckgdir, "mcf"))


# Build the package (.tar file) and install it -------------------------------------------

# Build/re-build the package using 'devtools' functions. Note that the path must specify
# the path to the directory in which the package is stored. The result will be a 'tar.gz'
# file named after the package and its version (automatically added from the package's
# DESCRIPTION file)
devtools::build(file.path(pckgdir, "mcf"))

# Install the package from the '.tar.gz' file
install.packages(file.path(pckgdir, "mcf_1.2.tar.gz"), type = "source", repos = NULL)

# Remove (uninstall) the package
remove.packages("mcf")


# Test the new package -------------------------------------------------------------------

# Which packages are currently loaded?
search() %>% cbind()

# Load the package into the current R session
library("mcf")

# Unload the package from the current session (oposite to 'library'). Note that
# 'package:<name>' must be used, and the argument unload = TRUE; otherwise R removes
# the package from the search path but doesn't unload it.
detach(package:mcf, unload = TRUE)

# Basic help/description of the package and its content
packageDescription("mcf")
help(package = "mcf")
library(help = "mcf")

# Help for specific functions. Note that it's a good practice to prefix the function
# name with the name of the package 'mcf::'. Sometimes the same function name can be
# in more than package, so this avoid dubiousness.
?mcf::keep_objects
?mcf::time_to_execute
?mcf::is_cid
?mcf::is_sin
?mcf::list_to_array
?mcf::tbl_freq
?mcf::tbl_str
?mcf::tbl_sum_num
?mcf::tbl_sum_dates
?mcf::print_docs


# Delete files no longer needed ----------------------------------------------------------

# file.remove(paste(pckgdir, "mcf_1.1.tar.gz", sep = "/"))
# file.remove(paste(pckgdir, "mcf","NAMESPACE", sep = "/"))
# file.remove(paste(pckgdir, "mcf", "man","keep_objects.Rd", sep = "/"))


