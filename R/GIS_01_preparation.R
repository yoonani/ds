install.packages("GISTools", dependencies = TRUE)
library(GISTools)
data(newhaven)

tmp.list <- list("yoonani",  c(2005, 2009), "Researcher", matrix(c(6, 3, 1, 2), c(2, 2)))

tmp.list
tmp.list[[4]]

# 다음의 두개 비교
append(tmp.list, c(1, 4, 2, 3))
append(tmp.list, list(c(1, 4, 2, 3)))

# lapply
# list 의 각 원소(slot)에 is.numeric 적용
lapply(tmp.list, is.numeric)
# list 의 두번째 원소에 is.numeric 적용
lapply(tmp.list[[2]], is.numeric)


employee <- list(name="yoonani", start.year=2005, position="Researcher")
employee
employee$name
employee[[1]]


class(employee)

employee2 <- employee
class(employee2)
class(employee2) <- "staff"
class(employee2)

# class 함수 만들기
# 함수명.클래스이름 <- function(...) {     }
print.staff <- function(x) {
  cat("Name: ", x$name, "\n")
  cat("Start year: ", x$start.year, "\n")
  cat("Job title: ", x$position, "\n")
}

# 사용할 때는 위에서 적시한 함수에 전달인자로 
# 해당 클래스의 인스턴스 전달
print(employee2)

# print.클래스명() 의 경우 해당 클래스 이름만으로 출력
employee2
# ubclass 함수를 이용하여 print.class() 결과가 아닌 원래 클래스 결과가 나오게
# 혹은 rm()으로 해당 함수 제거
unclass( employee2 )

class( employee2 )
oldClass( employee2 )
?unclass


# OOP style
# 생성 함수 : new
new.staff <- function(name, year, post) {
  result <- list(name = name,
                 start.year = year,
                 position = post)
  class(result) <- "staff"
  return(result)
}

# 원소로 3개의 리스트를 갖는 리스트 벡터 생성
leics.uni <- vector(mode="list", 3)
leics.uni[[1]] <- new.staff("Fisher", 1991, "prof")
leics.uni[[2]] <- new.staff("Gosset", 1994, "prof")
leics.uni[[3]] <- new.staff("Tikey", 2010, "students")

leics.uni


x1 <- rnorm(100)
y1 <- rnorm(100)

x2 <- seq(0, 2*pi, len=100)
y2 <- sin(x2)
plot(x2, y2, type="l")
plot(x2, y2, type="l", lwd=3, col="darkgreen", ylim=c(-1.2, 1.2), axes=FALSE, ylab="", xlab="")
axis(1)
y2r <- y2 + rnorm(100, 0, 0.1)
points(x2, y2r, pch=16, col="darkred")

y4 <- cos(x2)
plot(x2, y2, type="l", lwd=3, col="darkgreen", axes=FALSE, ylab="", xlab="")
lines(x2, y4, lwd=3, lty=2, col="darkblue")


# 기본 plot 설정 저장
def.par <- par(no.readonly = TRUE)

par(mfrow=c(1, 2))

x2 <- seq(0, 2*pi, len=100)
y2 <- sin(x2)
y4 <- cos(x2)

plot(y2, y4)
polygon(y2, y4, col="lightgreen")

# asp : aspect ratio (가로세로 비율)
plot(y2, y4, asp=1., type="n")
polygon(y2, y4, col="lightgreen")

# 기본 설정 초기화
par(def.par)


# GISTool
data(georgia)
?georgia

class( georgia )
names( georgia )

slotNames( georgia )

polygons( georgia )
bbox( georgia )
proj4string( georgia )
georgia@plotOrder

class(polygons( georgia ))
str(polygons( georgia ), max.level = 2)
myAppling <- georgia@polygons[[1]]@Polygons[[1]]@coords
appling <- georgia.polys[[1]]
plot(appling, asp=1, type="n")
polygon(appling, density=14, angle=135)


plot(myAppling, asp=1, type="n")
polygon(myAppling, density=5, angle=45)



plot(appling, asp=1, type="n")
polygon(appling, col=rgb(0, 0.5, 0.7))

locator()

# raster data)
data(meuse.grid)
str(meuse.grid)

mat <- SpatialPixelsDataFrame(points=meuse.grid[c("x", "y")], data=meuse.grid)
par( mfrow = c(1, 2) )
par(mar = c(0, 0, 0, 0))
?image
# image() 함수는 기본 graphics 패키지의 함수로
# 색상 그리드를 만들어 줌
image(mat, "dist")
?meuse.grid
library(RColorBrewer)
greenpal <- brewer.pal(7, "Greens")
image(mat, "dist", col=greenpal)

# writePolyShape waas deprecated : rgdal::writeOGR() or sf::st_write()
writePolyShape(georgia, "./output/georgia.shp")
library(rgdal)
new.georgia <- readOGR(dsn="./R/output", layer="georgia")
plot(new.georgia)
