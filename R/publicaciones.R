
#' Introducir publicaciones
#'
#' @param bibfile Ruta al archivo BibTeX (caracter)
#' @param mayus Poner todos los caracteres en mayusculas (TRUE) o dejarlos tal cual (FALSE)?
#' @param pausa Tiempo (en segundos) que dura el nombre de cada autor en el portapapeles
#' (para que de tiempo a pegar cada uno en la aplicacion de la ANECA)
#'
#' @return Esta funcion va copiando los distintos campos al portapapeles para
#' poder pegarlos en la aplicacion de la ANECA.
#' @export
#'
#' @examples
introducir_publicaciones <- function(bibfile = NULL, mayus = TRUE, pausa = 3) {

  stopifnot(is.character(bibfile))
  bib <- bib2df::bib2df(bibfile)
  if (!is.data.frame(bib)) stop("La importacion del BibTeX ha fallado.")

  pubs <- split(bib, 1:nrow(bib))
  lapply(pubs, procesar_publicacion, mayus = mayus, pausa = pausa)

}



procesar_publicacion <- function(bib = NULL, mayus = TRUE, pausa = 3) {

  message("Procesando '", bib$TITLE, "'...")

  ## Autores
  auts <- unlist(bib$AUTHOR)
  if (isTRUE(mayus)) auts <- toupper(auts)
  message("Se han identificado ", length(auts), " autores:\n\n", paste(auts, collapse = "\n"))

  pegar.auts <- utils::askYesNo("Quieres ir copiando los autores al portapapeles?")
  if (isTRUE(pegar.auts)) {
    pegar_autores(auts, pausa = pausa)
  }

  ## Titulo
  utils::askYesNo("Copiando Titulo al portapapeles")
  pegar_texto(bib$TITLE, mayus = mayus)


  ## Revista
  utils::askYesNo("Copiando Revista al portapapeles")
  pegar_texto(bib$JOURNAL, mayus = mayus)


  ## Volumen
  utils::askYesNo("Copiando Volumen al portapapeles")
  pegar_texto(bib$VOLUME)


  ## Paginas
  pages <- unlist(strsplit(bib$PAGES, "--"))

  utils::askYesNo("Copiando Pagina de inicio al portapapeles")
  pegar_texto(pages[1])

  if (length(pages) > 1) {
    utils::askYesNo("Copiando Pagina de fin al portapapeles")
    pegar_texto(pages[2])
  }



  ## Editorial
  if (!is.na(bib$PUBLISHER)) {
    utils::askYesNo("Copiando Editorial al portapapeles")
    pegar_texto(bib$PUBLISHER)
  }


  ## Year
  utils::askYesNo("Copiando Anyo al portapapeles")
  pegar_texto(bib$YEAR)

  ## ISSN
  utils::askYesNo("Copiando ISSN al portapapeles")
  pegar_texto(bib$ISSN)

  message("Listo! ----------------------------------------------------")

}
