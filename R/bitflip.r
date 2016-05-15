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
  
  vector <- as.bit(sample(c(0,1), length, replace=T))
  
  make.bitflip <-function(){
    for(i in 1:iterations){
      index <- sample(1:length(vector),1)
      vector[index] <- !vector[index] 
    }
  }
  
  time <- microbenchmark(make.bitflip(), times=1)
  time <- time$time/1e9
  
  cat('R-bit', length,  time, sep=",")
  cat('\n')
})