library(geoarrowWidget)
library(sf)
library(colourvalues)
library(yyjsonr)
library(nanoarrow)
library(geoarrow)

### points =========================
n = 1e5
dat = data.frame(
  id = 1:n
  , x = runif(n, -160, 160)
  , y = runif(n, -40, 40)
)
dat = st_as_sf(
  dat
  , coords = c("x", "y")
  , crs = 4326
)
dat$fillColor = color_values(
  rnorm(nrow(dat))
  , alpha = sample.int(255, nrow(dat), replace = TRUE)
)
dat$lineColor = color_values(
  rnorm(nrow(dat))
  , alpha = sample.int(255, nrow(dat), replace = TRUE)
  , palette = "inferno"
)
dat$radius = sample.int(15, nrow(dat), replace = TRUE)
dat$lineWidth = sample.int(5, nrow(dat), replace = TRUE)

options(viewer = NULL)

# jsonliteWidget(dat)


## include data in page
wgt = basicWidget("data included in the page, transfered via jsonlite", data = dat)

js_code = htmlwidgets::JS(
  'function (el, x) {

        let table = document.createElement("table");
        let tr = document.createElement("tr");
        let max = 10;

        console.log(x.data);
        table.appendChild(tr);
        Object.entries(x.data).forEach(function (o) {
          var th = document.createElement("th");
          th.appendChild(document.createTextNode(o[0]));
          tr.appendChild(th);
        });
        for (i = 0; i < max; i++) {
          (tr = document.createElement("tr")), table.appendChild(tr);
          Object.entries(x.data).forEach(function (o) {
            var td = document.createElement("td");
            tr.appendChild(td);if (o[0] === "geometry") {
              td.appendChild(
                document.createTextNode(i in o[1] ? o[1][i].coordinates : "")
              )
            } else {
              td.appendChild(
                document.createTextNode(i in o[1] ? o[1][i] : "")
              )
            }
          });
        }
        document.body.appendChild(table);
  }'
)

htmlwidgets::onRender(wgt, js_code)

## attach data to page using jsonlite
fl = tempfile()
dir.create(fl)
path = file.path(
  fl
  , "test.geojson"
)
jsonlite::write_json(dat, path, dataframe = "columns", digits = 20)

wgt = basicWidget("data attached to page, written via jsonlite")

wgt$dependencies = c(
  wgt$dependencies
  # , geoarrowWidget:::arrowDependencies()
  # , geoarrowWidget:::geoarrowjsDependencies()
  , geoarrowWidget:::dataAttachment(path)
)

js_code = htmlwidgets::JS(
  'function (el, x, data) {

        let data_fl = document.getElementById(data.filename + "-1-attachment");

        fetch(data_fl.href)
          .then(response => {
            return response.json(); // NEEDS return!!!
          })
          .then(result => {
            x.data = result;

            console.log(x.data);
            let table = document.createElement("table");
            let tr = document.createElement("tr");
            let max = 10;

            table.appendChild(tr);
            Object.entries(x.data).forEach(function (o) {
              var th = document.createElement("th");
              th.appendChild(document.createTextNode(o[0]));
              tr.appendChild(th);
            });
            for (i = 0; i < max; i++) {
              (tr = document.createElement("tr")), table.appendChild(tr);
              Object.entries(x.data).forEach(function (o) {
                var td = document.createElement("td");
                tr.appendChild(td);
                if (o[0] === "geometry") {
                  td.appendChild(
                    document.createTextNode(i in o[1] ? o[1][i].coordinates : "")
                  )
                } else {
                  td.appendChild(
                    document.createTextNode(i in o[1] ? o[1][i] : "")
                  )
                }

              });
            }
            document.body.appendChild(table);
          });
  }'
)

htmlwidgets::onRender(wgt, js_code, data = list(filename = "test"))

## attach data to page using arrow
fl = tempfile()
dir.create(fl)
path = file.path(
  fl
  , "test.arrow"
)

interleaved = TRUE

