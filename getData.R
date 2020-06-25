install.packages("remotes")
remotes::install_github("youngwoos/corona19")
library(corona19)

# time
time <- getdata("time")
str(time)

write.csv(time, "/Users/yuri/data/time.csv")

# patient
patient <- getdata("patient") 
str(patient)

write.csv(patient, "/Users/yuri/data/patient.csv")


# route
route <- getdata("route") 
str(route)

write.csv(route, "/Users/yuri/data/route.csv")






