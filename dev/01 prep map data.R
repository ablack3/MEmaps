# simple map in R
library(sp) # spacial dataframe objects
library(tmap) # easy mapping


# read in shapefile downloaded from dartmoth atlas website
hsa_sp <- rgdal::readOGR(dsn = "hsa_bdry", layer = "HSA_BDRY", stringsAsFactors = F)

# examine structure
str(hsa_sp, max.level = 2)
str(hsa_sp@data)

# subset spdf to Maine
me_flg <- substr(hsa_sp$HSANAME, 1, 2) == "ME"
table(me_flg)
hsa_sp <- hsa_sp[me_flg, ]

head(hsa_sp)
head(hsa_sp@data)

# create hsacity variable to merge on
hsa_sp$hsaname <- tolower(substring(hsa_sp$HSANAME, first = 5))
hsa_sp$hsanum <- hsa_sp$HSA93

# check result
hsa_sp$hsanum

# need to assign proj 4 string
proj4string(hsa_sp)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# we need state boundary

library(tigris)
# Call tracts(): nyc_tracts
me_tracts <- tracts(state = "ME", cb = TRUE)
me_cntys <- counties(state = "ME", cb = T)
me_zctas <- zctas(state = "ME", cb = T)

state_bndry <- states(cb = T)

str(state_bndry@data, max.level = 2)
me_bndry <- state_bndry[state_bndry$STUSPS == "ME", ]

# fix coordinate ref system
proj4string(me_bndry)
# should be NAD83
proj4string(hsa_sp) <- proj4string(me_bndry)


me_hsa <- hsa_sp

me_hsa$hsaname <-  tools::toTitleCase(hsa$hsaname)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# now we have our data and are ready to map!
plot(hsa_sp)
plot(me_bndry, add = T)

plot(me_cntys)




# save map objects
# purrr::walk2(list(me_tracts, me_cntys, me_hsa, me_zctas, me_bndry),
#              list("me_tracts", "me_cntys", "me_hsa", "me_zctas", "me_bndry"),
#              ~readr::write_rds(.x, paste0("./data/", .y, ".rds")))

devtools::use_data(me_tracts, me_cntys, me_hsa, me_zctas, me_bndry)
