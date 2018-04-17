library(tuneR)

# https://datascienceplus.com/recording-and-measuring-your-musical-progress-with-r/
setWavPlayer("/usr/bin/play")

## Reading the sound --------------------------------------------------

originalSound <- readWave("G-scale.wav")
play(originalSound) 

## Extract the notes ------------------------------------------------------

scaleNotesFreqs <- c(NA, NA, NA, 196.00, 196.00, NA, 220.0, NA, NA, 246.9, NA, 261.6, 261.6, NA, 293.7, 293.7, NA, 329.6, 329.6, NA, 370.0, 370.0, NA, 392.0, NA)
scaleNotes <- noteFromFF(scaleNotesFreqs)



transcribeMusic(originalSound, expNotes = scaleNotes)<- c(NA, NA, NA, 196.00, 196.00, NA, 220.0, NA, NA, 246.9, NA, 261.6, 261.6, NA, 293.7, 293.7, NA, 329.6, 329.6, NA, 370.0, 370.0, NA, 392.0, NA)
scaleNotes <- noteFromFF(scaleNotesFreqs)

source("src/transcribeMusic.R")

transcribeMusic(originalSound, expNotes = scaleNotes)




## Pruebas -----------------------------------------------------------
onda <- readWave("Kurzweil-K2000-Dual-Bass-C1.wav")

play(onda)
plot(onda)



onda@left
onda@right

mono(onda,"left")

log(-onda@left[1],base = 2)+1


