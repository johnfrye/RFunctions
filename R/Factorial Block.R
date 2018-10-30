# factorial block ---------------------------------------------------------

ss2 <- expand.grid(department = unique(df_item$department), 
                   performance_tier = unique(df_item$performance_tier),
                   stringsAsFactors = FALSE)