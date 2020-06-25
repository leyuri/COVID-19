# data 로드하기
time <- read.csv(file = "/Users/yuri/data/time.csv", header=T)
str(time)

patient <- read.csv(file = "/Users/yuri/data/patient.csv", header=T)
str(patient)

route <- read.csv(file = "/Users/yuri/data/route.csv", header=T)
str(route)

# 한글깨짐
install.packages("extrafont")
library(extrafont)
font_import()

## 폰트 설정
library(ggplot2)
theme_set(theme_grey(base_family='NanumGothic'))

str(time)

# factor -> Data 로 변환
class(time$date)
time$date = as.Date(time$date)
class(time$date)
str(time)

# 일자별
# 시계열 그래프 그리기
library(ggplot2) 
ggplot(data = time, aes(x = date, y = confirmed)) + 
  geom_area(color="darkblue", fill="lightblue") + 
  scale_x_date(date_breaks = "weeks" , date_labels = "%m-%d") +
  ggtitle("시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

# 시계열 선 그래프
ggplot(data = time, aes(x = date, y = confirmed)) + 
  geom_line(color = "#00AFBB", size = 2) + 
  scale_x_date(date_breaks = "weeks" , date_labels = "%m-%d") +
  ggtitle("시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

# 2020-03-29 이후로 시계열 그래프 그리기
ss <- subset(time, date > as.Date("2020-03-29"))
ggplot(data = ss, aes(x = date, y = confirmed)) + 
  geom_line(color = "#FC4E07", size = 2)


# %>% 해결 위해
install.packages("magrittr") 
install.packages("dplyr")  
library(magrittr) 
library(dplyr)   



# 확진자 성별
ggplot(data = patient, aes(x = 2020-birth_year, fill = sex, colour = sex)) + 
  geom_density(alpha = 0.3) +
  xlab("age")

# 확진자 연령대별
ggplot(data = patient, aes(x = 2020-birth_year, fill = age, colour = age)) + 
  geom_density(alpha = 0.3) +
  xlab("age")


# 지역별 그래프!
library(dplyr)
cnt_province <- route %>% 
  count(province, sort = T) %>% 
  head(10)

cnt_province


ggplot(cnt_province, aes(x = reorder(province, n), y = n)) + 
  geom_col() + 
  coord_flip() +
  xlab("province")

str(route)
head(route)
