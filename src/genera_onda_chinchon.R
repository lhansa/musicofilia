genera_onda <- function(melodia, tiempos, ruta = "tmp/aaa.wav"){
  
  stopifnot(length(tiempos) %in% c(1,str_length(melodia)))
  
  melodia %>% 
    str_split(pattern = "") %>% 
    flatten_chr() %>% 
    data_frame() %>% 
    set_names("code") %>% 
    left_join(frequencies, by = "code") %>% 
    pull(frequency) %>% 
    map2(.y = tiempos,
         .f = function(f,l) sine(f, duration = l, xunit = "time")) %>% 
    reduce(bind) %>% 
    writeWave(ruta)
}
