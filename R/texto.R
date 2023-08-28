#' Unir líneas de texto en una sola
#'
#' Esta función une varias líneas de texto en una sola. Puede ser útil, por ejemplo,
#' para unir texto (títulos, autores, etc) copiado de archivos pdf.
#'
#' @param texto Texto a unir en una sola línea. Si no se aporta, se leerá directamente
#' el contenido del portapapeles.
#' @param mayus
#' Para dejar el texto tal cual, sin modificar las mayúsculas, dejar `mayus = NULL`.
#' Para cambiar todo el texto a mayúsculas, usar "mayus".
#' Para cambiar todo el texto a minúsculas, usar "minus".
#' Para poner en mayúscula sólo la primera letra de cada palabra, usar "titulo".
#' Para poner mayúscula sólo las primeras palabras de cada frase, usar "frase".
#' Véase [texto_mayus()].
#' @inheritParams texto_mayus
#'
#' @return El texto reformateado será copiado automáticamente al portapapeles además
#' de mostrarse en la consola de R.
#' @export
#'
texto_unir_lineas <- function(texto = NULL, mayus = NULL, locale = "en") {

  if (is.null(texto)) {
    texto <- clipr::read_clip()
  }

  texto.out <- paste(texto, collapse = " ")

  if (!is.null(mayus)) {
    texto.out <- texto_mayus(texto.out, mayus = mayus, locale = locale)
  } else {
    clipr::write_clip(texto.out, object_type = "character")
    cat(texto.out)
    invisible(texto.out)
  }


}



#' Cambiar mayúsculas de un texto
#'
#'
#' @param texto Texto a modificar. Si no se aporta, se leerá directamente
#' el contenido del portapapeles.
#' @param mayus
#' Para cambiar todo el texto a mayúsculas, usar "mayus".
#' Para cambiar todo el texto a minúsculas, usar "minus".
#' Para poner en mayúscula sólo la primera letra de cada palabra, usar "titulo".
#' Para poner mayúscula sólo las primeras palabras de cada frase, usar "frase".
#' @param locale Idioma del texto (inglés por defecto, locale = "en"). Para español,
#' usar locale = "es". Véase [stringr::str_to_sentence()].
#'
#' @return El texto reformateado será copiado automáticamente al portapapeles además
#' de mostrarse en la consola de R.
#' @export
#'
#'
texto_mayus <- function(texto = NULL,
                        mayus = c("mayus", "minus", "titulo", "frase"),
                        locale = "en") {

  mayus <- match.arg(mayus)

  if (is.null(texto)) {
    texto <- clipr::read_clip()
  }

  if (mayus == "mayus") {
    texto.out <- stringr::str_to_upper(texto, locale = locale)
  }

  if (mayus == "minus") {
    texto.out <- stringr::str_to_lower(texto, locale = locale)
  }

  if (mayus == "titulo") {
    texto.out <- stringr::str_to_title(texto, locale = locale)
  }

  if (mayus == "frase") {
    texto.out <- stringr::str_to_sentence(texto, locale = locale)
  }

  clipr::write_clip(texto.out, object_type = "character")
  cat(texto.out)
  invisible(texto.out)

}
