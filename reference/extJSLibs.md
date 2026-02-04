# Names and versions of external JavaScript libraries.

Names and versions of the external JavaScript libraries used in
`geoarrowWidget`.

## Usage

``` r
extJSLibs()
```

## Value

A named character vector with the versions of the `GeoArrow` and `Arrow`
JavaScript libraries shipped with this package.

## Details

See e.g. <https://cdn.jsdelivr.net/npm/apache-arrow/package.json> or
<https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js/package.json> for
more details on the js depencencies.

## Examples

``` r
  extJSLibs()
#>     geoarrow-js apache-arrow-js 
#>         "0.3.3"        "21.1.0" 
```
