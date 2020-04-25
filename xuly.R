library(data.table)

san <- fread("nckh.csv",encoding = "UTF-8",stringsAsFactors = FALSE)

tickers <- unique(san[V5=="HOSE" & order(V3),V3])
tickers <- append(tickers,"VNINDEX")
cophieu <- list()
for (id in tickers) {
  cophieu[[id]] <- fread(paste0("cophieu/",id,".csv"))
  cophieu[[id]][,`:=`(DATE= as.Date(DATE,"%d/%m/%Y"),HIGH=NULL,OPEN=NULL,LOW=NULL)]
}
thu_tu_uu_tien <- c("Wednesday","Tuesday","Monday","Thursday","Friday")
#Chon ngay trong tuan co giao dich
select_day <- function(x) {
  i <- 1
  while(is.na(match(thu_tu_uu_tien[i],weekdays(x)))){
    i <- i+1
  }
  return(x[match(thu_tu_uu_tien[i],weekdays(x))])
}

pb <- txtProgressBar(min=0,max=length(tickers),style=3)
i <- 1
for(id in tickers){
  setTxtProgressBar(pb, i)
  #print(id)
  cophieu[[id]] <- cophieu[[id]][,.SD[DATE==select_day(DATE)],by=WEEK]
  i <- i+1
}
close(pb)
#list_wed <- seq(from=as.Date("2009-12-23"), to=as.Date("2019-01-09"),by=7)
list_day <- cophieu[["VNINDEX"]][DATE > as.Date("2009-12-22")&DATE<=as.Date("2019-01-10"),DATE]
days_seq <- c()
weeks_seq <- c()
mondays = seq(from=as.Date("2009-12-21"),to=as.Date("2019-01-07"),by=7)
i <- -1
for (monday in as.list(mondays))
{
  tuan <- seq(from=monday,to=monday+6, by=1)
  if (any(tuan %in% list_day)) {
    days_seq <- append(days_seq,tuan)
    weeks_seq <- append(weeks_seq,rep(i,7))
    i<- i+1
  }
}
days_seq <- as.Date(days_seq,origin="1970-01-01")
bang_tuan <-data.table(DATE=days_seq,WEEK=weeks_seq)

for (id in tickers) {
  cophieu[[id]] <- merge(cophieu[[id]],bang_tuan,by="DATE")
}
thu_tu_uu_tien <- c("Wednesday","Tuesday","Monday","Thursday","Friday")

select_day <- function(x) {
  i <- 1
  while(is.na(match(thu_tu_uu_tien[i],weekdays(x)))){
    i <- i+1
  }
  return(x[match(thu_tu_uu_tien[i],weekdays(x))])
}

cophieu <- cophieu[-which(lapply(cophieu,nrow)==0)] #remove stocks which without trading infomation 
tickers <- names(cophieu) #update tickers

for(id in tickers){
  print(id)
  cophieu[[id]] <- cophieu[[id]][,.SD[DATE==select_day(DATE)],by=WEEK]
}
R <- list()
for (id in tickers) {
  n <- nrow(cophieu[[id]])
  R[[id]] <- log(cophieu[[id]]$CLOSE[2:n])-log(cophieu[[id]]$CLOSE[1:n-1])
  cophieu[[id]] <- cophieu[[id]][-1][,R:=R[[id]]]
}

for(id in tickers[-length(tickers)]) {
  cophieu[[id]] <- cophieu[[id]][WEEK > 1 & WEEK < 464]
}
for (id in tickers[-length(tickers)]) {
Rw <- cophieu[[id]][,R]
len <- length(Rw)
batdau <- first(cophieu[[id]][,WEEK])
ketthuc <- last(cophieu[[id]][,WEEK])
Rmw_2 <- cophieu[["VNINDEX"]][WEEK>=batdau-2&WEEK<=ketthuc-2][,R]
Rmw_1 <- cophieu[["VNINDEX"]][WEEK>=batdau-1&WEEK<=ketthuc-1][,R]
Rmw <- cophieu[["VNINDEX"]][WEEK>=batdau&WEEK<=ketthuc][,R]
Rmw1 <- cophieu[["VNINDEX"]][WEEK>=batdau+1&WEEK<=ketthuc+1][,R]
Rmw2 <- cophieu[["VNINDEX"]][WEEK>=batdau+2&WEEK<=ketthuc+2][,R]

if (any(!lengths(list(Rw,Rmw_2,Rmw_1,Rmw,Rmw1,Rmw2))==len)) {
  sprintf("%s error!\n","AAA")
} else {
  banghoiqui <-data.table(TICKER="AAA",Rw,Rmw_2,Rmw_1,Rmw,Rmw1,Rmw2)
  hoiqui <- lm(Rw~Rmw_2+Rmw_1+Rmw+Rmw1+Rmw2,banghoiqui)
  cophieu[[id]][,res:=residuals(hoiqui)]
}
}
#check
#for (id in tickers) {
#  if (
#    any(!seq(first(cophieu[["AAA"]][,WEEK]),last(cophieu[["AAA"]][,WEEK])) %in% cophieu[["AAA"]][,WEEK]) 
#    ){
#    print(id)
#  }
#}
#fwrite(rbindlist(cophieu),"pricev2.csv")
