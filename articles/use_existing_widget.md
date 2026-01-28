# Use geoarrowWidget with an existing widget

A general usage pattern of `geoarrowWidget` is to enable attaching data
to an existing widget and then using some JavaScript to update/extend
the functionality of the existing widget.

## Using {listviewer} to examine a (geo)arrow file

As an example, we will use
[`listviewer::jsonedit()`](https://rdrr.io/pkg/listviewer/man/jsonedit.html)
to examine a (geo)arrow file.

First, we create some spatial data from scratch:

``` r
library(geoarrowWidget)
library(nanoarrow)
library(geoarrow)
library(listviewer)
library(wk)
library(htmlwidgets)

### generate some random wk points data ========================================
n = 1e2
dat = data.frame(
  id = 1:n
  , fillColor = hcl.colors(n)
  , radius = sample.int(15, n, replace = TRUE)
  , geom = xy(
    x = runif(n, -160, 160)
    , y = runif(n, -40, 40)
    , crs = wk_crs_projjson("EPSG:4326")
  )
)
```

Then, we convert to and save the data as a (geo)arrow file:

Note, we need to explicitly infer the geoarrow schema, so that the
geometry is properly handled, especially the geometry encoding and the
crs.

``` r
fl = tempfile()
dir.create(fl)
path = file.path(
  fl
  , "test.arrow"
)

interleaved = TRUE

data_stream = as_nanoarrow_array_stream(
  dat
  , geometry_schema = infer_geoarrow_schema(
    dat
    , coord_type = ifelse(interleaved, "INTERLEAVED", "SEPARATE")
  )
  , schema = infer_nanoarrow_schema(dat)
)

data_stream$get_schema()
```

    <nanoarrow_schema struct>
     $ format    : chr "+s"
     $ name      : chr ""
     $ metadata  : list()
     $ flags     : int 0
     $ children  :List of 4
      ..$ id       :<nanoarrow_schema int32>
      .. ..$ format    : chr "i"
      .. ..$ name      : chr "id"
      .. ..$ metadata  : list()
      .. ..$ flags     : int 2
      .. ..$ children  : list()
      .. ..$ dictionary: NULL
      ..$ fillColor:<nanoarrow_schema string>
      .. ..$ format    : chr "u"
      .. ..$ name      : chr "fillColor"
      .. ..$ metadata  : list()
      .. ..$ flags     : int 2
      .. ..$ children  : list()
      .. ..$ dictionary: NULL
      ..$ radius   :<nanoarrow_schema int32>
      .. ..$ format    : chr "i"
      .. ..$ name      : chr "radius"
      .. ..$ metadata  : list()
      .. ..$ flags     : int 2
      .. ..$ children  : list()
      .. ..$ dictionary: NULL
      ..$ geom     :<nanoarrow_schema geoarrow.point{struct}>
      .. ..$ format    : chr "+s"
      .. ..$ name      : chr "geom"
      .. ..$ metadata  :List of 2
      .. .. ..$ ARROW:extension:name    : chr "geoarrow.point"
      .. .. ..$ ARROW:extension:metadata: chr "{\"crs\":{\"$schema\":\"https://proj.org/schemas/v0.7/projjson.schema.json\",\"type\":\"GeographicCRS\",\"name\"| __truncated__
      .. ..$ flags     : int 2
      .. ..$ children  :List of 2
      .. .. ..$ x:<nanoarrow_schema double>
      .. .. .. ..$ format    : chr "g"
      .. .. .. ..$ name      : chr "x"
      .. .. .. ..$ metadata  : list()
      .. .. .. ..$ flags     : int 0
      .. .. .. ..$ children  : list()
      .. .. .. ..$ dictionary: NULL
      .. .. ..$ y:<nanoarrow_schema double>
      .. .. .. ..$ format    : chr "g"
      .. .. .. ..$ name      : chr "y"
      .. .. .. ..$ metadata  : list()
      .. .. .. ..$ flags     : int 0
      .. .. .. ..$ children  : list()
      .. .. .. ..$ dictionary: NULL
      .. ..$ dictionary: NULL
     $ dictionary: NULL

``` r
write_nanoarrow(data_stream, path)
```

Next, we create an empty listviewer widget and attach the relevant
JavaScript libraries and the geoarrow file. We explicitly name the
widget via the `elementId` so that we can find the widget in the
document and subsequently modify it.

``` r
wgt = jsonedit(listdata = list(""), elementId = "lv-example")
wgt = attachGeoarrowDependencies(x = wgt)
wgt = attachData(x = wgt, file = path, name = "mydata")
```

Finally, we specify the JavaScript code that handles the population of
the created JsonEditor in the browser with our geoarrow data and render
the widget.

``` r
js_code = htmlwidgets::JS(
  'function (el, x, data) {

        // find data attachment in document
        
        let attachment = document.getElementById(data.name + "-geoarrowWidget-attachment");
        
        // find listviewer jsonedit element in document and delete current contents
        
        let jse = document.getElementById("lv-example");
        jse.innerHTML = null;

        // load data from attachment into jsonedit element identified and emptied earlier
        // metadata parsing from here:
        // https://www.geeksforgeeks.org/javascript/how-to-convert-map-to-json-in-javascript/
        
        fetch(attachment.href)
          .then(result => Arrow.tableFromIPC(result))
          .then(arrow_table => {
          
            let newed = new JSONEditor.JSONEditor({
              target: jse, 
              props: {
                content: {
                  json: [{
                    "geoarrow table": JSON.parse(JSON.stringify(arrow_table)),
                    "geoarrow metadata": JSON.parse(JSON.stringify(Object.fromEntries(arrow_table.schema.fields[3].metadata)))
                  }]
                }
              }
            });
            debugger;
            console.log(arrow_table);

          });
  }'
)

onRender(wgt, js_code, data = list(name = "mydata"))
```

This now nearly looks like the data is defined in JavaScript, but not
quite… If you open the browser console and inspect and compare the
console log of the `arrow_table`, you’ll see that e.g. it carries the
CRS metatdata which is lost in the `geoarrow table` in the JSONEditor.
This is why we parse it separately as `geoarrow metadata`.

In this (somewhat convoluted) structure, the actual data values can be
found at e.g. for the `radius` column:

`[]` \> `0` \> `geoarrow table` \> `batches` \> `0` \> `data` \>
`children` \> `2` \> `values`

The geometry column (child 3) has 2 children itself, so that access to
the longitude coordinates is:

`[]` \> `0` \> `geoarrow table` \> `batches` \> `0` \> `data` \>
`children` \> `3` \> `children` \> `0` \> `values`

Note, that the hex representation of the `fillColor` column (child 1) is
internally converted to some numerical representation, which is why it
has 700 values instead of just 100.
