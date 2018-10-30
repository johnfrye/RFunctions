# Load files with fileTable -----------------------------------------------

for(i in 1:nrow(files)){
  df <- read_excel(files$file_path[i], skip = 1)
  if(i==1) comb <- df
  if(i>1)  comb <- rbind(comb, df)
}
