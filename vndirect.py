import requests
import json

url = "https://www.vndirect.com.vn/portal/ajax/listed/DownloadReportForSymbol.shtml"
headers= {
	"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0",
	"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Content-Type": "application/x-www-form-urlencoded",
    "Upgrade-Insecure-Requests": "1",
    "referrer": "https://www.vndirect.com.vn/portal/thong-ke-thi-truong-chung-khoan/lich-su-gia.shtml",
}
symbol = ["AAA","AAM","ABT","ACC","ACL","AGF","AGM","AGR","AMD","ANV","APC","APG","HII","ASM","ASP","ATG","BBC","BCE","BCG","BFC","BHN","BIC","BID","DBD","BWE","BMC","BMI","BMP","BRC","BSI","BTP","BTT","BVH","C32","C47","CAV","CCI","CCL","CDC","CDO","CEE","CRE","STK","CHP","CIG","CII","CLC","CLG","CLL","CLW","CMG","CMT","CMV","CMX","CNG","COM","CRC","CSM","CSV","CTD","CTF","CTG","CTI","CTS","CVT","D2D","DAG","DAH","ADS","DPG","DCL","DCM","DGW","DHA","DHC","DHG","DHM","DIC","DIG","DLG","DMC","DPM","DPR","DQC","DRC","DRH","DRL","DSN","DTA","DTL","DTT","DVP","DXG","DXV","FUESSV50","E1VFVN30","EIB","ELC","EMC","EVE","EVG","LEC","ROS","FCM","FCN","FDC","FIR","FIT","FLC","FMC","FTM","FPT","FRT","FTS","FUCTVGF2","GAS","GDT","GEX","GIL","GMC","GMD","GSP","GTA","GTN","HAG","HAH","HAI","HPX","HID","HAP","HAR","HAS","HAX","HBC","HCD","HCM","HDB","HDC","HDG","HHS","TCH","HSL","HLG","HMC","HNG","HOT","HPG","HQC","HRC","HSG","HT1","HTI","HTN","HTL","HTT","HTV","HU1","HU3","HVG","HVX","IBC","ICF","IDI","IJC","IMP","ITA","ITC","ITD","JVC","KAC","KBC","KDC","KDH","KHP","KMR","KPF","KSA","KSB","KSH","L10","LAF","LBM","LCG","LCM","LDG","LGC","LGL","LHG","LIX","LM8","LMH","LSS","MBB","MCG","MCP","MDG","MHC","MSN","MWG","NAF","NAV","NBB","NCT","VHM","NKG","NLG","NNC","NVL","NSC","NT2","NTL","NVT","OGC","OPC","PAC","PAN","PC1","PDN","PDR","PET","PLX","PGC","PGD","PGI","PLP","PHC","PHR","PIT","PJT","PMG","PME","PNC","PNJ","POM","PPC","PPI","PTB","PTC","PTL","DAT","PVD","PVT","PXI","PXS","PXT","QBS","QCG","RAL","RDP","REE","RIC","SGN","SAM","SAV","SBA","SAB","SBT","SC5","SCD","SCR","SCS","SFC","SFG","SFI","SGR","SGT","SHA","SHI","SHP","SBV","SII","SJD","SJF","SJS","SKG","SLD","SMA","SMB","SMC","SPM","SRC","SRF","S4A","SSC","SSI","ST8","STB","STG","SVC","SVI","SVT","SZL","TAC","AST","TBC","TCB","TCL","TCM","TCO","TCR","FUCVREIT","TCT","TDC","TDG","TDH","TDW","TEG","TGG","THG","THI","TIE","TIP","TIX","TLD","TLG","TLH","TMP","TMS","TMT","TNA","TNC","TNI","TNT","TPB","TPC","TRA","TCD","TRC","TVB","TS4","TSC","TTB","TTF","HUB","FUCTVGF1","TVS","TYA","UDC","UIC","VAF","VCB","VCF","VCI","VDS","VFG","VHC","VHG","VIC","TVT","VID","VDP","VJC","VIP","VPS","VIS","VMD","VND","VNE","VNG","VNL","VNM","VPD","VNS","VOS","VPB","VPG","VPH","VPK","VPI","VRC","VRE","VSC","VSH","VSI","VTB","VTO","YBM","YEG","VNINDEX"]

data = {
	"model.downloadType":"$HP_DL_TYPE$",
	"searchMarketStatisticsView.symbol":"CODE",
	"strFromDate":"23/12/2009",
	"strToDate":"21/02/2020"
}
#price_data = requests.post(url,data=data,headers=headers)
data["searchMarketStatisticsView.symbol"] = "AAA"
print(data)
