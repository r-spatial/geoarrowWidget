#' Names and versions of external JavaScript libraries.
#'
#' Names and versions of the external JavaScript libraries used in
#' `geoarrowWidget`.
#'
#' See e.g. \url{https://cdn.jsdelivr.net/npm/apache-arrow/package.json}
#' or \url{https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js/package.json} or
#' \url{https://cdn.jsdelivr.net/npm/parquet-wasm/package.json} for
#' more details on the JavaScript depencencies.
#'
#' @returns
#'   A named character vector with the versions of the `GeoArrow`, `Arrow`
#'   and `Parquet-WASM` JavaScript libraries shipped with this package.
#'
#' @examples
#'   extJSLibs()
#'
#' @tests tinytest
#' expect_length(extJSLibs(), 3)
#' expect_length(names(extJSLibs()), 3)
#'
#' @export
extJSLibs = function() {

  structure(
    c(
      .geoarrowJSDependency()[[1]]$version
      , .arrowJSDependency()[[1]]$version
      , .parquetWasmDependencies()[[1]]$version
    )
    , names = c(
      .geoarrowJSDependency()[[1]]$name
      , .arrowJSDependency()[[1]]$name
      , .parquetWasmDependencies()[[1]]$name
    )
  )

}
