#' @export
clean_and_build<-function(){
  library(rgdal)
  library(leaflet)
  library(sf)
  library(maptools)
  library(reticulate)
  DMA_markets <- shapefile("Data/dma_boundary/dma_boundary.shp")
  animus<-read.csv('Data/racialanimusfinal_modified.csv')
  head(animus)
  #Citation: https://www.statmethods.net/management/sorting.html
  newdata <- animus[order(animus$Area),]
  namesvector<-DMA_markets$dma_1
  DMA_markets$animus<-animus$Animus
  DMA_markets<-DMA_markets[order(DMA_markets$dma_1),]
  #https://rstudio.github.io/leaflet/shapes.html
  library(maptools)
  writeOGR(obj=DMA_markets, dsn="Data/animus.shp", layer="resentment", driver="ESRI Shapefile") # this is in equal area projection
  reticulate::source_python('Python/rochester_cleaner.py')
  rochester_cleaner_main()
  reticulate::source_python('Python/html_builder.py')
  tibble<-html_builder()
}
