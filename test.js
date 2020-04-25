await fetch("https://www.vndirect.com.vn/portal/ajax/listed/DownloadReportForSymbol.shtml", {
    //"credentials": "include",
    "headers": {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0",
        //"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        //"Accept-Language": "en-US,en;q=0.5",
        "Content-Type": "application/x-www-form-urlencoded",
        //"Upgrade-Insecure-Requests": "1"
    },
    //"referrer": "https://www.vndirect.com.vn/portal/thong-ke-thi-truong-chung-khoan/lich-su-gia.shtml",
    "body": "model.downloadType=%24HP_DL_TYPE%24&pagingInfo.indexPage=1&searchMarketStatisticsView.symbol=ACC&strFromDate=05%2F02%2F2020&strToDate=21%2F02%2F2020",
    "method": "POST",
    "mode": "cors"
}).then(function(resp){return resp.blob()});