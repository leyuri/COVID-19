# data 로드하기
data <- read.csv(file = "/Users/yuri/data/kr_daily.csv", header=T)
head(data)
str(data)
data2 <- read.csv(file = "/Users/yuri/data/kr_regional_daily.csv", header=T)

# patient data 가져오기
patient <- read.csv(file = "/Users/yuri/data/patient.csv", header=T)
str(patient)

# 구조확인
head(data2)
str(data2)
class(data2$region)
table(data2$region)
str(patient)

# 한글깨짐
install.packages("extrafont")
library(extrafont)
font_import()

## 폰트 설정
library(ggplot2)
theme_set(theme_grey(base_family='NanumGothic'))


# 시계열 그래프
ggplot(data = data, aes(x = date, y = confirmed)) + 
  geom_line(color = "#00AFBB", size = 2) + 
  ggtitle("시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

library(ggplot2) 
ggplot(data = data, aes(x = date, y = confirmed)) + 
  geom_area(color="darkblue", fill="lightblue") + 
  ggtitle("시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))


# 2020-05-23 이후로 시계열 그래프 그리기
ss <- subset(data, date > as.integer(20200523))
ggplot(ss, aes(x = date, y = confirmed))+geom_line(color = "#FC4E07", size = 2) +
  ggtitle("2020-05-23 이후의 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))


# %>% 해결 위해
install.packages("magrittr") 
install.packages("dplyr")  
library(magrittr) 
library(dplyr)   


# 지역별 비교
data2%>%
  filter(region=="대구")%>%
  ggplot(aes(date, confirmed)) + 
  geom_line(color = 'orange') +
  ggtitle("대구 시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

data2%>%
  filter(region=="제주")%>%
  ggplot(aes(date, confirmed)) +
  geom_line(color = 'blue') +
  ggtitle("제주 시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))


data2%>%
  filter(region=="서울")%>%
  ggplot(aes(date, confirmed))+
  geom_line(color = 'red') +
  ggtitle("서울 시간별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

# 전제 지역 별 확진자 수 확인
ggplot(data2, aes(date, confirmed, color = region))+
  geom_line() +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))

# 데이터 변형
library(reshape2)
multiple_graph <- data.frame(data2$date, data2$region, data2$confirmed)
colnames(multiple_graph)[1] <- c("date") #컬럼면 바꾸기
colnames(multiple_graph)[2] <- c("region") #컬럼면 바꾸기
colnames(multiple_graph)[3] <- c("confirmed") #컬럼면 바꾸기
head(multiple_graph[order(multiple_graph$date),])

#여러 개 시계열 그래프 그리기
ggplot(multiple_graph, aes(x = date, y = confirmed)) + 
  geom_line(aes(color = region), size = 1) +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5))


# 막대 그래프 활용하기!
ggplot(data=data2, aes(x=reorder(region, confirmed), y=confirmed, color=confirmed)) + 
  geom_col(size=1) +
  geom_bar(stat='identity') +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5)) +

# 막대 그래프 활용하기!
ggplot(data=data2, aes(x=reorder(region, confirmed), y=confirmed, color=confirmed)) + 
  geom_bar(stat='identity') + coord_flip() +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(aes(label=confirmed), hjust=-.1, check_overlap=TRUE)



# 확진자 성별
ggplot(data = patient, aes(x = 2020-birth_year, fill = sex, colour = sex)) + 
  geom_density(alpha = 0.3) +
  xlab("age")+
  ggtitle("확진자 성별") + 
  theme(plot.title = element_text(hjust = 0.5))


# 확진자 연령대별
ggplot(data = patient, aes(x = 2020-birth_year, fill = age, colour = age)) + 
  geom_density(alpha = 0.3) +
  xlab("age")+
  ggtitle("확진자 연령대별") + 
  theme(plot.title = element_text(hjust = 0.5))












#____________________________________________________#
# 성별비교
ggplot(data = patient, aes(x = 2020-birth_year, fill = sex, colour = sex)) + 
  geom_density(alpha = 0.3) +
  xlab("age")

# NA값 에러 발생 전처리
sum(is.na(patient))

str(patient)
head(patient)

# 필요없는 열 삭제
patient <- patient[-c(3,10,11,12,13,14,15,18)]
str(patient)
sum(is.na(patient))

patient_1 <- na.omit(patient)
str(patient_1)
sum(is.na(patient_1))

sum(is.na(patient_1$birth_year))

# 그래프 그리기
ggplot(data = patient, aes(x = 2020-birth_year, fill = sex, colour = sex)) + 
  geom_density(alpha = 0.3) +
  xlab("age")
  