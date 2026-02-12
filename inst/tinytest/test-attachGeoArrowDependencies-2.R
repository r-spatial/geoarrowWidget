# File created by roxut; edit the function definition file, not this file

# Test found in attachGeoArrowDependencies.R:85 (file:line)
  
library(listviewer)

wgt = jsonedit(
  list("Just some dummy text")
  , elementId = "lv-example"
)
wgt = attachArrowDependency(wgt)

expect_length(wgt$dependencies, 1)
