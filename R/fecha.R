

#' Formatear fecha
#'
#' Formatear fecha en el formato requerido por la ANECA (dd/mm/yyyy).
#'
#' @param fecha Fechas en formato "yyyy-mm-dd"
#'
#' @return Fechas en formato "dd/mm/yyyy"
#' @export
#'
#' @examples
#' fechas <- c("2024-02-28", "2023-12-25")
#' fecha_formatear(fechas)
fecha_formatear <- function(fecha = NULL) {

  format(as.Date(fecha), "%d/%m/%Y")

}
