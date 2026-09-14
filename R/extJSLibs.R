#' Names and versions of external JavaScript libraries.
#'
#' Names and versions of the external JavaScript libraries used in
#' `geoarrowWidget`.
#'
#' See e.g.
#'
#' * \url{https://cdn.jsdelivr.net/npm/apache-arrow/package.json},
#' * \url{https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js/package.json},
#' * \url{https://cdn.jsdelivr.net/npm/parquet-wasm/package.json},
#' * \url{https://cdn.jsdelivr.net/npm/@geoarrow/geoparquet-wasm/package.json}
#'
#' for more details on the JavaScript depencencies.
#'
#' @returns
#'   A named character vector with the versions of the `geoarrow`, `arrow`,
#'   `parquet-wasm`, `geoparquet-wasm` & `flatgeobuf-wasm` JavaScript libraries
#'   shipped with this package.
#'
#' @examples
#'   extJSLibs()
#'
#' @tests tinytest
#' expect_length(extJSLibs(), 5)
#' expect_length(names(extJSLibs()), 5)
#'
#' @export
extJSLibs = function() {

  structure(
    c(
      .geoarrowJSDependency()[[1]]$version
      , .arrowJSDependency()[[1]]$version
      , readLines(
        file.path(
          system.file(
            "htmlwidgets/lib/parquet-wasm"
            , package = "geoarrowWidget"
          )
          , "version.txt"
        )
      )
      , readLines(
        file.path(
          system.file(
            "htmlwidgets/lib/geoparquet-wasm"
            , package = "geoarrowWidget"
          )
          , "version.txt"
        )
      )
      , readLines(
        file.path(
          system.file(
            "htmlwidgets/lib/flatgeobuf-wasm"
            , package = "geoarrowWidget"
          )
          , "version.txt"
        )
      )
    )
    , names = c(
      .geoarrowJSDependency()[[1]]$name
      , .arrowJSDependency()[[1]]$name
      , "parquet-wasm"
      , "geoparquet-wasm"
      , "flatgeobuf-wasm"
    )
  )

}
