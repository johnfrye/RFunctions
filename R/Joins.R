#  joins ------------------------------------------------------------------

(joincols <- intersect(names(df), names(df2)))
str(df[, joincols])
str(df2[, joincols])

df3 <- left_join(df, df2, by=joincols)