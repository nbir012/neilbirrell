#a script to generate a phenology, range map, etc. for h. illucens in NZ from inat data
#install.packages("rinat")
#install.packages("ggmap")


#get adult "research" grade bsf obs. for all NZ
bsf_obs <- rinat::get_inat_obs(
  query = NULL,
  taxon_name = "Hermetia illucens",
  taxon_id = 82177,
  place_id = 6803,
  quality = "research",
  geo = NULL,
  annotation = c(1,2),
  year = NULL,
  month = NULL,
  day = NULL,
  bounds = NULL,
  maxresults = 500,
  meta = FALSE
)

bsf_obs_latlon <- bsf_obs %>% 
  select(latitude, longitude)

leaflet() %>%
  addProviderTiles(providers$Stadia.StamenWatercolor) %>% 
  addCircles(lng=bsf_obs_latlon$longitude, lat=bsf_obs_latlon$latitude)


us <- c(left = 165, bottom = -50, right = 180, top = -30)
get_stadiamap(us, zoom = 5, maptype = "alidade_smooth") |> ggmap() 

bbox <- c(left = 24.61, bottom = 59.37, right = 24.94, top = 59.5)

get_stadiamap(bbox, zoom = 12, maptype = "stamen_toner_lite") %>% ggmap()


map <- get_stadiamap(bbox = c(left = 165, bottom = -50, right = 180, top = -30), zoom = 4, maptype = "stamen_watercolor")

ggmap(map) + 
  theme_void() + 
  theme(
    plot.title = element_text(colour = "orange"), 
    panel.border = element_rect(colour = "grey", fill=NA, size=2)
  )

coord_quickmap(xlim = c(165, 180), ylim = c(-50, -30))