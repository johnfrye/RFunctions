
# Environment -------------------------------------------------------------

rm(list=ls())
pacman::p_load(stats, devtools, purrr, httr, readxl, openxlsx, 
               data.table, reshape2, dplyr, WorksheetFunctions, 
               tidyr, feather, tibble, pryr, writexl, skimr,
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
mem_used()

# Load Data ---------------------------------------------------------------

# see what github packages are available for an update --------------------
dtupdate::github_update(auto.install = TRUE)
devtools::install_github("rstudio/sparklyr", build_vignettes = TRUE)

installsource()
smutilities::update_smutilities()
smutilities::update_worksheetfunctions()
build_help("pivottabler")

# install unzipped source pkg from desktop --------------------------------

devtools::install("/home/john/Desktop/bioset")

source("http://bioconductor.org/biocLite.R")
biocLite("Biocupgrade")
biocLite("geigen")
bioc_pkgupdate()

# see all available demos
demo("MTS") # for pkgs in library
demo(package = .packages(all.available = TRUE)) # for *all* pkgs

PerformanceAnalytics::chart.Correlation(df, histogram=TRUE, pch=19)

# batch convert a bunch of columns
iris %>% mutate_at(vars(Sepal.Length:Petal.Width), as.numeric)

# Find first row in group --------------------------------------------------

group_by(manufacturer, banner, upc, product, date, net_cost) %>% 
  mutate(count = row_number()) %>% 
  ungroup() %>% 
  filter(count == 1)

# Evaluate a Package --------------------------------------------------------

library(goodpractice)
gp("smutilities")
  
# Text Manipulation & Subsetting ------------------------------------------

# remove periods
df$term <- gsub('^\\.+','', df$term)

# Locate All in String 

a <- str_locate_all(names, " ")
b <- sapply(a, function(x) max(x))

df_orig[, c(12:13, 15:31)] <- sapply(df_orig[, c(12:13, 15:31)], function(x) gsub("NULL", NA, x))

# Multiple Grep for tidy data
keep <- c("foreign_language_index", "english", "spanish", "linguistically_isolated")

matches <- unique(grep(paste(keep, collapse="|"), df$variable, value=F))
df <- df[matches, ]

# for vars in columns
indices <- c("store", "city", "pct", "index", "median", "average_household_size")

(matches <- unique(grep(paste(indices, collapse="|"), colnames(df), value=F)))
if(length(matches)>0) df2 <- df[, matches]

# Load files with fileTable -----------------------------------------------

for(i in 1:nrow(files)){
  df <- read_excel(files$file_path[i], skip = 1) %>% 
    mutate(date = files$date[i]) %>% 
    rename(upc = `Enter UPC`) %>% 
    select(date, upc)
  if(i==1) comb <- df
  if(i>1)  comb <- rbind(comb, df)
}

#  joins ------------------------------------------------------------------

(joinby <- intersect(names(df), names(df2)))
str(df[, joinby])
str(df2[, joinby])

joincols <- intersect(names(df_header1), names(df_header2))
df_header <- left_join(df_header2, df_header1, by=joincols)

show_query(tbl(con, "flights"))

# Help --------------------------------------------------------------------

# Google search starting with [r] will find 
# R-specific results, e.g. "[r] identity matrix"

# Put this into the GitHub search box to see people using the 
# llply() function from plyr: 

"llply" user:cran language:R

# Plotting ----------------------------------------------------------------

# helpful interactive view of par
listviewer::jsonedit(par())

# vector graphics

# pixels to inches conv
filename <- "SM Net GP Pct.pdf"
pix.width <-  1513
pix.height <-  932
pix.to.inches <-  0.010416667

ggsave(fp(gd, filename), g, width = pix.width * pix.to.inches, 
       height = pix.height * pix.to.inches)

# save all plots in display to one pdf
time <- time_stamp()
(pdfname <- paste0(title, " ", time, ".pdf"))
dev.copy(pdf, fp(gd, pdfname), width=11, height=8.5)
dev.off()

# save HTML
sink(fp(gd, "hypothesis_timeline.html"), append=FALSE)
hypo_graph
sink()

# bitmap graphical format
# without Cairo, Windows will produce non-anti-aliased graphics
# Cairo produces bitmap images with transparency, alpha levels, and anti-aliasing
png_name <- "test.png"
CairoPNG(file = fp(gd, "plotname.png"), width = 792, height = 612)
print(us.map.object)
dev.off()

# with ggplot objects
ggsave(plot = g, "Cairo ggsave.png", h = 9/3, w = 16/3, type = "cairo-png")

# color
pal <- choose_palette()
pal(4)
display.brewer.all()
colors <- brewer.pal(9, "Set1")

# To make a gif from plots:
#3 First make plots.
for(p in 1:20){
  png(paste0('img', p, '.png')  )
  plot(1:9, 1:9, pch = p)
  dev.off() 
}

# set graphics to plot 2 rows of two graphics each
par(mfrow=c(2,2))

#########

survey[, colnames(survey) %~% "bern"]
# or

subset(survey, select = colnames(survey) %~% "bern")
data <- data[, !names(data) %in% remove]

# Settings --------------------------------------------------------

library(operators)

# review all current settings
unlist(options())

# change settings for scientific notation
options(scipen=999)
options("scipen"=100, "digits"=4)
options("PCRE_use_JIT" = FALSE)
 
# return to default
options(scipen=0)

# set and reset par
dev.off()
windows()

opar <- par() 
on.exit(par(opar))

# Debugging ---------------------------------------------------------------

library(tracestack)
#after you get an error message, simply run:
tracestack()

# Select a File -----------------------------------------------------------

# to call a popup to choose a file:
file.choose()

# Control Loops -----------------------------------------------------------

# if else
if(x > 0){
  print("value is positive")
} else if (x < 0){
  print("value is negative")
} else{
  print("value is neither positive nor negative")
}

# Factors -----------------------------------------------------------------

# Never use as.numeric to convert a factor var to integer, instead use 
as.numeric(as.character(fac_var))

# deal with income levels expressed in a way that doesn't alphanumerically sort correctly
religion$income <- c("Less than $10,000" = "<$10k", 
                     "10 to under $20,000" = "$10-20k", 
                     "20 to under $30,000" = "$20-30k", 
                     "30 to under $40,000" = "$30-40k", 
                     "40 to under $50,000" = "$40-50k", 
                     "50 to under $75,000" = "$50-75k",
                     "75 to under $100,000" = "$75-100k", 
                     "100 to under $150,000" = "$100-150k", 
                     "$150,000 or more" = ">150k", 
                     "Don't know/Refused (VOL)" = "Don't know/refused")[religion$income]

c("50a"= 1, "60b"= 2, "70c" = 3)["70c"]

religion$income <- factor(religion$income, levels = c("<$10k", "$10-20k", "$20-30k", "$30-40k", "$40-50k", "$50-75k", "$75-100k", "$100-150k", ">150k", "Don't know/refused"))

################
# convert row values in 'mat' to fractions so each row adds up to 1
prop.table(mat, 1)

# site and user configuration file locations ------------------------------

R.home(component = "home")
# [1] "/opt/microsoft/ropen/3.4.1/lib64/R"
path.expand("~")
# [1] "/mnt/Storage/RWD"
.libPaths()
# relative path (from current dir):  fp("../")

# factorial block ---------------------------------------------------------

ss2 <- expand.grid(department = unique(df_item$department), 
                   performance_tier = unique(df_item$performance_tier),
                   stringsAsFactors = FALSE)

