# Attach `(Geo)Arrow` and/or `(Geo)Parquet` JavaScript dependencies to a widget.

Pipe-friendly functions to attach `(Geo)Arrow` and/or `(Geo)Parquet`
JavaScript dependencies to a widget created with
[`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Usage

``` r
attachGeoarrowDependencies(widget)

attachGeoarrowDependency(widget)

attachArrowDependency(widget)

attachParquetWasmDependencies(widget)
```

## Arguments

- widget:

  A widget created with
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Value

The `widget` including `Arrow`, `Geoarrow` and/or `parquet-wasm`
JavaScript dependencies.

## Details

Attaching the `parquet-wasm` JavaScript dependency differs from
attaching the other dependencies. In order to enable reading `.parquet`
files in the browser we declare an `async` function `parquet2arrow` at
the `window` level that can be used to read parquet data into an `Arrow`
memory table in the browser. As such, `attachParquetWasmDependencies()`
will also attach the `arrow` and `geoarrow` dependencies.

So, in the browser, we can use this as follows:

      fetch(<(geo)parquet-url>)
        .then(pq => window.parquet2arrow(pq))
        .then(arrow_table => {

         // code to work with arrow table

        });

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
