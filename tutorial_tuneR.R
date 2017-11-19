library(tuneR)

sound <- sine(440, bit = 16)

writeWave(sound, '440.wav')