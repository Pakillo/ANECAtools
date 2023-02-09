
#' Extraer páginas concretas de archivos PDF
#'
#' @param pdf.in Nombre del archivo pdf cuyas páginas se desean extraer
#' @param pags Vector numérico especificando las páginas a extraer.
#' Alternativamente, puede indicarse "ini" y/o "fin" para extraer las páginas
#' inicial y final, respectivamente (ver ejemplos).
#' @param out.dir Directorio donde guardar el archivo pdf resultante
#' @param pdf.out Nombre del fichero pdf resultante. Si no se especifica,
#' se utilizará el nombre del archivo original añadiéndole el número de las
#' páginas extraídas.
#'
#' @return Fichero pdf en disco
#' @export
#'
#' @examples
#' \dontrun{
#' pdf_extraer_pags("articulo.pdf")  # extrae página inicial y final por defecto
#' pdf_extraer_pags("articulo.pdf", pags = "ini")  # extrae solo página inicial
#' pdf_extraer_pags("articulo.pdf", pags = "fin")  # extrae solo página final
#' pdf_extraer_pags("articulo.pdf", pags = c(1, 2, 8))  # extrae páginas 1, 2 y 8
#'
#' ## Extraer página inicial y final de muchos pdf a la vez
#' archivos <- list.files("carpetapdfs", full.names = TRUE)
#' lapply(archivos, pdf_extraer_pags)
#' }
pdf_extraer_pags <- function(pdf.in = NULL,
                             pags = c("ini", "fin"),
                             out.dir = "PDF_SUBSET",
                             pdf.out = NULL) {

  pags[pags == "ini"] <- 1
  pags[pags == "fin"] <- pdftools::pdf_length(pdf.in)
  pags <- as.numeric(pags)

  if (!is.null(out.dir)) {
    dir.create(out.dir)
    out.dir <- paste0(out.dir, "/")
  }

  if (is.null(pdf.out)) {
    outfile <- paste0(out.dir,
                      gsub(".pdf", "", basename(pdf.in)),
                      "_pags", paste0(pags, collapse = "-"),
                      ".pdf")
  } else {
    outfile <- paste0(out.dir, pdf.out, ".pdf")
  }

  pdftools::pdf_subset(input = pdf.in, pages = pags, output = outfile)


}



#' Combinar varios archivos en un único archivo PDF
#'
#' @param archivos Archivos PDF a combinar
#' @param pdf.out Nombre del archivo PDF resultante
#'
#' @return Archivo PDF en disco
#' @export
#'
pdf_combinar <- function(archivos = NULL, pdf.out = "pdfs_agrupados.pdf") {

  pdftools::pdf_combine(input = archivos, output = pdf.out)

}