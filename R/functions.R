
#' Create a HSA key map
#'
#' @return A map of Maine HSA with names overlayed
#' @export
#'
#' @examples
#' maine_hsa_key_map()
maine_hsa_key_map <- function(){
  require(tmap)
  hsa <- me_hsa

# names(me_hsa@data)
# hsa$hsaname

  tm_shape(me_bndry) +
    tm_fill(col = "grey30") +
    tm_borders(col = "grey10", lwd = 0) +
    tm_shape(hsa) +
    tm_fill(col = "grey60") +
    tm_borders(col = "grey10", lwd = 1) +
    tm_text(text = "hsaname", size = 0.6, col = "white") +
    tm_layout(bg.color = "grey10")
}




bfs <- read.csv()
hsa_sp <- merge(hsa_sp, bfs, by = "hsanum")

names(hsa_sp@data)




# Map rates
library(tmap)
library(RColorBrewer)
pal <- brewer.pal(6, "Blues")[2:6]
# display.brewer.pal(6, "Blues")

# spdf <- hsa_sp
# names(hsa_sp@data) %>% sort()
# mapvar <- "obese_rate"
# sort(v)
# breaks <- seq(15,40,5)


me_hsa@data

me_cntys@data %>% head

guess_geography <- function(df){
  # pull columns that match
  df %>%
    select(matches("c.*ty|hsa|zip")) %>%
    map()
    gather("var","val") %>%


}




maine_map <- function(df, geography, map_var, merge_var, pal, legend.title, breaks){




  v <- spdf@data[ , mapvar]
  if(class(breaks) != "numeric"){
    int <- classInt::classIntervals(v, style = "quantile", n = 5, dataPrecision = 3)
    brks <- round(int$brks, 1)
  } else {
    brks <- breaks
  }

  legend.title <- ifelse(is.na(legend.title), mapvar, legend.title)

  mp <- tm_shape(me_bndry) +
    tm_fill(col = "grey60") +
    tm_shape(spdf) +
    tm_fill(col = mapvar, title = legend.title, palette = pal, breaks = brks) +
    tm_borders(col = "grey40", lwd = 1) +
    tm_legend(outside = T) +
    tm_layout(
      #inner.margins = c(.1,.1,.1,.1),
      frame = F,
      legend.text.size = 1
    )
  mp

}

maine_map(hsa_sp, "uninsured_pct", pal, legend.title = "% Adults Uninsured")
maine_map(hsa_sp, "obese_rate", pal, legend.title = "% Adults Obese",
          filename = "Obesity", breaks = seq(15,40,5))
#
# lgl <- names(hsa_sp@data) %>% grepl(".*_pct", .)
# vars <- names(hsa_sp@data)[lgl]
# purrr::map(vars, ~maine_map(hsa_sp, ., pal))
#
