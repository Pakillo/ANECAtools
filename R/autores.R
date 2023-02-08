
#' Extraer autores
#'
#' @param aut.text Cadena de texto conteniendo el nombre de uno o varios autores
#' @param aut.sep Caracter(es) que separa cada autor en `aut_text`
#' @param mayus Poner todos los caracteres en mayusculas (TRUE) o dejarlos tal cual (FALSE)?
#'
#' @return Vector con los nombres de los autores
#' @export
#'
#' @examples
#' \dontrun{
#' extraer_autores("Quintero, Elena; Rodriguez-Sanchez, Francisco; Jordano, Pedro")
#' }
extraer_autores <- function(aut.text = NULL, aut.sep = "; ", mayus = TRUE) {

  if (!is.null(aut.text)) {
    if (isTRUE(mayus)) {
      aut.text <- toupper(aut.text)
    }
    auts <- stringr::str_split_1(aut.text, pattern = aut.sep)

    message("Se han identificado ", length(auts), " autores:\n\n", paste(auts, collapse = "\n"))
  }

}


#' Pegar autores
#'
#' @param autores Vector con los nombres de los autores
#' @param pausa Tiempo (en segundos) que dura el nombre de cada autor en el portapapeles
#' (para que de tiempo a pegar cada uno en la aplicacion de la ANECA)
#'
#' @return Los autores son copiados al portapapeles secuencialmente
#'
#' @keywords internal
#' @noRd
#'
pegar_autores <- function(autores = NULL, pausa = 3) {

  message("\nCopiando cada autor al portapapeles cada ", pausa, " segundos.\n")
  listo <- utils::askYesNo("Listo para comenzar a pegar autores en la aplicacion de la ANECA?")

  if (isTRUE(listo)) {

    clipr::clear_clip()
    Sys.sleep(pausa)

    for (i in autores) {
      clipr::write_clip(i, object_type = "character")
      Sys.sleep(pausa)
    }

    clipr::clear_clip()
    message("Listo! Espero que te haya dado tiempo :)")

  }

}


pegar_texto <- function(texto = NULL, mayus = TRUE) {

  if (isTRUE(mayus)) texto <- toupper(texto)
  clipr::write_clip(texto, object_type = "character")

}

