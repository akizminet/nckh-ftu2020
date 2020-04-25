library("dplyr")

# Read data
dat <- read.csv("price.csv")
dat$date <- as.Date(as.character(dat$date),"%Y%m%d") #Format date
dat <- mutate(dat, weekdays=weekdays(date)) #add weekday
dat <- dat[order(dat$date),] #sort by date

list_code <-sort(unique(as.character(dat$code))) #get tickets

list_wed = seq(from=as.Date("2009-12-23"), to=as.Date("2019-01-09"),by=7) #vector of wednesday from 2010-2018
list_day <- unique(as.Date(dat$date)) #get trading date

list_non_wed<-list_wed[!list_wed %in% list_day] #find non-wednesday
list_wed<-list_wed[list_wed %in% list_day]
#lay ngay gan nhat co giao dich
list_moi <- c()
for (day in list_non_wed) {
  while(!day %in% list_day) {
    day<-day-1
  }
  list_moi<-append(list_moi,day)
}
list_moi <- as.Date(list_moi,origin="1970-01-01")

#tong hop
ngay_giao_dich <- sort(c(list_wed,list_moi))

bang_tuan <- data.frame(date=ngay_giao_dich,tuan = seq(0,length(ngay_giao_dich)-1))

dat <- merge(filter(dat,date %in% ngay_giao_dich),bang_tuan,by="date")

cophieu <- list()
for (id in list_code){
  cophieu[[id]] <- filter(dat,code == id,date %in% ngay_giao_dich)
}

# Calculate return
R <- list()
for (id in list_code) {
  n <- nrow(cophieu[[id]])
  R[[id]] <- log(cophieu[[id]]$price[2:n])-log(cophieu[[id]]$price[1:n-1])
}

for (id in list_code) {
  tuan_dau <- cophieu[[id]]$tuan[1];
  cophieu[[id]] <- cophieu[[id]] %>% filter(tuan>tuan_dau) %>% mutate(R=R[[id]])
}

for (id in list_code) {
 if (cophieu[[id]]$tuan[nrow(cophieu[[id]])]-cophieu[[id]]$tuan[1]+1 != nrow(cophieu[[id]])) {
   print(id)
 }
}
# Chay hoi quy
last_week <- length(ngay_giao_dich)
w_start <- cophieu[["AAA"]]$tuan[1]
w_end <- 
Rmw_2 <- R[["VNINDEX"]][wstart] 
