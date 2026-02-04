# Attach `Arrow` and `Geoarrow` JavaScript dependencies to a widget.

Pipe-friendly functions to attach `Arrow` and `Geoarrow` JavaScript
dependencies to a widget created with
[`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Usage

``` r
attachGeoarrowDependencies(widget)

attachGeoarrowDependency(widget)

attachArrowDependency(widget)
```

## Arguments

- widget:

  A widget created with
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Value

The `widget` including `Arrow` and/or `Geoarrow` JavaScript
dependencies.

## Examples

``` r
library(listviewer)

wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
attachGeoarrowDependencies(wgt)

{"x":{"data":["Just some dummy text"],"options":{"mode":"tree","modes":["text","tree","table"]}},"evals":[],"jsHooks":[]}
## open the resulting page in the browser and inspect the page source, e.g.
## by pressing <Ctrl + u>. You should see two lines like:

# <script src="lib/apache-arrow-js-19.0.1/Arrow.es2015.min.js"></script>
# <script src="lib/geoarrow-js-0.3.2/geoarrow.umd.min.js"></script>

## !Version numbers of the JavaScript dependencies may differ!
```
