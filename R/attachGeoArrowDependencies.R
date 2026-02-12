#' Attach `(Geo)Arrow` and/or `(Geo)Parquet` JavaScript dependencies to a widget.
#'
#' Pipe-friendly functions to attach `(Geo)Arrow` and/or `(Geo)Parquet`
#' JavaScript dependencies to a widget created with
#' \code{\link[htmlwidgets]{createWidget}}.
#'
#' @param widget A widget created with \code{\link[htmlwidgets]{createWidget}}.
#'
#' @returns
#'   The `widget` including `Arrow`, `Geoarrow` and/or `parquet-wasm`
#'   JavaScript dependencies.
#'
#' @examples
#' library(listviewer)
#'
#' wgt = jsonedit(
#'   list("Just some dummy text")
#'   , elementId = "lv-example"
#' )
#' attachGeoarrowDependencies(wgt)
#'
#' ## open the resulting page in the browser and inspect the page source, e.g.
#' ## by pressing <Ctrl + u>. You should see two lines like:
#'
#' # <script src="lib/apache-arrow-js-19.0.1/Arrow.es2015.min.js"></script>
#' # <script src="lib/geoarrow-js-0.3.2/geoarrow.umd.min.js"></script>
#'
#' ## !Version numbers of the JavaScript dependencies may differ!
#'
#' @tests tinytest
#' library(listviewer)
#'
#' wgt = jsonedit(
#'   list("Just some dummy text")
#'   , elementId = "lv-example"
#' )
#' wgt = attachGeoarrowDependencies(wgt)
#'
#' expect_length(wgt$dependencies, 2)
#'
#' @import listviewer
#'
#' @rdname attachGeoarrowDependencies
#'
#' @export
attachGeoarrowDependencies = function(widget) {

  widget$dependencies = c(
    widget$dependencies
    , .arrowJSDependency()
    , .geoarrowJSDependency()
  )

  return(widget)

}


#' @tests tinytest
#' library(listviewer)
#'
#' wgt = jsonedit(
#'   list("Just some dummy text")
#'   , elementId = "lv-example"
#' )
#' wgt = attachGeoarrowDependency(wgt)
#'
#' expect_length(wgt$dependencies, 1)
#'
#' @rdname attachGeoarrowDependencies
#'
#' @export
attachGeoarrowDependency = function(widget) {

  widget$dependencies = c(
    widget$dependencies
    , .geoarrowJSDependency()
  )

  return(widget)

}


#' @tests tinytest
#' library(listviewer)
#'
#' wgt = jsonedit(
#'   list("Just some dummy text")
#'   , elementId = "lv-example"
#' )
#' wgt = attachArrowDependency(wgt)
#'
#' expect_length(wgt$dependencies, 1)
#'
#' @rdname attachGeoarrowDependencies
#'
#' @export
attachArrowDependency = function(widget) {

  widget$dependencies = c(
    widget$dependencies
    , .arrowJSDependency()
  )

  return(widget)

}

#' @details
#' Attaching the `parquet-wasm` JavaScript dependency differs from attaching
#' the other dependencies. In order to enable reading `.parquet` files in the
#' browser we declare an `async` function `parquet2arrow` at the `window` level
#' that can be used to read parquet data into an `Arrow` memory table in the
#' browser. As such, `attachParquetWasmDependencies()` will also attach the
#' `arrow` and `geoarrow` dependencies.
#'
#' So, in the browser, we can use this as follows:
#'
#' ```
#'   fetch(<(geo)parquet-url>)
#'     .then(pq => window.parquet2arrow(pq))
#'     .then(arrow_table => {
#'
#'      // code to work with arrow table
#'
#'     });
#' ```
#'
#' @tests tinytest
#' library(listviewer)
#'
#' wgt = jsonedit(
#'   list("Just some dummy text")
#'   , elementId = "lv-example"
#' )
#' wgt = attachParquetWasmDependencies(wgt)
#'
#' expect_length(wgt$dependencies, 3)
#'
#' @rdname attachGeoarrowDependencies
#'
#' @export
attachParquetWasmDependencies = function(widget) {

  widget$dependencies = c(
    widget$dependencies
    # , .parquetWasmDependencies()
    , .parquet2arrowDependencies()
    , .arrowJSDependency()
    , .geoarrowJSDependency()
  )

  return(widget)

}
