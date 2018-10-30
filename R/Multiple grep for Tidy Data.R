# Multiple grep for tidy data
keep <- c("foreign_language_index", "english", "spanish", "linguistically_isolated")

matches <- unique(grep(paste(keep, collapse="|"), df$variable, value=F))
df <- df[matches, ]

# for vars in columns
indices <- c("store", "city", "pct", "index", "median", "average_household_size")

(matches <- unique(grep(paste(indices, collapse="|"), colnames(df), value=F)))
if(length(matches)>0) df2 <- df[, matches]
