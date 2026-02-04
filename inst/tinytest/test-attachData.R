# File created by roxut; edit the function definition file, not this file

# Test found in attachData.R:54 (file:line)
  
library(listviewer)

url = "https://geoarrow-test.s3.eu-central-1.amazonaws.com/test_layer_interleaved.arrow"
wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
wgt = attachData(
  wgt
  , url = url
 , name = "mydata"
)

expect_equal(
  wgt$dependencies[[1]]$name
  , "mydata"
)
expect_equal(
  wgt$dependencies[[1]]$src$href
  , dirname(url)
)
expect_equal(
  unname(wgt$dependencies[[1]]$attachment)
  , basename(url)
)
expect_true(
  hasName(wgt$dependencies[[1]]$attachment, "geoarrowWidget")
)
