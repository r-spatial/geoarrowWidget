# Basic Widget to Showcase Things.

Widget used to highlight efficiency of geoarrow data transfer. Doesn't
do anything useful, other than attaching data to a generated
`htmlwidget` and printing that in the browser console.

## Usage

``` r
geoarrowDummyWidget(
  message,
  file,
  url,
  dataname = "mygeoarrowdata",
  width = NULL,
  height = NULL,
  elementId = NULL
)
```

## Arguments

- message:

  Some text to be displayed on the generated web page.

- file:

  A local file path to a geoarrow file to be attached to the widget.

- url:

  A URL to a geoarrow file to be attached to the widget. Ignored if
  `file` is supplied.

- dataname:

  The `'ATTACHINDEX'` to be used for the data attachment. See
  [`htmlDependency`](https://rstudio.github.io/htmltools/reference/htmlDependency.html)
  for details, especially the `Details` section on `attachment`.

- width:

  Fixed width for widget (in css units). See
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html)
  for details.

- height:

  Fixed height for widget (in css units). See
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html)
  for details.

- elementId:

  Use an explicit element ID for the widget. See
  [`createWidget`](https://rdrr.io/pkg/htmlwidgets/man/createWidget.html)
  for details.

## Value

An `htmlwidget` with the parsed geoarrow data printed to the browser
console.

## Examples

``` r
url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
wgt = geoarrowDummyWidget(url = url)
#> Error: 'htm1lDependency' is not an exported object from 'namespace:htmltools'
options(viewer = NULL)
wgt
#> Error: object 'wgt' not found
```
