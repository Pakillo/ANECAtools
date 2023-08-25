
#' Introducir campos de cualquier data frame
#'
#' Esta función sirve para introducir información de los distintos campos requeridos
#' en cualquier sección de la aplicación ANECA (proyectos, congresos, etc).
#' La función simplemente lee el data frame y va pegando cada campo al portapapeles.
#' Para introducir publicaciones, debe utilizarse [introducir_publicaciones()].
#' Para rellenar campos con múltiples items (p. ej. autores), puede utilizarse la
#' función [pegar_autores()].
#'
#' @param df Data frame con distintos campos a introducir en la aplicación de la ANECA.
#' Este data frame puede leerse en R p. ej.
#' a partir de un fichero CSV (usando [readr::read_csv()])
#' o un fichero Excel (usando [readxl::read_excel()]).
#' Aunque no es estrictamente necesario, idealmente el data frame debe contener
#' los mismos campos (y en el mismo orden) requeridos por la aplicación de la ANECA.
#' El nombre de las columnas puede ser diferente al de la aplicación.
#' @param pausa Tiempo (en segundos) que dura cada campo en el portapapeles
#' (para que dé tiempo a pegar cada uno en la aplicación de la ANECA)
#'
#' @return Esta función va copiando los distintos campos al portapapeles para
#' poder pegarlos en la aplicación de la ANECA.
#' @export
#'
introducir_campos <- function(df = NULL, pausa = 4) {

  stopifnot(inherits(df, "data.frame"))

  filas <- split(df, 1:nrow(df))
  lapply(filas, procesar_fila, pausa = pausa)

}






