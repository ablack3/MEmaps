# a qualitative map

# names(me_hsa@data)
# fix labels
# hsa$hsaname
maine_hsa_key_map <- function(){
  require(tmap)
  hsa <- me_hsa
  # hsa$hsaname <- Map(function(.) ifelse(. == "Boothbay Harbor", "Boothbay \n Harbor",
  #                               ifelse(. == "Biddeford", "      Biddeford",
  #                               ifelse(. == "Sanford", "Sanford      ", .))),
  #                   hsa$hsaname) %>% unlist(use.name = F)

  tm_shape(me_bndry) +
        tm_fill(col = "grey30") +
        tm_borders(col = "grey10", lwd = 0) +
        tm_shape(hsa) +
        tm_fill(col = "grey60") +
        tm_borders(col = "grey10", lwd = 1) +
        tm_text(text = "hsaname", size = 0.6, col = "white") +
        tm_layout(bg.color = "grey10")
}

maine_hsa_key_map()
tmap_save(filename = "./dev/maps/HSA key.png")
