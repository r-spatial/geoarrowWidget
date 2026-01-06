#' Basic Widget to Showcase Things.
#'
#' Widget used to highlight efficiency of geoarrow data transfer. Doesn't do anything
#' useful, other than attaching data to a generated `htmlwidget` and printing that
#' in the browser console.
#'
#' @param message Some text to be displayed on the generated web page.
#' @param file A local file path to a geoarrow file to be attached to the widget.
#' @param url A URL to a geoarrow file to be attached to the widget. Ignored if
#'   `file` is supplied.
#' @param dataname The `'ATTACHINDEX'` to be used for the data attachment. See
#'   \code{\link[htmltools]{htmlDependency}} for details, especially the `Details`
#'   section on `attachment`.
#' @param width Fixed width for widget (in css units).
#'   See \code{\link[htmlwidgets]{createWidget}} for details.
#' @param height Fixed height for widget (in css units).
#'   See \code{\link[htmlwidgets]{createWidget}} for details.
#' @param elementId Use an explicit element ID for the widget.
#'   See \code{\link[htmlwidgets]{createWidget}} for details.
#'
#' @examples
#' url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
#' wgt = geoarrowDummyWidget(url = url)
#' options(viewer = NULL)
#' wgt
#'
#'
#' @import htmlwidgets
#'
#' @export
geoarrowDummyWidget <- function(
    message
    , file
    , url
    , dataname = "mygeoarrowdata"
    , width = NULL
    , height = NULL
    , elementId = NULL
) {

  default_message = "
    Congratulations! You've rendered geoarrowDummyWidget in the browser!
    To see the geoarrow data, open the web developer tools (e.g. by pressing F12) and navigate to 'Console'.
    There you should see your data, which should look something like this:

    > Object { schema: {...}, batches: (1) [...], j: Uint32Array(2) }
  "

  if (missing(message)) {
    message = default_message
  }

  # forward options using x
  x = list(
    message = message
    , dataname = dataname
  )

  # create widget
  wgt = htmlwidgets::createWidget(
    name = 'geoarrowDummyWidget',
    x,
    width = width,
    height = height,
    package = 'geoarrowWidget',
    elementId = elementId
  )

  wgt$dependencies = c(
    wgt$dependencies
    , arrowJSDependencies()
    , geoarrowJSDependencies()
    , .dataAttachment(
      file = file
      , url = url
      , name = dataname
    )
  )

  return(wgt)

}

# #' Shiny bindings for geoarrowDummyWidget
# #'
# #' Output and render functions for using geoarrowDummyWidget within Shiny
# #' applications and interactive Rmd documents.
# #'
# #' @param outputId output variable to read from
# #' @param width,height Must be a valid CSS unit (like \code{'100\%'},
# #'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
# #'   string and have \code{'px'} appended.
# #' @param expr An expression that generates a geoarrowDummyWidget
# #' @param env The environment in which to evaluate \code{expr}.
# #' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
# #'   is useful if you want to save an expression in a variable.
# #'
# #' @name geoarrowDummyWidget-shiny
# #'
# #' @export
# geoarrowDummyWidgetOutput <- function(outputId, width = '100%', height = '400px'){
#   htmlwidgets::shinyWidgetOutput(outputId, 'geoarrowDummyWidget', width, height, package = 'geoarrowWidget')
# }
#
# #' @rdname geoarrowDummyWidget-shiny
# #' @export
# rendergeoarrowDummyWidget <- function(expr, env = parent.frame(), quoted = FALSE) {
#   if (!quoted) { expr <- substitute(expr) } # force quoted
#   htmlwidgets::shinyRenderWidget(expr, geoarrowDummyWidgetOutput, env, quoted = TRUE)
# }
