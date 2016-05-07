iterations <- 100000
max.exp <- 16

sapply(1:max.exp, function(e){
  length <- 2**e
  
  vector.one <- sample(c(0,1), length, replace=T)
  vector.two <- sample(c(0,1), length, replace=T)
  
  start <- proc.time()
  
  for(i in 1:iterations){
    bounds <- sample(1:length, 2)
    bounds <- bounds[1]:bounds[2]
    
    swap.copy <- vector.one[bounds]
    vector.one[bounds] <- vector.two[bounds]
    vector.two[bounds] <- swap.copy
  }
  
  stop <- proc.time()
  time <- unname((stop - start)["elapsed"])
  
  cat("R vector c(1,0) ", length, " ", time, "\n")
})
