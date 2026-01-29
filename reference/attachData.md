# Attach data to a widget.

Pipe-friendly function to attach data (any, really, not only `geoarrow`)
to a widget created with
[`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

## Usage

``` r
attachData(x, file, url, ...)
```

## Arguments

- x:

  A widget created with
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html).

- file:

  A local file path to a data file to be attached to the widget.

- url:

  A URL to a file to be attached to the widget. Ignored if `file` is
  supplied.

- ...:

  further arguments supplied to internal methods. The most relevant
  argument is `name` which can be used to set the `id` of the
  attachment. See `details` and `examples` for further explanation.

## Details

The provided data will be attached to the page created by the widget as
a `<link>`. It can then be used by some script that will `fetch` this
data from the `href`. See e.g. the
`"Use geoarrowWidget with an existing widget"` vignette of this package
for an example of how to work with this data using
[`onRender`](https://rdrr.io/pkg/htmlwidgets/man/onRender.html) or the
[source of
geoarrowDummyWidget.js](https://github.com/r-spatial/geoarrowWidget/blob/master/inst/htmlwidgets/geoarrowDummyWidget.js#L17-L30)
for another, similar example.

NOTE that the `<link>` id can be controlled by supplying a `name`
argument (via `...`). This will the be prepended to
`<name>-geoarrowWidget-attachment`. See example below, where the name
"mydata" is used to create the id "mydata-geoarrowWidget-attachment". In
case no `name` is supplied, it defaults to the file name (without
extension) that is supplied via `file` or `url`.

## Examples

``` r
library(listviewer)

wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
attachData(
  wgt
  , url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
 , name = "mydata"
)

{"x":{"data":["Just some dummy text"],"options":{"mode":"tree","modes":["text","tree","table"]}},"evals":[],"jsHooks":[]}
## open the resulting page in the browser and inspect the page source, e.g.
## by pressing <Ctrl + u>. You should see a line like (href is shortened here):

# <link id="mydata-geoarrowWidget-attachment" rel="attachment" href="https://geoarrow-test.s3...."/>
```
