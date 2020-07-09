# COVID-19(국내 COVID-19 발생과 관련된 데이터 수집 및 분석)

### 1. R로 분석

#### (1) 분석을 위한 데이터 파일 로딩 및 전처리

##### 사용 데이터

- https://github.com/jooeungen/coronaboard_kr 의 kr_daily.csv 와 kr_regional_daily.csv
  - 데이터를 찾다보니 중구난방한 것들이 많았다. 따라서 가장 최신의 일자를 담으면서도 지역별 데이터를 알려주는 이 데이터를 활용하게 되었다. csv 파일은 위의 url에서 직접 다운 받았다. 

- https://github.com/youngwoos/corona19에서 patient 를 getdata하여 사용하였음
  -  환자별 성별과 연령대 비교를 위한 데이터가 없어서 모색하던 도중 발견한 데이터이다. 직접 corona19 데이터를 library처럼 만들어서 배포중이였다. 따라서 아래의 방법으로  patient. csv파일을 저장하여 활용하였다. 
- https://github.com/youngwoos/corona19 에서 route 를 getdata하여 사용하였음
  - 지역별 위도 경도가 표시되어서 지도를 그릴 때 유용할 것으로 생각하여 이용하였다. patient data 와 마찬가지 방법을 활용하였다. 

```R
install.packages("remotes")
remotes::install_github("youngwoos/corona19")
library(corona19)

# patient
patient <- getdata("patient") 
str(patient)

write.csv(patient, "/Users/yuri/data/patient.csv")

# route
route <- getdata("route") 
str(route)

write.csv(route, "/Users/yuri/data/route.csv")
```

- 파일 로딩하기

```R
# kr_daily.csv, kr_regional_daily.csv 로드하기
data <- read.csv(file = "/Users/yuri/data/kr_daily.csv", header=T)
head(data)
str(data)
data2 <- read.csv(file = "/Users/yuri/data/kr_regional_daily.csv", header=T)

# patient.csv 로드하기
patient <- read.csv(file = "/Users/yuri/data/patient.csv", header=T)
str(patient)
# route.csv 로드하기
route <- read.csv(file = "/Users/yuri/data/route.csv", header=T)
str(route)
```







#### (2) 수치 요약과 시각화

- 일자별

| <img width="814" alt="1" src="https://user-images.githubusercontent.com/33794732/85682745-8effbc00-b707-11ea-8b28-71063370df52.png"> | <img width="813" alt="2" src="https://user-images.githubusercontent.com/33794732/85682763-92934300-b707-11ea-97eb-5a7bd8ea1b85.png"> | <img width="814" alt="3" src="https://user-images.githubusercontent.com/33794732/85682764-932bd980-b707-11ea-97c7-a3246ae8bc6a.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

- 성별, 연령대별

| <img width="814" alt="10" src="https://user-images.githubusercontent.com/33794732/85682785-9626ca00-b707-11ea-97ca-c07ab069aa6d.png"> | <img width="813" alt="11" src="https://user-images.githubusercontent.com/33794732/85682789-9626ca00-b707-11ea-96de-1fe568dfa969.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

- 지역별 비교

| <img width="814" alt="4" src="https://user-images.githubusercontent.com/33794732/85682768-93c47000-b707-11ea-9ebb-36ad2c530857.png"> | <img width="816" alt="5" src="https://user-images.githubusercontent.com/33794732/85682771-93c47000-b707-11ea-95f7-4ea2397fabd8.png"> | <img width="814" alt="6" src="https://user-images.githubusercontent.com/33794732/85682776-945d0680-b707-11ea-8ef9-60de44c0013e.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

- 전체 지역별 비교

| <img width="813" alt="7" src="https://user-images.githubusercontent.com/33794732/85682778-94f59d00-b707-11ea-976a-769295c783d6.png"> | <img width="813" alt="8" src="https://user-images.githubusercontent.com/33794732/85682781-958e3380-b707-11ea-8731-139644df8c7e.png"> | <img width="815" alt="9" src="https://user-images.githubusercontent.com/33794732/85682783-958e3380-b707-11ea-8e33-83422653e086.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |



