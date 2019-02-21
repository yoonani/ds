library(GISTools)
data(newhaven)
ls()
class(roads)
plot(roads)
class(blocks)
plot(blocks)
names( blocks )
head( data.frame(blocks) )

def.par <- par(no.readonly = TRUE)
par(mar=c(0, 0, 0, 0))
plot(blocks)
plot(roads, add=TRUE, col="red")
plot(breach, add=TRUE, col="blue")

# R color names
colors()

# GISTools::map.scale()
# 축척 표시
?map.scale

# 처음 두 인수 : 위치
# 세번째 : length of the scale : 2miles
# 네번째 출력할 문자열
# 다섯번째 : 축척의 눈금수? (Number of gradation)
# 여섯번째 : 축척 단위 증분

map.scale(534750, 152000, miles2ft(2), "Miles", 4, 0.5)

# 북방 표시
north.arrow(534750, 154000, miles2ft(0.25), col="lightblue")

title("New Haven, CT.")            


rm(list=ls())
data(georgia)

# rgeos::gUnaryUnion()
georgia.outline <- gUnaryUnion(georgia, id=NULL)
plot(georgia, col="red", bg="wheat", lty=2, border="blue")
plot(georgia.outline, lwd=3, add=TRUE)

ls()


par(def.par)
par(mfrow=c(1, 2))
par(mar=c(2, 0, 3, 0))

plot(georgia, col="red", bg="wheat")
title("Georgia")

plot(georgia2, col="orange", bg="lightyellow3")
title("Georgia2")

par(def.par)


names(georgia)
data.frame(georgia)[,13]
lat <- data.frame(georgia)[, 1]
lon <- data.frame(georgia)[, 2]

dstNames <- data.frame(georgia)[,13]
par(mar=c(0, 0, 0, 0))
plot(georgia, col=NA)
# maptools::pointLabel()
pl <- pointLabel(lon, lat, dstNames, offset=0, cex=.5)


# using country indices
country.tmp <- c(81, 82, 83, 150, 62, 53, 21, 16, 124, 121, 17)
dstNames[country.tmp]

# subsetting
georgia.sub <- georgia[country.tmp, ]

plot(georgia.sub, col="gold1", border="grey")
plot(georgia.outline, add=TRUE, lwd=2)
pl <- pointLabel(lon[country.tmp], lat[country.tmp], dstNames[country.tmp], offset=3, cex=1.5)



plot(georgia, border="grey", lwd=0.5)
plot(georgia.sub, add=TRUE, col="lightblue")
plot(georgia.outline, add=TRUE, lwd=2)

# install.packages("OpenStreetMap", dependencies = TRUE)
library(OpenStreetMap)

# define upper left, lower right corners
bbox(georgia.sub)
ul <- as.vector(cbind( bbox(georgia.sub)[2,2], bbox(georgia.sub)[1,1]))
ul
lr <- as.vector(cbind( bbox(georgia.sub)[2,1], bbox(georgia.sub)[1,2]))
lr

# download the map tile
?openmap
MyMap <- openmap(ul, lr, 9, "osm")
par(mar=c(0, 0, 0, 0))
plot(MyMap, removeMargin=FALSE)
plot(spTransform(georgia.sub, osm()), add=TRUE, lwd=2)



data(newhaven)
ls()
summary(blocks)
summary(tracts)
.Platform$GUI
