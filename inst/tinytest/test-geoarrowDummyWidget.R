# File created by roxut; edit the function definition file, not this file

# Test found in geoarrowDummyWidget.R:30 (file:line)
  
url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
wgt = geoarrowDummyWidget(url = url)

expect_length(wgt$dependencies, 3)
expect_identical(
  unlist(lapply(wgt$dependencies, "[[", "name"))
  , c("apache-arrow-js", "geoarrow-js", "mygeoarrowdata")
)
expect_true(!is.null(wgt$x$message))
expect_identical(wgt$x$dataname, "mygeoarrowdata")