```R
# kr_daily.csv, kr_regional_daily.csv 로드하기
data <- read.csv(file = "/Users/yuri/data/kr_daily.csv", header=T)
head(data)
str(data)
data2 <- read.csv(file = "/Users/yuri/data/kr_regional_daily.csv", header=T)

# patient.csv 로드하기
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
ggplot(data=data2, aes(x=reorder(region, confirmed), y=confirmed)) + 
  geom_col(size=1) +
  geom_bar(stat='identity') +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5)) 

# 막대 그래프 활용하기!
ggplot(data=data2, aes(x=reorder(region, confirmed), y=confirmed, color=confirmed)) + 
  geom_bar(stat='identity') + coord_flip() +
  ggtitle("전체 지역별 확진자 수") + 
  theme(plot.title = element_text(hjust = 0.5)) 

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
```



#### (3) 지도 시각화

- ggmap 패키지로 구글 지도 API를 이용한 공간 데이터 시각화를 진행하였다.
- google cloud platform에서 google api key를 할당받아 사용하였다.
- 색깔, 밀도, 레벨에 따라 3가지 지도를 그렸다.

| <img width="691" alt="Map_1" src="https://user-images.githubusercontent.com/33794732/85733992-9fc82600-b737-11ea-89d3-bb4afe2b8bb9.png"> | <img width="688" alt="Map_2" src="https://user-images.githubusercontent.com/33794732/85734001-a191e980-b737-11ea-837a-1f550deefa79.png"> | <img width="694" alt="Map_3" src="https://user-images.githubusercontent.com/33794732/85734003-a22a8000-b737-11ea-9100-004fcb31ab14.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

```R
route <- read.csv(file = "/Users/yuri/data/route.csv", header=T)
str(route)
head(route)

install.packages('devtools')
library('devtools')
install_github('dkahle/ggmap')
library('ggmap')

# google API KEY
register_google(key='AIzaSyDg4nbtILtXctRHeHWz1YWhz4Bd8ADG8fk')

library('rvest')
ggmap(get_map(location='south korea', zoom=7))

library('rvest')
# 기본 map 완성
map <- ggmap(get_map(location='south korea', zoom=7, color='bw'))

# 지역별 환자수
map + geom_point(data=route, aes(x=longitude, y=latitude, color=province))

# 지역별 환자의 2차원 밀도를 보여줌
map + stat_density_2d(data=route, aes(x=longitude, y=latitude))

# 레벨이 높으면 불투명하게(색이 더 잘 드러나게) 칠하고 낮을 때는 투명하게(희미하게)
map + stat_density_2d(data=route, aes(x=longitude, y=latitude, fill=..level.., alpha=..level..), geom='polygon', size=2, bins=30)
```



### 2. 구글 클라우드 버킷에 저장하고, SQL 인스턴스를 생성하여 분석에 활용할 수 있도록 DB와 테이블을 생성하여 저장



버킷을 만들고 클라우드 쉘 윈도우에서 데이터가 있는 repositories에 저장, 구글 클라우드 스토리지에 데이터 업로드 완료

<img width="909" alt="Screen Shot 2020-06-26 at 12 44 25 AM" src="https://user-images.githubusercontent.com/33794732/85812399-7345f580-b79b-11ea-9dac-77b34e9421ce.png">

cloud-training-covid19-bucket/covid19/raw에 csv파일을 확인할 수 있다. 



##### 구글 클라우드 SQL인스턴스 사용

구글 클라우드 플랫폼에서 SQL인스턴스를 생성, 인스턴스 아이디는 covid-19, 비밀번호는 1234

<img width="947" alt="Screen Shot 2020-06-26 at 11 04 08 AM" src="https://user-images.githubusercontent.com/33794732/85812900-d8e6b180-b79c-11ea-9f74-541665a77573.png">







