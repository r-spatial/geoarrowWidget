# File created by roxut; edit the function definition file, not this file

# Test found in attachGeoArrowDependencies.R:130 (file:line)
  
library(listviewer)

wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
wgt = attachParquetWasmDependencies(wgt)

expect_length(wgt$dependencies, 3)
