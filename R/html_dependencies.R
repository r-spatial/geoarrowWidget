## arrow js ====================================================================
arrowJSDependencies = function() {
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
geoarrowJSDependencies = function() {
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

## data src ====================================================================
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
    )
  )
}
