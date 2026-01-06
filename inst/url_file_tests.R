library(geoarrowWidget)
library(sf)
library(colourvalues)
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

## attach data to page using arrow
fl = tempfile()
dir.create(fl)
# fl = "/home/tim/tappelhans/privat/temp"
path = file.path(
  fl
  , "test.arrow"
)

interleaved = TRUE

# lst = list(
#   dat[1:50000, ]
#   , dat[50001:100000, ]
# )
#
# chunked_array(c(lst[[1]], lst[[2]]), type = infer_type(lst[[1]]))

# data_stream = geoarrow_handle(
#   dat
#   , geoarrow_writer(
#     schema = geoarrow::infer_geoarrow_schema(
#       dat
#       , coord_type = ifelse(interleaved, "INTERLEAVED", "SEPARATE")
#     )
#   )
#   , size = 5
# )

data_stream = nanoarrow::as_nanoarrow_array_stream(
  dat
  , geometry_schema = geoarrow::infer_geoarrow_schema(
    dat
    , coord_type = ifelse(interleaved, "INTERLEAVED", "SEPARATE")
  )
)

nanoarrow::write_nanoarrow(data_stream, path)

wgt = geoarrowDummyWidget(file = path, elementId = "123-456")

options(viewer = NULL)

wgt

wgt = geoarrowDummyWidget(url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow")

wgt



# wgt$dependencies = c(
#   wgt$dependencies
#   , geoarrowWidget:::arrowJSDependencies()
#   , geoarrowWidget:::geoarrowJSDependencies()
#   , geoarrowWidget:::.dataAttachment(
#     file = path
#     , name = "mydata"
#   )
#   # , geoarrowWidget:::.dataAttachment(
#   #   url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
#   #   , name = "mydata"
#   # )
# )
#
# js_code = htmlwidgets::JS(
#   'function (el, x, data) {
#
#         let data_fl = document.getElementById(data.id + "-geoarrowWidget-attachment");
#
#         fetch(data_fl.href)
#           .then(result => Arrow.tableFromIPC(result))
#           .then(arrow_table => {
#
#             //debugger;
#             console.log(arrow_table);
#
#           });
#   }'
# )
#
#
# htmlwidgets::onRender(wgt, js_code, data = list(id = "mydata"))
#
