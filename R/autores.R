
#' Extraer autores
#'
#' @param aut.text Cadena de texto conteniendo el nombre de uno o varios autores
#' @param aut.sep Caracter(es) que separa cada autor en `aut.text`
#' @param mayus ¿Poner todos los caracteres en mayúsculas (TRUE) o dejarlos tal cual (FALSE)?
#'
#' @return Vector con los nombres de los autores
#' @export
#'
#' @examples
#' \dontrun{
#' extraer_autores("Quintero, Elena; Rodriguez-Sanchez, Francisco; Jordano, Pedro")
#' }
extraer_autores <- function(aut.text = NULL, aut.sep = "; ", mayus = TRUE) {

  if (isTRUE(mayus)) {
    aut.text <- toupper(aut.text)
  }
  auts <- unlist(strsplit(aut.text, split = aut.sep))

  message("Se han identificado ", length(auts), " autores:\n\n")
  print(data.frame(Nombre = auts))

  invisible(auts)
}


#' Pegar autores
#'
#' Dado un vector de caracteres, esta función copiará cada item al portapapeles
#' secuencialmente. Pude utilizarse para rellenar cualquier campo con múltiples items,
#' aparte de los autores.
#'
#' @param autores Vector con los nombres de los autores
#' @param pausa Tiempo (en segundos) que dura el nombre de cada autor en el portapapeles
#' (para que dé tiempo a pegar cada uno en la aplicación de la ANECA)
#'
#' @return Los autores son copiados al portapapeles secuencialmente
#'
#' @export
#'
#' @examples
#' \dontrun{
#' autores <- extraer_autores("Quintero, Elena; Rodriguez-Sanchez, Francisco; Jordano, Pedro")
#' pegar_autores(autores)
#' }
pegar_autores <- function(autores = NULL, pausa = 3) {

  message("\nCopiando cada autor al portapapeles cada ", pausa, " segundos.\nSube el volumen! Sonara un 'beep' cuando este listo para pegar cada autor\ny un sonido especial cuando haya terminado\n")

  readline("Pulsa intro para comenzar a pegar autores en la aplicacion de la ANECA ")

  clipr::clear_clip()
  Sys.sleep(pausa)

  for (i in autores) {
    clipr::write_clip(i, object_type = "character")
    beepr::beep()
    if (which(autores == i) %in% seq(from = 20, to = 1000, by = 20)) {
      readline("?Necesitas una pausa? Pulsa intro cuando quieras continuar")
    }
    Sys.sleep(pausa)
  }

  beepr::beep(5)
  clipr::clear_clip()
  message("Listo!")

}



