
note <- function(timbre = data.frame(Amplitude = 1, Multiplier = 1), fundamental = 440, unit = '32')
{
  result <- silence()
  
  for (i in 1:nrow(timbre))
  {
    result <- result + timbre[i, 'Amplitude'] * sine(fundamental * timbre[i, 'Multiplier'])
  }
  
  result <- normalize(result, unit = '32')
  
  return(result)
}