# File created by roxut; edit the function definition file, not this file

# Test found in attachGeoArrowDependencies.R:226 (file:line)
  
library(listviewer)

wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
wgt = attachFlatgeobufWasmDependencies(wgt)

expect_length(wgt$dependencies, 3)