data_stream = nanoarrow::as_nanoarrow_array_stream(
  dat
  , geometry_schema = geoarrow::infer_geoarrow_schema(
    dat
    , coord_type = ifelse(interleaved, "INTERLEAVED", "SEPARATE")
  )
)

nanoarrow::write_nanoarrow(data_stream, path)

wgt = basicWidget("data attached to page, written via geoarrow")

wgt$dependencies = c(
  wgt$dependencies
  , geoarrowWidget:::arrowDependencies()
  , geoarrowWidget:::geoarrowjsDependencies()
  , geoarrowWidget:::dataAttachment(path)
)

js_code = htmlwidgets::JS(
  'function (el, x, data) {

        let data_fl = document.getElementById(data.filename + "-1-attachment");

        // modified from
        // https://github.com/emilbayes/object-transpose/blob/master/index.js
        function transposeObject (data) {
          var res = []
          var key, i, k

          for (key in data) {
            for (i = 0; i < Object.keys(data[key]).length; i++) {
              res[i] = res[i] || {}
              k = Object.keys(data[key])[i];
              if (data[key][k] !== undefined) res[i][key] = data[key][k]
            }
          }

          return res
        }


        fetch(data_fl.href)
          .then(result => Arrow.tableFromIPC(result))
          .then(arrow_table => {

            console.log(arrow_table);
            let table = document.createElement("table");
            let tr = document.createElement("tr");
            let max = 10;

            let tab = JSON.parse(arrow_table.slice(0, 10).toString());

            table.appendChild(tr);
            Object.keys(tab[0]).forEach(function (o) {
              var th = document.createElement("th");
              th.appendChild(document.createTextNode(o));
              tr.appendChild(th);
            });

            let tab2 = transposeObject(
              JSON.parse(arrow_table.slice(0, 10).toString())
            );

            for (i = 0; i < max; i++) {
              (tr = document.createElement("tr")), table.appendChild(tr);
              Object.entries(tab2).forEach(function (o) {
                var td = document.createElement("td");
                tr.appendChild(td);
                td.appendChild(
                  document.createTextNode(i in o[1] ? o[1][i] : "")
                );
              });
            }

            document.body.appendChild(table);
          });
  }'
)

htmlwidgets::onRender(wgt, js_code, data = list(filename = "test"))


# ## attach data to page with yyjsonr
# fl = tempfile()
# dir.create(fl)
# path = file.path(
#   fl
#   , "test.geojson"
# )
# yyjsonr::write_json_file(
#   dat
#   , filename = path
#   , opts = opts_write_json(dataframe = "columns")
# )
#
# wgt = basicWidget("data attached to page, written via yyjsonr")
#
# wgt$dependencies = c(
#   wgt$dependencies
#   # , geoarrowWidget:::arrowDependencies()
#   # , geoarrowWidget:::geoarrowjsDependencies()
#   , geoarrowWidget:::dataAttachment(path)
# )
#
# js_code = htmlwidgets::JS(
#   'function (el, x, data) {
#
#         let data_fl = document.getElementById(data.filename + "-1-attachment");
# debugger;
#         fetch(data_fl.href)
#           .then(response => {
#             return response.json(); // NEEDS return!!!
#           })
#           .then(result => {
#             x.data = result;
#
#             console.log(x.data);
#             let table = document.createElement("table");
#             let tr = document.createElement("tr");
#             let max = 10;
#
#             table.appendChild(tr);
#             Object.entries(x.data).forEach(function (o) {
#               var th = document.createElement("th");
#               th.appendChild(document.createTextNode(o[0]));
#               tr.appendChild(th);
#             });
#             for (i = 0; i < max; i++) {
#               (tr = document.createElement("tr")), table.appendChild(tr);
#               Object.entries(x.data).forEach(function (o) {
#                 var td = document.createElement("td");
#                 tr.appendChild(td);
#                 td.appendChild(
#                   document.createTextNode(i in o[1] ? o[1][i] : "")
#                 );
#               });
#             }
#             document.body.appendChild(table);
#           });
#   }'
# )
#
# htmlwidgets::onRender(wgt, js_code, data = list(filename = "test"))
