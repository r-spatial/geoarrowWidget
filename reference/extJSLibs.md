# Names and versions of external JavaScript libraries.

Names and versions of the external JavaScript libraries used in
`geoarrowWidget`.

## Usage

``` r
extJSLibs()
```

## Value

A named character vector with the versions of the `GeoArrow`, `Arrow`
and `Parquet-WASM` JavaScript libraries shipped with this package.

## Details

See e.g. <https://cdn.jsdelivr.net/npm/apache-arrow/package.json> or
<https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js/package.json> or
<https://cdn.jsdelivr.net/npm/parquet-wasm/package.json> for more
details on the JavaScript depencencies.

## Examples

``` r
  extJSLibs()
#>     geoarrow-js apache-arrow-js    parquet-wasm 
#>         "0.3.3"        "21.1.0"         "0.7.1" 
```
