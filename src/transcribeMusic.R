transcribeMusic <- function(wavFile, widthSample = 4096, expNotes = NULL) {
  #See details about the wavFile, plot it, and/or play it
  #summary(wavFile)
  plot(wavFile)
  perioWav <- periodogram(wavFile, width = widthSample)
  freqWav <- FF(perioWav)
  noteWav <- noteFromFF(freqWav) 
  melodyplot(perioWav, observed = noteWav, 
             expected = expNotes, plotenergy = FALSE, 
             main = Sys.Date())
  #Print out notes names
  noteWavNames <- noteWav[!is.na(noteWav)]
  noteWavNames <- noteWavNames[1:21] # I limited the number of notes to 21 here - because that is the number of notes extracted from the G-Scale.wav file and to make comparisons later I need the extractions to be of the same length. 
  print(noteWavNames)
  print(notenames(noteWavNames))
  return(noteWavNames)
}

## Original --------------------------------------------------------------
# transcribeMusic <- function(wavFile, widthSample = 4096, expNotes = NULL){
#   #See details about the wavFile, plot it, and/or play it
#   #summary(wavFile)
#   plot(wavFile)
#   #play(wavFile, "/usr/bin/mplayer")
#   
#   perioWav <- periodogram(wavFile, width = widthSample)
#   freqWav <- FF(perioWav)
#   noteWav <- noteFromFF(freqWav) 
#   
#   #Smooth frequecies 
#   #noteWav <- smoother(noteWav)
#   
#   melodyplot(perioWav, observed = noteWav, expected = expNotes, plotenergy = FALSE)
#   
#   #Print out notes names
#   #noteWavNames <- noteWav[!is.na(noteWav)]
#   #notenames(noteWavNames)
# }

## Ejemplos -----------------------------------------------------------
# #Test1 (mono)
# testSound <- readWave("G-scale.wav")
# scaleNotesFreqs <- c(NA, NA, NA, 392.0, 392.0, NA, 220.0, NA, NA, 246.9, NA, 261.6, 261.6, NA, 293.7, 293.7, NA, 329.6, 329.6, NA, 370.0, 370.0, NA, 392.0, NA)
# scaleNotes <- noteFromFF(scaleNotesFreqs)
# transcribeMusic(testSound, expNotes = scaleNotes)
# 
# #Now let see what happen if music is in stereo
# #Test2 - 1
# songHlp <- readMP3("FE.mp3")
# testSound_stereo <- extractWave(songHlp, from = 0, to = 12, xunit = "time")
# testSound <- mono(testSound_stereo, "both") #average left and right channel
# transcribeMusic(testSound)
# 
# #Test2 - 2 (use each channel separately)
# testSound_lc <- channel(testSound_stereo, which = "left")
# testSound_rc <- channel(testSound_stereo, which = "right")
# transcribeMusic(testSound_lc)
# transcribeMusic(testSound_rc)