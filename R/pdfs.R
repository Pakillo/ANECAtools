
#' Extraer páginas concretas de archivos PDF
#'
#' @param pdf.in Nombre del archivo (o archivos) pdf cuyas páginas se desean extraer
#' @param pags Vector numérico especificando las páginas a extraer.
#' Alternativamente, puede indicarse "ini" y/o "fin" para extraer las páginas
#' inicial y final, respectivamente (ver ejemplos).
#' @param out.dir Directorio donde guardar el archivo pdf resultante
#' @param pdf.out Nombre del fichero pdf resultante. Si no se especifica,
#' se utilizará el nombre del archivo original añadiéndole el número de las
#' páginas extraídas.
#'
#' @return Fichero pdf en disco. Además, la función devuelve las rutas a los archivos extraidos,
#' por lo que es fácil ejecutar a continuación `pdf_combinar()`.
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
#' pdf_extraer_pags(archivos)
#' }
pdf_extraer_pags <- Vectorize(function(pdf.in = NULL,
                             pags = c("ini", "fin"),
                             out.dir = "PDF_SUBSET",
                             pdf.out = NULL) {

  pags[pags == "ini"] <- 1
  pags[pags == "fin"] <- pdftools::pdf_length(pdf.in)
  pags <- unique(as.numeric(pags))

  if (!is.null(out.dir)) {
    if (!dir.exists(out.dir)) dir.create(out.dir)
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


}, vectorize.args = "pdf.in")



#' Combinar varios archivos en un único archivo PDF
#'
#' @param pdf.in Archivos PDF a combinar
#' @param pdf.out Nombre del archivo PDF resultante
#'
#' @return Archivo PDF en disco
#' @export
#'
#' @examples
#' \dontrun{
#' pdfs <- list.files("PDF_SUBSET", full.names = TRUE)
#' pdf_combinar(pdfs)
#' }
pdf_combinar <- function(pdf.in = NULL, pdf.out = "pdfs_agrupados.pdf") {

  pdftools::pdf_combine(input = pdf.in, output = pdf.out)

}


#' Comprimir archivo PDF
#'
#' @param pdf.in Nombre del archivo PDF a comprimir. Si no se especifica, aparecerá
#' un menú interactivo para elegir el archivo en disco.
#' @param pdf.out Opcional. Nombre del archivo PDF resultante. Si no se especifica,
#' se añadirá el sufijo "_comprimido" al nombre original del PDF.
#' @param calidad "baja", "media" o "alta" según el grado de compresión deseado
#' @param ... (opcional) Argumentos extra para [tools::compactPDF()]
#'
#' @return Fichero PDF comprimido en disco
#' @export
#'
pdf_comprimir <- function(pdf.in = NULL,
                          pdf.out = NULL,
                          calidad = c("baja", "media", "alta"),
                          ...) {

  calidad <- match.arg(calidad)
  if (calidad == "baja") qual <- "screen"
  if (calidad == "media") qual <- "ebook"
  if (calidad == "alta") qual <- "printer"

  if (is.null(pdf.in)) {
    pdf.in <- file.choose()
  }
  stopifnot(is.character(pdf.in) & length(pdf.in) == 1)

  if (is.null(pdf.out)) {
    pdf.out <- gsub(".pdf$", "_comprimido.pdf", x = pdf.in)
  }

  file.copy(from = pdf.in, to = pdf.out)

  tools::compactPDF(pdf.out, gs_quality = qual, ...)

}
