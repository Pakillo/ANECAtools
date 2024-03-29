% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/texto.R
\name{texto_unir_lineas}
\alias{texto_unir_lineas}
\title{Unir líneas de texto en una sola}
\usage{
texto_unir_lineas(texto = NULL, mayus = NULL, locale = "en")
}
\arguments{
\item{texto}{Texto a unir en una sola línea. Si no se aporta, se leerá directamente
el contenido del portapapeles.}

\item{mayus}{Para dejar el texto tal cual, sin modificar las mayúsculas, dejar \code{mayus = NULL}.
Para cambiar todo el texto a mayúsculas, usar "mayus".
Para cambiar todo el texto a minúsculas, usar "minus".
Para poner en mayúscula sólo la primera letra de cada palabra, usar "titulo".
Para poner mayúscula sólo las primeras palabras de cada frase, usar "frase".
Véase \code{\link[=texto_mayus]{texto_mayus()}}.}

\item{locale}{Idioma del texto (inglés por defecto, locale = "en"). Para español,
usar locale = "es". Véase \code{\link[stringr:case]{stringr::str_to_sentence()}}.}
}
\value{
El texto reformateado será copiado automáticamente al portapapeles además
de mostrarse en la consola de R.
}
\description{
Esta función une varias líneas de texto en una sola. Puede ser útil, por ejemplo,
para unir texto (títulos, autores, etc) copiado de archivos pdf.
}