##### SQL 인스턴스 연결

<img width="907" alt="Screen Shot 2020-06-26 at 11 11 15 AM" src="https://user-images.githubusercontent.com/33794732/85813337-e51f3e80-b79d-11ea-99e9-df3332274ab5.png">



##### 데이터 베이스 생성

```
create database if not exists bts;
show databases;
```

<img width="904" alt="Screen Shot 2020-06-26 at 11 13 20 AM" src="https://user-images.githubusercontent.com/33794732/85813397-10099280-b79e-11ea-85dc-fbb3df2e9576.png">



##### 테이블 생성, mysql로 테이블을 넣는 쿼리를 만들고 table 생성

```mysql
CREATE TABLE regional_daliy (
 `date`        int(20),
 `region`     VARCHAR(20),
 `confirmed`    int(20),
 `death`    int(20),   
 `released`    int(20),  
  PRIMARY KEY(`date`)
);
```

<img width="911" alt="Screen Shot 2020-06-26 at 11 16 07 AM" src="https://user-images.githubusercontent.com/33794732/85813579-84dccc80-b79e-11ea-993f-01b01b7e1931.png">

##### Mysql 인스턴스 IP주소 확인함

gcloud sql instances describe covid-19 --format="value(ipAddresses.ipAddress)"

<img width="913" alt="Screen Shot 2020-06-26 at 11 18 05 AM" src="https://user-images.githubusercontent.com/33794732/85813651-bce40f80-b79e-11ea-8dc5-8a530886eebb.png">



##### 테이블 채우기-버킷에 있는 데이터 파일을 로컬에 복사 

gsutil cp gs://cloud-training-covid19-bucket/covid19/raw/kr_regional_daily.csv kr_regional_daily.csv-1

<img width="909" alt="Screen Shot 2020-06-26 at 11 19 04 AM" src="https://user-images.githubusercontent.com/33794732/85813687-dc7b3800-b79e-11ea-8ff5-612ce3dcc04b.png">



##### 테이블 채우기

mysqlimport --local --host=34.68.95.169 --user=root --ignore-lines=1 --fields-terminated-by=',' --password bts kr_regional_daily.csv-1

<img width="911" alt="Screen Shot 2020-06-26 at 11 23 50 AM" src="https://user-images.githubusercontent.com/33794732/85813918-86f35b00-b79f-11ea-9070-4b8aeef7fcb4.png">

-> 에러 계속 발생 

-> 반복해도 계속 발생

-> 삭제하고 다시 해도 에러 발생



### 3. Google Data Studio를 이용하여 현황을 파악할 수 있도록 보고서 작성

SQL 인스턴스를 추가하여 테이블을 만들려고 하였으나 결국 해결하지 못해 Google Data Studio에서 버킷에 있는 데이터를 가져오도록 하였다. 

<img width="1175" alt="Screen Shot 2020-06-26 at 11 28 07 AM" src="https://user-images.githubusercontent.com/33794732/85814106-1d278100-b7a0-11ea-83f8-e86fea2b3455.png">




| <img width="620" alt="Screen Shot 2020-06-26 at 11 42 55 AM" src="https://user-images.githubusercontent.com/33794732/85815465-70e79980-b7a3-11ea-8840-14a43896e2b7.png"> | <img width="620" alt="Screen Shot 2020-06-26 at 11 43 16 AM" src="https://user-images.githubusercontent.com/33794732/85815470-7513b700-b7a3-11ea-9bcb-1e8f731c8d98.png"> |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img width="200" align="center" alt="Screen Shot 2020-06-26 at 12 03 16 PM" src="https://user-images.githubusercontent.com/33794732/85816026-0899b780-b7a5-11ea-9448-15f91c2f74f9.png"> | <img width="200" alt="Screen Shot 2020-06-26 at 12 02 06 PM" src="https://user-images.githubusercontent.com/33794732/85815965-e43ddb00-b7a4-11ea-9ba4-3224bd62ee5f.png"> |


