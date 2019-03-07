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

maine_map <- function(spdf, mapvar, pal, legend.title = NA, breaks = "quintile", filename = "mapvar"){

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

      if(filename == "mapvar"){
          filename <- paste0("./maps/", mapvar, ".png")
      } else {
          filename <- paste0("./maps/", filename, ".png")
      }

      save_tmap(mp, filename = filename, height = 4, width = 5.5)
}

maine_map(hsa_sp, "uninsured_pct", pal, legend.title = "% Adults Uninsured")
maine_map(hsa_sp, "obese_rate", pal, legend.title = "% Adults Obese",
          filename = "Obesity", breaks = seq(15,40,5))
#
# lgl <- names(hsa_sp@data) %>% grepl(".*_pct", .)
# vars <- names(hsa_sp@data)[lgl]
# purrr::map(vars, ~maine_map(hsa_sp, ., pal))
#
