## arrow js ====================================================================
.arrowJSDependency = function() {
  fldr = system.file("htmlwidgets/lib/apache-arrow", package = "geoarrowWidget")
  list(
    htmltools::htmlDependency(
      "apache-arrow-js"
      , readLines(file.path(fldr, "version.txt"))
      , src = c(
        # href = "https://cdn.jsdelivr.net/npm/apache-arrow@16.1.0"
        fldr
      )
      , script = "Arrow.es2015.min.js"
    )
  )
}


## geoarrow js =================================================================
.geoarrowJSDependency = function() {
  fldr = system.file("htmlwidgets/lib/geoarrow-js", package = "geoarrowWidget")
  list(
    htmltools::htmlDependency(
      "geoarrow-js"
      , readLines(file.path(fldr, "version.txt"))
      , src = c(
        # href = "https://cdn.jsdelivr.net/npm/@geoarrow/geoarrow-js@0.3.1/dist"
        fldr
      )
      , script = "geoarrow.umd.min.js"
    )
  )
}

## parquet2arrow js ============================================================
.parquet2arrowDependency = function() {
  fldr = system.file("htmlwidgets/lib/parquet-wasm", package = "geoarrowWidget")
  list(
    htmltools::htmlDependency(
      "parquet2arrow"
      , readLines(file.path(fldr, "version.txt"))
      , src = c(
        fldr
      )
      , script = list(
        src = "parquet2arrow.js"
        , type = "module"
      )
    )
  )
}

## geoparquet2arrow js =========================================================
.geoparquet2arrowDependency = function() {
  fldr = system.file("htmlwidgets/lib/geoparquet-wasm", package = "geoarrowWidget")
  list(
    htmltools::htmlDependency(
      "geoparquet2arrow"
      ## print.htmlwidgets does not like "-beta"!
      , gsub("[a-zA-Z-]*", "", readLines(file.path(fldr, "version.txt")))
      # , gsub("-beta.", ".900", readLines(file.path(fldr, "version.txt")))
      , src = c(
        fldr
      )
      , script = list(
        src = "geoparquet2arrow.js"
        , type = "module"
      )
    )
  )
}

## parquet2arrow js ============================================================
.fgb2arrowDependency = function() {
  fldr = system.file("htmlwidgets/lib/flatgeobuf-wasm", package = "geoarrowWidget")
  list(
    htmltools::htmlDependency(
      "fgb2arrow"
      , gsub("[a-zA-Z-]*", "", readLines(file.path(fldr, "version.txt")))
      , src = c(
        fldr
      )
      , script = list(
        src = "fgb2arrow.js"
        , type = "module"
      )
    )
  )
}

## data src ====================================================================
.dataAttachment = function(file, url, ...) {

  if (!missing(file)) {
    return(.fileAttachment(file, ...))
  }

  if (!missing(url)) {
    return(.urlAttachment(url, ...))
  }

  stop("need 'file' or 'url'!", call. = FALSE)
}

## file src ====================================================================
.fileAttachment = function(file, ...) {

  dflt_lst = list(
    name = tools::file_path_sans_ext(basename(file))
    , version = "0.0.1"
  )

  dot_lst = utils::modifyList(
    dflt_lst
    , list(...)
  )

  data_dir <- dirname(file)
  data_file <- basename(file)

  list(
    htmltools::htmlDependency(
      name = dot_lst[["name"]]
      , version = dot_lst[["version"]]
      , src = c("file" = data_dir)
      , attachment = c("geoarrowWidget" = data_file)
      , all_files = FALSE
    )
  )
}

## url src =====================================================================
.urlAttachment = function(url, ...) {

  dflt_lst = list(
    name = tools::file_path_sans_ext(basename(url))
    , version = "0.0.1"
  )

  dot_lst = utils::modifyList(
    dflt_lst
    , list(...)
  )

  data_dir <- dirname(url)
  data_file <- basename(url)

  list(
    htmltools::htmlDependency(
      name = dot_lst[["name"]]
      , version = dot_lst[["version"]]
      , src = c("href" = data_dir)
      , attachment = c("geoarrowWidget" = data_file)
      , all_files = FALSE
    )
  )
}
