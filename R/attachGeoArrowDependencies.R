#' Attach `Arrow` and `Geoarrow` JavaScript dependencies to a widget.
#'
#' Pipe-friendly functions to attach `Arrow` and `Geoarrow` JavaScript dependencies
#' to a widget created with \code{\link[htmlwidgets]{createWidget}}.
#'
#' @param x A widget created with \code{\link[htmlwidgets]{createWidget}}.
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
attachGeoarrowDependencies = function(x) {

  x$dependencies = c(
    x$dependencies
    , .arrowJSDependency()
    , .geoarrowJSDependency()
  )

  return(x)

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
attachGeoarrowDependency = function(x) {

  x$dependencies = c(
    x$dependencies
    , .geoarrowJSDependency()
  )

  return(x)

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
attachArrowDependency = function(x) {

  x$dependencies = c(
    x$dependencies
    , .arrowJSDependency()
  )

  return(x)

}
