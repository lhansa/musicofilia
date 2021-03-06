rm(list=ls()); gc()

library(tuneR)
library(stringdist)
library(tidyverse)

## Inicializaciones ----------------------------------------------

#Function to calculate frequency
freq <- function(n) 440*(2^(1/12))^n

#cello notes
notes <- c("C2",
        "C#2/Db2",
        "D2",
        "D#2/Eb2",
        "E2",
        "F2",
        "F#2/Gb2",
        "G2",
        "G#2/Ab2",
        "A2",
        "A#2/Bb2",
        "B2",
        "C3",
        "C#3/Db3",
        "D3",
        "D#3/Eb3",
        "E3",
        "F3",
        "F#3/Gb3",
        "G3",
        "G#3/Ab3",
        "A3",
        "A#3/Bb3",
        "B3",
        "C4",
        "C#4/Db4",
        "D4",
        "D#4/Eb4",
        "E4",
        "F4",
        "F#4/Gb4",
        "G4",
        "G#4/Ab4",
        "A4",
        "A#4/Bb4",
        "B4",
        "C5",
        "C#5/Db5",
        "D5",
        "D#5/Eb5",
        "E5",
        "F5",
        "F#5/Gb5",
        "G5",
        "G#5/Ab5",
        "A5",
        "A#5/Bb5",
        "B5")

## Datos (el preludio) ----------------------------------------------

#Table of frequencies
frequencies <- data_frame(n=-33:14) %>% 
  mutate(frequency = freq(n),
         note = notes,
         code = c(letters, toupper(letters))[1:48])

# frequencies$frequency[2:48]/frequencies$frequency[1:47]

#Codification of the goal melody
prelude <- "tAJHJAJAtAJHJAJAtCKJKCKCtCKJKCKCtEKJKEKEtEKJKEKEtFJHJFJFtFJHJFJF"

#Sample wav
if (exists("all_wave")) rm(all_wave)

all_wave <- frequencies %>% 
  filter(code == str_sub(prelude,1,1)) %>% 
  pull(frequency) %>% 
  sine(duration = 10000)

for (i in 2:nchar(prelude)){
  
  all_wave <- frequencies %>% 
    filter(code==substr(prelude,i,i)) %>% 
    select(frequency) %>% 
    as.numeric %>% 
    sine(duration = 10000) %>% 
    bind(all_wave, .)
  
}
# play(all_wave)
writeWave(all_wave, "tmp/PreludeSample.wav")

## Algoritmo genético (parámtros) -----------------------------------------------

popsize <- 500 #Population size
length <- str_length(prelude)

genes <- frequencies$code

maxfitness <- 2^(1-(stringdist(prelude, prelude, method="hamming")-length))
maxiter <- 200 #Max number of iterations

iter <- 1
mutrate <- 0.01

## Algoritmo genético -------------------------------------------------

#Initial population

population <- replicate(popsize, sample(genes, length, replace = TRUE)) %>%
  apply(2, function(x) paste(x,collapse=""))

#Fitness evaluation
fitness <- sapply(population, function(x){
  2^(1-(stringdist(x, prelude, method="hamming")-length))
  },USE.NAMES=FALSE)

#Maximum fitness
maxfitenss_iter <- max(fitness)

#Best melody
bestfit <- which((fitness)==max(fitness)) %>% 
  min() %>% 
  population[.]

results <- data_frame(
  iteration = iter, 
  best_melody = bestfit, 
  correct_notes = log(maxfitenss_iter, base = 2)-1
)

#Execution of the algorithm

while(maxfitenss_iter < maxfitness & iter < maxiter){
  
  population2 <- c()
  
  for (i in 1:(popsize/2)){
    
    parents <- sample(1:popsize, size=2, prob=fitness/sum(fitness), replace=FALSE) 
    mix <- sample(1:(length-1), 1)
    
    if (runif(1) > .25){
      p1 <- paste0(substr(population[parents[1]],1,mix), substr(population[parents[2]],mix+1,length))
      p2 <- paste0(substr(population[parents[2]],1,mix), substr(population[parents[1]],mix+1,length))
    } else {
      p1 <- population[parents[1]]
      p2 <- population[parents[2]]
    }
    for (j in 1:length) if(runif(1)<mutrate) substr(p1,j,j)=sample(genes,1)
    for (j in 1:length) if(runif(1)<mutrate) substr(p2,j,j)=sample(genes,1)
    population2 <- c(p1, p2) %>% c(population2)
  }
  
  #New population
  population <- population2
  
  fitness <- sapply(population, function(x){
    2^(1-(stringdist(x, prelude, method="hamming")-length))},
  USE.NAMES=FALSE)
  
  bestfit <- which((fitness)==max(fitness)) %>%
    min %>% 
    population[.]
  
  print(paste0("Iteration ",iter, ": ", bestfit))
  maxfitenss_iter <- max(fitness)
  iter <- iter+1
  
  results <- data_frame(
    iteration=iter, 
    best_melody=bestfit, 
    correct_notes=log(maxfitenss_iter, base = 2)-1) %>% 
    bind_rows(results)
  
}

## Resultados -----------------------------------------

results %>% 
  slice(120) %>% 
  pull(best_melody) %>% 
  genera_onda(0.25,"tmp/resultadoChinchon.wav")

genera_onda(prelude, 0.25)
