RasterSolnandes <- readRDS("RasterSolnandes.rds")
RasterSolnandes <- RasterSolnandes/cellStats(RasterSolnandes, "max")

RasterSolnandes_ln <- readRDS("RasterSolnandes_linear.rds")
RasterSolnandes_ln <- RasterSolnandes_ln/cellStats(RasterSolnandes_ln, "max")

Zonation1 <- raster("nandes_endemic_rcp85_PA_cc.CAZ_MEBLP1000.wrscr.compressed.tif")
Zonation1 <- Zonation1/cellStats(Zonation1, "max")

MASK <- Zonation1 

values(MASK) <- ifelse(is.na(values(MASK)), NA, 1)

MASK2 <- RasterSolnandes 

values(MASK2) <- ifelse(is.na(values(RasterSolnandes)), NA, 1)


#Zonation2 <- raster("nandes_endemic_rcp85_PA_cc.CAZ_MEBLP1000.rank.compressed.tif")
#Zonation2 <- Zonation2/cellStats(Zonation2, "max")

Sols <- stack(RasterSolnandes, RasterSolnandes_ln, Zonation1)

Sols <- Sols*MASK*MASK2

names(Sols) <- c("Quadratic NF", "Linear NF", "Zonation")

CORRINDEX <- expand.grid(First = c(1:3), Second = c(1:3))
CORRNAME <- expand.grid(First = c("Quadratic NF", "Linear NF", "Zonation"), Second = c("Quadratic NF", "Linear NF", "Zonation")) %>% mutate(layer = paste(First, Second, sep = "_")) 

CORRSTACK <- list()

for(i in 1:nrow(CORRINDEX)){
  CORRSTACK[[i]] <- corLocal(Sols[[CORRINDEX$First[i]]], Sols[[CORRINDEX$Second[i]]], method ="spearman")
  message(i)
}

CORRSTACK2 <-  do.call("stack", CORRSTACK)
names(CORRSTACK2) <- CORRNAME$layer
values(CORRSTACK2[[1]]) <- NA
values(CORRSTACK2[[5]]) <- NA
values(CORRSTACK2[[9]]) <- NA

myTheme <- BuRdTheme()
myTheme$panel.background$col = 'gray'

saveRDS(CORRSTACK2, "CORRSTACK.rds")


levelplot(CORRSTACK2, par.settings = myTheme, layout=c(3, 3))



##################
##################



RasterSolnandes <- read_rds("RasterSolsnandes.rds")
RasterSolnandes <- RasterSolnandes$cc
RasterSolnandes <- RasterSolnandes/cellStats(RasterSolnandes, "max")

RasterSolnandes_ln <- readRDS("RasterSolsnandes_linear.rds")
RasterSolnandes_ln <- RasterSolnandes_ln$cc
RasterSolnandes_ln <- RasterSolnandes_ln/cellStats(RasterSolnandes_ln, "max")

Zonation1 <- raster("nandes_endemic_rcp85_PA_cc.CAZ_MEBLP1000.wrscr.compressed.tif")
Zonation1 <- Zonation1/cellStats(Zonation1, "max")

MASK <- Zonation1 

values(MASK) <- ifelse(is.na(values(MASK)), NA, 1)

MASK2 <- RasterSolnandes 

values(MASK2) <- ifelse(is.na(values(RasterSolnandes)), NA, 1)


#Zonation2 <- raster("nandes_endemic_rcp85_PA_cc.CAZ_MEBLP1000.rank.compressed.tif")
#Zonation2 <- Zonation2/cellStats(Zonation2, "max")

Sols <- stack(RasterSolnandes, RasterSolnandes_ln, Zonation1)

Sols <- Sols*MASK*MASK2

names(Sols) <- c("Quadratic NF", "Linear NF", "Zonation")

CORRINDEX <- expand.grid(First = c(1:3), Second = c(1:3))
CORRNAME <- expand.grid(First = c("Quadratic NF", "Linear NF", "Zonation"), Second = c("Quadratic NF", "Linear NF", "Zonation")) %>% mutate(layer = paste(First, Second, sep = "_")) 

CORRSTACK <- list()

for(i in 1:nrow(CORRINDEX)){
  CORRSTACK[[i]] <- corLocal(Sols[[CORRINDEX$First[i]]], Sols[[CORRINDEX$Second[i]]], method ="spearman")
  message(i)
}

CORRSTACK2 <-  do.call("stack", CORRSTACK)
names(CORRSTACK2) <- CORRNAME$layer
values(CORRSTACK2[[1]]) <- NA
values(CORRSTACK2[[5]]) <- NA
values(CORRSTACK2[[9]]) <- NA

myTheme <- BuRdTheme()
myTheme$panel.background$col = 'gray'


levelplot(CORRSTACK2, par.settings = myTheme, layout=c(3, 3))
