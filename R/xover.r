### Carga de paquetes
#######################################################
rm (list=ls())

pkgs = c("bit", "microbenchmark")
to.install <- pkgs[ ! pkgs %in% installed.packages() ]

if ( length(to.install) > 0 )
  install.packages( to.install, dependencies = TRUE)

sapply(pkgs, require, character.only=TRUE)
#######################################################

iterations <- 100000
max.exp <- 15

sapply(1:max.exp, function(e){
  length <- 2**e
  
  vector.one <- as.bit(sample(c(0,1), length, replace=T))
  vector.two <- as.bit(sample(c(0,1), length, replace=T))
  
  make.xover <-function(){
    for(i in 1:iterations){
      bounds <- sample(1:length, 2)
      bounds <- bounds[1]:bounds[2]
      
      swap.copy <- vector.one[bounds]
      vector.one[bounds] <- vector.two[bounds]
      vector.two[bounds] <- swap.copy
    }
  }
  
  time <- microbenchmark(make.xover(), times=1)
  time <- time$time/1e9
  
  cat('R-bit', length,  time, sep=",")
  cat('\n')
})
