#' Unir líneas de texto en una sola
#'
#' Esta función une varias líneas de texto en una sola. Puede ser útil, por ejemplo,
#' para unir texto (títulos, autores, etc) copiado de archivos pdf.
#'
#' @param texto Texto a unir en una sola línea. Si no se aporta, se leerá directamente
#' el contenido del portapapeles.
#' @param mayus ¿Convertir todos los caracteres a mayúsculas (TRUE) o dejarlos tal cual (FALSE)?
#'
#' @return El texto reformateado será copiado automáticamente al portapapeles además
#' de mostrarse en la consola de R.
#' @export
#'
texto_unir_lineas <- function(texto = NULL, mayus = FALSE) {

  if (is.null(texto)) {
    texto <- clipr::read_clip()
  }

  texto.out <- paste(texto, collapse = " ")
  if (isTRUE(mayus)) {
    texto.out <- toupper(texto.out)
  }
  clipr::write_clip(texto.out, object_type = "character")
  cat(texto.out)
  invisible(texto.out)
}
