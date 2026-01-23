# Attach `arrow` and `geoarrow` JavaScript dependencies to a widget.

Pipe-friendly function to attach `arrow` and `geoarrow` JavaScript
dependencies to a widget created with
[`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Usage

``` r
attachGeoarrowDependencies(x)
```

## Arguments

- x:

  A widget created with
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Examples

``` r
library(listviewer)

jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
) |>
  attachGeoarrowDependencies()

{"x":{"data":["Just some dummy text"],"options":{"mode":"tree","modes":["text","tree","table"]}},"evals":[],"jsHooks":[]}
## open the resulting page in the browser and inspect the page source, e.g.
## by pressing <Ctrl + u>. You should see two lines like:

# <script src="lib/apache-arrow-js-19.0.1/Arrow.es2015.min.js"></script>
# <script src="lib/geoarrow-js-0.3.2/geoarrow.umd.min.js"></script>

## !Version numbers of the JavaScript dependencies may differ!
```
