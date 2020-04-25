import requests
from bs4 import BeautifulSoup
import re
from time import sleep
tickers = open("ticker.txt","r").readlines()
def getShares(ticker):
    url = "https://www.cophieu68.vn/incomestatement.php?id="+str(ticker)+"&view=ist&year=-1"
    baocao = requests.get(url)
    dulieu = BeautifulSoup(baocao.text,'lxml')
    #print(dulieu.prettify())
    year_td = dulieu.find("tr",class_='tr_header').find_all("td")[1:]
    khoiluong_html = dulieu.find_all("tr")[30].find_all("td")
    #print(khoiluong_html[1].text.strip()==b'Kh\xc3\xa1\xc2\xbb\xc2\x91i L\xc3\x86\xc2\xb0\xc3\xa1\xc2\xbb\xc2\xa3ng')
    khoiluong_td = khoiluong_html[2:]
    year = list()
    khoiluong = list()
    for td in year_td:
        year.append(int(td.text))
    for td in khoiluong_td:
        khoiluong.append(int(td.text.replace(',','')))
    if len(year) != len(khoiluong):
        raise ValueError("An Unexpected Error happen!")
    else:
        dat = dict()
        dat["TICKER"]=[ticker]*len(year)
        dat["YEAR"] = year
        dat["SHARES"] = khoiluong
    return dat
getShares(tickers[0].strip())
import csv

csv_columns = ["TICKER","YEAR","SHARES"]
data = list()
for tick in tickers:
    try:
        data.append(getShares(tick))
    except:
        print(tick.strip()," has error")
    sleep(0.5)
with open("share.csv","w") as share:
    writer = csv.DictWriter(share,csv_columns)
    writer.writeheader()
    for dat in data:
        writer.writerow(dat)