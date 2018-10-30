# Debugging

# Environment -------------------------------------------------------------

rm(list=ls())
pacman::p_load(stats, tools, devtools, purrr, httr, readxl, openxlsx,
               dplyr, writexl, tidyr, feather, WorksheetFunctions, 
               smutilities)


setoptions()
wd <- here::here()
ad <- here::here("analysis")
dd <- here::here("data")
gd <- here::here("graphics")
pd <- here::here("data", "Product Data")
fd <- here::here("feather")

ses.info <- sessioninfo::session_info()
time <- time_stamp()
pryr::mem_used()


# debug function ----------------------------------------------------------

# https://en.wikibooks.org/wiki/R_Programming/Debugging

debug(FUNCTION_NAME)

# The following commands are available:

# n	        Advance to next step. An empty line also works.
# c, cont	  Continue to the end of the current context. E.g. to the end the loop within a loop or to the end of the function.
# where	    Print the stack of function calls (where are you?)
# Q	        Exit the browser and return to the top-level R prompt.

# Debugging can be switched off with:

undebug(FUNCTION_NAME)

# There are a few related functions as well:
  
debugonce()   # Switch off debugging after the first call.
isdebugged()  # Check if a function is in degugging mode.


# Interactive Tracing and Debugging of Calls to a Function or Meth --------

# https://stat.ethz.ch/R-manual/R-devel/library/base/html/trace.html

trace(sum)
hist(rnorm(100)) # shows about 3-4 calls to sum()
untrace(sum)


# Debugging with RStudio --------------------------------------------------


# https://support.rstudio.com/hc/en-us/articles/205612627-Debugging-with-RStudio