
pegar_texto <- function(texto = NULL, mayus = TRUE) {

  if (isTRUE(mayus)) texto <- toupper(texto)
  clipr::write_clip(texto, object_type = "character")

}



procesar_fila <- function(fila = NULL, pausa = 4) {

  procesar <- utils::askYesNo(paste0("Quieres procesar '", fila[, 1], "'?"))

  if (isTRUE(procesar)) {

    message("\nCopiando cada campo al portapapeles cada ", pausa, " segundos.\nSube el volumen! Sonara un 'beep' cuando este listo para pegar \ny un sonido especial cuando haya terminado\n")
    clipr::clear_clip()

    for (i in seq_len(ncol(fila))) {
      Sys.sleep(pausa)
      message("\nCopiando '", names(fila)[i], "' al portapapeles:")
      cat(as.character(fila[, i]), "\n")
      pegar_texto(as.character(fila[, i]), mayus = FALSE)
      beepr::beep()
    }
    Sys.sleep(pausa)
    beepr::beep(5)
    clipr::clear_clip()
    return("Done!")
  } else return("OK!")
}
