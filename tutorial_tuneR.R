library(tuneR)

# https://github.com/lhansa/computer_music

bits <- 32

sound <- sine(440, duration = 44100, bit = bits)

writeWave(sound, "tmp/440.wav")


sound <- bind(sine(440, bit = bits),
              sine(880, bit = bits))

writeWave(sound, "tmp/octaves.wav")

sound <- bind(sine(440, bit = bits),
              sine(880, bit = bits), 
              sine(440, bit = bits) + sine(880, bit = bits))

sound <- normalize(sound, unit = as.character(bits))

writeWave(sound, "tmp/octaves.wav")

## Intervalos (I) ---------------------------------------------------

source("src/interval.R")

base <- 440

sound <- sine(base) + sine(interval('minor-second',
                                    tuning = 'pythagorean') * base)

sound <- normalize(sound, unit = '32')

writeWave(sound, 'tmp/minor_second_pythagorean.wav')

## Triadas ------------------------------------------------

source('src/triads.R')

writeWave(bind(major.triad(220,unit = "32"),
               silence(),
               minor.triad(interval('major-second') * 220,unit = "32"),
               silence(),
               major.triad(220,unit = "32")),
          'tmp/chord_sequence.wav')

## Timbres ------------------------------------------------
source('src/timbre.R')

writeWave(note(data.frame(Amplitude = c(1), Multiplier = c(1))), 'tmp/timbre1.wav')
writeWave(note(data.frame(Amplitude = c(1, 0.5, 0.5), Multiplier = c(1, 2, 3))), 'tmp/timbre2.wav')
writeWave(note(data.frame(Amplitude = c(1, rep(0.01, 9), 0.75, rep(0.01, 9), 0.5), Multiplier = seq(1, 3, by = 0.1))), 'tmp/timbre3.wav')
writeWave(note(data.frame(Amplitude = c(1, 1/3, 1/9, 1/27, 1/81), Multiplier = c(1, 2, 3, 4, 5))), 'tmp/timbre4.wav')
writeWave(note(data.frame(Amplitude = c(1, 1/4, 1/16, 1/4, 1/16), Multiplier = c(1, 2, 3, 4, 5))), 'tmp/timbre5.wav')
set.seed(1)
writeWave(note(data.frame(Amplitude = runif(11), Multiplier = seq(1, 2, by = 0.1))), 'tmp/timbre6.wav')


## Intervalos (II) -------------------------------------------------------------

base <- 440

# Pythagorean Intervals
writeWave(normalize(sine(base) + sine(interval('minor-second', tuning = 'pythagorean') * base), unit = '32'), 'tmp/minor_second_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('major-second', tuning = 'pythagorean') * base), unit = '32'), 'tmp/major_second_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('major-third', tuning = 'pythagorean') * base), unit = '32'), 'tmp/major_third_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('perfect-fourth', tuning = 'pythagorean') * base), unit = '32'), 'tmp/perfect_fourth_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('diminished-fifth', tuning = 'pythagorean') * base), unit = '32'), 'tmp/diminished_fifth_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('perfect-fifth', tuning = 'pythagorean') * base), unit = '32'), 'tmp/perfect_fifth_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('minor-sixth', tuning = 'pythagorean') * base), unit = '32'), 'tmp/minor_sixth_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('major-sixth', tuning = 'pythagorean') * base), unit = '32'), 'tmp/major_sixth_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('minor-seventh', tuning = 'pythagorean') * base), unit = '32'), 'tmp/minor_seventh_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('major-seventh', tuning = 'pythagorean') * base), unit = '32'), 'tmp/major_seventh_pythagorean.wav')
writeWave(normalize(sine(base) + sine(interval('octave', tuning = 'pythagorean') * base), unit = '32'), 'tmp/octave_pythagorean.wav')
