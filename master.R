rm(list=ls()); gc()

library(tidyverse)
library(tuneR)

walk(list.files("src",pattern = ".R", full.names = TRUE), source)

# sudo apt-get install sox
setWavPlayer("/usr/bin/play")
base <- 440

sine(base) %>% play()

# Pythagorean Intervals
# writeWave(
#   normalize(
#     sine(base) + sine(interval('minor-second', tuning = 'pythagorean') * base), 
#     unit = '32'
#   ),
#   'tmp/minor_second_pythagorean.wav'
# )

## Escala menor --------------------------------------------------------

escala_menor <- c("unison", "major-second", "minor-third", "perfect-fourth", 
  "perfect-fifth", "minor-sixth", "major-seventh","octave")

escala_menor %>% 
  map(function(int) interval(int, tuning = "pythagorean") * base) %>% 
  map(sine) %>% 
  reduce(bind) %>% 
  play()

## Sarabanda -----------------------------------------------------------

calcula_frecuencia <- function(int,vb) interval(int, tuning = "pythagorean") * vb

genera_onda <- function(f, t){
  
  if(length(f) == 0) return(silence(duration = t, xunit = "time"))

  return(sine(freq = f, duration = t, xunit = "time"))
}

gorgorito <- c("perfect-fifth", "octave", "major-seventh", "octave", 
               "major-second", "minor-third", "major-second", 
               "octave", "octave", NA_character_, "octave")

vbase <- c(
  rep(base, 4), 
  rep(interval("octave", tuning = "pythagorean")*base, 3), 
  rep(base, 4))

tiempos <- c(rep(0.5,4),
             0.5,1,0.5,
             0.5, 1, 0.1, 1.0)


gorgorito %>% 
  map2(.y = vbase,
       .f = calcula_frecuencia) %>% 
  map2(.y = tiempos , 
       .f = genera_onda) %>% 
  reduce(bind) %>% 
  play()
  

