#' Convert to an HTML document
#'
#' Format for converting from R Markdown to an HTML document.
#'
#' @details
#' CSS taken from the docute project and adaptations made by John Coene.
#'
#' @param fig_width Default width (in inches) for figures
#' @param fig_height Default width (in inches) for figures
#' @param fig_caption \code{TRUE} to render figures with captions
#' @param highlight Syntax highlighting style. Supported styles include
#'   "default", "tango", "pygments", "kate", "monochrome", "espresso",
#'   "zenburn", "haddock", and "textmate". Pass \code{NULL} to prevent syntax
#'   highlighting.
#' @param lightbox if TRUE, add lightbox effect to content images
#' @param thumbnails if TRUE display content images as thumbnails
#' @param gallery if TRUE and lightbox is TRUE, add a gallery navigation between images in lightbox display
#' @param pandoc_args arguments passed to the pandoc_args argument of rmarkdown \code{\link[rmarkdown]{html_document}}
#' @param md_extensions arguments passed to the md_extensions argument of rmarkdown \code{\link[rmarkdown]{html_document}}
#' @param toc_depth adjust table of contents depth
#' @param embed_fonts if TRUE, use local files for Lato and Roboto Slab fonts used in the template. This leads to bigger files but ensures that these fonts are available.
#' @param use_bookdown if TRUE, uses \code{\link[bookdown]{html_document2}} instead of \code{\link[rmarkdown]{html_document}}, thus providing numbered sections and cross references
#' @param mathjax set to NULL to disable Mathjax insertion
#' @param ... Additional function arguments passed to R Markdown \code{\link[rmarkdown]{html_document}}
#' @return R Markdown output format to pass to \code{\link[rmarkdown]{render}}
#' @import rmarkdown
#' @import bookdown
#' @importFrom htmltools htmlDependency
#' @export


downcute <- function(fig_width = 8,
                       fig_height = 5,
                       fig_caption = TRUE,
                       highlight = NULL,
                       lightbox = FALSE,
                       thumbnails = FALSE,
                       gallery = FALSE,
                       toc_depth = 2,
                       embed_fonts = TRUE,
                       use_bookdown = FALSE,
                       pandoc_args = NULL,
                       md_extensions = NULL,
                       mathjax = "rmdformats",
                       ...) {

    html_template(
        template_name = "downcute",
        template_path = "templates/template.html",
        template_dependencies = list(
            html_dependency_downcute(embed_fonts),
            html_dependency_prism()
        ),
        pandoc_args = pandoc_args,
        fig_width = fig_width,
        fig_height = fig_height,
        fig_caption = fig_caption,
        highlight = highlight,
        lightbox = lightbox,
        thumbnails = thumbnails,
        gallery = gallery,
        toc = TRUE,
        toc_depth = toc_depth,
        use_bookdown = use_bookdown,
        md_extensions = md_extensions,
        mathjax = mathjax,
        ...
    )

}

# readthedown js and css
html_dependency_downcute <- function(embed_fonts = TRUE) {
  stylesheets <- "downcute.css"
  if (embed_fonts) {
    stylesheets <- c(stylesheets, "downcute_fonts_embed.css")
  } else {
    stylesheets <- c(stylesheets, "downcute_fonts_download.css")
  }
  htmltools::htmlDependency(name = "downcute",
                 version = "0.1",
                 src = system.file("templates/downcute", package = "rmdformats"),
                 script = "downcute.js",
                 stylesheet = stylesheets)
}

# prism js and css
html_dependency_prism <- function() {
  htmltools::htmlDependency(name = "prism",
                 version = "1.22",
                 src = system.file("templates/prism", package = "rmdformats"),
                 script = "prism.js")
}
