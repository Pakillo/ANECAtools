% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/autores.R
\name{extraer_autores}
\alias{extraer_autores}
\title{Extraer autores}
\usage{
extraer_autores(aut.text = NULL, aut.sep = "; ", mayus = TRUE)
}
\arguments{
\item{aut.text}{Cadena de texto conteniendo el nombre de uno o varios autores}

\item{aut.sep}{Caracter(es) que separa cada autor en \code{aut.text}}

\item{mayus}{¿Poner todos los caracteres en mayúsculas (TRUE) o dejarlos tal cual (FALSE)?}
}
\value{
Vector con los nombres de los autores
}
\description{
Extraer autores
}
\examples{
\dontrun{
extraer_autores("Quintero, Elena; Rodriguez-Sanchez, Francisco; Jordano, Pedro")
}
}
