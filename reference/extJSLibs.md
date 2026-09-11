# Names and versions of external JavaScript libraries.

Names and versions of the external JavaScript libraries used in
`geoarrowWidget`.

## Usage

``` r
extJSLibs()
```

## Value

A named character vector with the versions of the `GeoArrow`, `Arrow`,
`Parquet-WASM` and `GeoParquet-WASM` JavaScript libraries shipped with
this package.

## Details

See e.g.

- <https://cdn.jsdelivr.net/npm/apache-arrow/package.json>,

- <https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js/package.json>,

- <https://cdn.jsdelivr.net/npm/parquet-wasm/package.json>,

- <https://cdn.jsdelivr.net/npm/@geoarrow/geoparquet-wasm/package.json>

for more details on the JavaScript depencencies.

## Examples

``` r
  extJSLibs()
#>     geoarrow-js apache-arrow-js    parquet-wasm geoparquet-wasm 
#>         "0.3.3"        "21.2.0"         "0.7.2"  "0.2.0-beta.5" 
```
