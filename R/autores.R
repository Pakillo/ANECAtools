
#' Añadir autores de publicaciones
#'
#' @param aut.text Cadena de texto conteniendo el nombre de uno o varios autores
#' @param aut.bib Referencia en formato BibTeX (aún no implementado)
#' @param aut.sep Caracter(es) que separa cada autor en `aut_text`
#' @param pause Tiempo (en segundos) que dura el nombre de cada autor en el portapapeles
#' (para que dé tiempo a pegar cada uno en la aplicación de la ANECA)
#'
#' @return Los autores son pegados al portapapeles
#' @export
#'
#' @examples
#' \dontrun{
#' add_authors("Quintero, Elena; Rodriguez-Sanchez, Francisco; Jordano, Pedro")
#' }
add_authors <- function(aut.text = NULL, aut.bib = NULL, aut.sep = "; ", pause = 3) {

  if (!is.null(aut.text)) {
    auts <- stringr::str_split_1(aut.text, pattern = aut.sep)
    message("Se han identificado los siguientes autores:\n\n", paste(auts, collapse = "\n"))
  }


  if (!is.null(aut.bib)) {
    message("Extracción de autores a partir de BibTeX aún no implementado")
  }

  message("\nPegando cada autor al portapapeles cada ", pause, " segundos.")
  listo <- utils::askYesNo("\n¿Listo para comenzar a pegar autores en la aplicación de la ANECA?")

  if (isTRUE(listo)) {

    clipr::clear_clip()
    Sys.sleep(pause)

    for (i in auts) {
      Sys.sleep(pause)
      clipr::write_clip(i, object_type = "character")
    }

    clipr::clear_clip()

  }

}
