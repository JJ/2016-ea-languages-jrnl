iterations <- 100000
max.exp <- 16

sapply(1:max.exp, function(e){
  length <- 2**e
  
  vector <- sample(c(0,1), length, replace=T)
  
  start <- proc.time()
  
  for(i in 1:iterations){
    result <- sum(vector)
  }
  
  stop <- proc.time()
  time <- unname((stop - start)["elapsed"])
  
  cat("R vector c(1,0) ", length, " ", time, "\n")
})