library(audio)
library(tuneR)

# https://datascienceplus.com/recording-and-measuring-your-musical-progress-with-r/
setWavPlayer("/usr/bin/play")

## Reading the sound --------------------------------------------------

originalSound <- readWave("G-scale.wav")
play(originalSound) 
plot(originalSound) 

## Extract the notes ------------------------------------------------------

source("src/transcribeMusic.R")

scaleNotesFreqs <- c(NA, NA, NA, 196.00, 196.00, NA, 220.0, NA, NA, 246.9, NA, 261.6, 261.6, NA, 293.7, 293.7, NA, 329.6, 329.6, NA, 370.0, 370.0, NA, 392.0, NA)
# scaleNotesFreqs <- c(NA, NA, NA, 392.0, 392.0, NA, 220.0, NA, NA, 246.9, NA, 261.6, 261.6, NA, 293.7, 293.7, NA, 329.6, 329.6, NA, 370.0, 370.0, NA, 392.0, NA)
scaleNotes <- noteFromFF(scaleNotesFreqs)

transcribeMusic(originalSound, expNotes = scaleNotes)

## Grabarse ---------------------------------------------------------

audiorec <- function(kk,f){  # kk: time length in seconds; f: filename
  
  if(f %in% list.files()){
    file.remove(f); print('The former file has been replaced')
  }
  require(audio)
  s11 <- rep(NA_real_, 16000*kk) # Samplingrate=16000
  message("5 seconds..") # Counting down 5 seconds befor the recording starts
  
  for (i in c(5:1)){
    message(i)
    Sys.sleep(1)
  }
  
  message("Recording starts now...")
  record(s11, 16000, 1)  # record in mono mode
  wait(kk)
  save.wave(s11,f)
  .rs.restartR() # As mentioned in the above cited post: recording with the audio package works once, but for some reason it will not continue to work afterwards unless the R session is restarted. For this reason I included a restart in this function. I am hoping to find a more elegant solution one day soon.
}

## Pruebas -----------------------------------------------------------

onda <- readWave("Kurzweil-K2000-Dual-Bass-C1.wav")

play(onda)
plot(onda)

head(onda@left)
head(onda@right)

play(mono(onda,"left"))
play(mono(onda,"right"))

log(-onda@left[1],base = 2)+1


