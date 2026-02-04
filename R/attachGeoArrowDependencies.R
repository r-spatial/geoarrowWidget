#' Attach `Arrow` and `Geoarrow` JavaScript dependencies to a widget.
#'
#' Pipe-friendly functions to attach `Arrow` and `Geoarrow` JavaScript dependencies
#' to a widget created with \code{\link[htmlwidgets]{createWidget}}.
#'
#' @param widget A widget created with \code{\link[htmlwidgets]{createWidget}}.
#'
#' @returns
#'   The `widget` including `Arrow` and/or `Geoarrow` JavaScript dependencies.
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
