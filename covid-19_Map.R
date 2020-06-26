route <- read.csv(file = "/Users/yuri/data/route.csv", header=T)
str(route)
head(route)

install.packages('devtools')
library('devtools')
install_github('dkahle/ggmap')
library('ggmap')

# google API KEY
register_google(key=${your API Key})

library('rvest')
ggmap(get_map(location='south korea', zoom=7))

library('rvest')
# 기본 map 완성
map <- ggmap(get_map(location='south korea', zoom=7, color='bw'))

# 지역별 환자수
map + geom_point(data=route, aes(x=longitude, y=latitude, color=province))

# 지역별 환자의  2차원 밀도를 보여줌
map + stat_density_2d(data=route, aes(x=longitude, y=latitude))

# 레벨이 높으면 불투명하게(색이 더 잘 드러나게) 칠하고 낮을 때는 투명하게(희미하게)
map + stat_density_2d(data=route, aes(x=longitude, y=latitude, fill=..level.., alpha=..level..), geom='polygon', size=2, bins=30)
