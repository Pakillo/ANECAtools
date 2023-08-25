
#' Introducir publicaciones
#'
#' @param bibfile Ruta al archivo BibTeX (caracter)
#' @param mayus ¿Poner todos los caracteres en mayúsculas (TRUE) o dejarlos tal cual (FALSE)?
#' @param pausa Tiempo (en segundos) que dura el nombre de cada autor en el portapapeles
#' (para que dé tiempo a pegar cada uno en la aplicación de la ANECA)
#'
#' @return Esta función va copiando los distintos campos (autores, título, revista, etc)
#' al portapapeles para poder pegarlos en la aplicación de la ANECA.
#' @export
#'
#' @seealso [extraer_autores()] [pegar_autores()]
#'
#' @examples
#' \dontrun{
#' bibfile <- system.file("extdata", "articulo.bib", package = "ANECAtools")
#' introducir_publicaciones(bibfile)
#' }
introducir_publicaciones <- function(bibfile = NULL, mayus = TRUE, pausa = 4) {

  stopifnot(is.character(bibfile))
  bib <- suppressWarnings(bib2df::bib2df(bibfile))
  if (!is.data.frame(bib)) stop("La importacion del BibTeX ha fallado.")

  pubs <- split(bib, 1:nrow(bib))
  lapply(pubs, procesar_publicacion, mayus = mayus, pausa = pausa)

}



procesar_publicacion <- function(bib = NULL, mayus = TRUE, pausa = 4) {

  procesar <- utils::askYesNo(paste0("Quieres procesar '", bib$TITLE, "'?"))

  if (isTRUE(procesar)) {

    ## Autores
    auts <- unlist(bib$AUTHOR)
    if (isTRUE(mayus)) auts <- toupper(auts)
    message("Se han identificado ", length(auts), " autores:\n\n")
    print(data.frame(Nombre = auts))

    pegar.auts <- utils::askYesNo("?Quieres ir copiando los autores al portapapeles?")
    if (isTRUE(pegar.auts)) {
      pegar_autores(auts, pausa = pausa)
    }

    ## Dar opcion de repetir si ha habido algun fallo
    repetir.auts <- utils::askYesNo("?Necesitas repetir el copiado de autores al portapapeles?")
    if (isTRUE(repetir.auts)) {
      pegar_autores(auts, pausa = pausa)
    }


    ## Titulo
    readline("Copiando TITULO al portapapeles (pulsa intro para continuar)")
    if (isTRUE(mayus)) message(toupper(bib$TITLE)) else message(bib$TITLE)
    pegar_texto(bib$TITLE, mayus = mayus)


    ## Revista/Libro
    if (bib$CATEGORY == "INCOLLECTION") {
      readline("Copiando TITULO DEL LIBRO al portapapeles (pulsa intro para continuar)")
      if (isTRUE(mayus)) message(toupper(bib$BOOKTITLE)) else message(bib$BOOKTITLE)
      pegar_texto(bib$BOOKTITLE, mayus = mayus)
    } else {
      readline("Copiando REVISTA al portapapeles (pulsa intro para continuar)")
      if (isTRUE(mayus)) message(toupper(bib$JOURNAL)) else message(bib$JOURNAL)
      pegar_texto(bib$JOURNAL, mayus = mayus)
    }



    ## Volumen
    readline("Copiando VOLUMEN al portapapeles (pulsa intro para continuar)")
    message(bib$VOLUME)
    pegar_texto(bib$VOLUME)


    ## Paginas
    pages <- unlist(strsplit(bib$PAGES, "--"))

    readline("Copiando PAGINA DE INICIO al portapapeles (pulsa intro para continuar)")
    message(pages[1])
    pegar_texto(pages[1])

    if (length(pages) > 1) {
      readline("Copiando PAGINA DE FIN al portapapeles (pulsa intro para continuar)")
      message(pages[2])
      pegar_texto(pages[2])
    }



    ## Editorial
    if (!is.na(bib$PUBLISHER)) {
      readline("Copiando EDITORIAL al portapapeles (pulsa intro para continuar)")
      if (isTRUE(mayus)) message(toupper(bib$PUBLISHER)) else message(bib$PUBLISHER)
      pegar_texto(bib$PUBLISHER)
    }


    ## Year
    readline("Copiando ANYO al portapapeles (pulsa intro para continuar)")
    message(bib$YEAR)
    pegar_texto(bib$YEAR)

    ## ISSN/ISBN
    if (bib$CATEGORY == "INCOLLECTION" | bib$CATEGORY == "BOOK" ) {
      readline("Copiando ISBN al portapapeles (pulsa intro para continuar)")
      message(bib$ISBN)
      pegar_texto(bib$ISBN)
    } else {
      readline("Copiando ISSN al portapapeles (pulsa intro para continuar)")
      message(bib$ISSN)
      pegar_texto(bib$ISSN)
    }


    message("Listo! ----------------------------------------------------")

  } else {
    message("Ok!")
  }

}
