//
//  IndexFuctionApi.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#ifndef CaiLiFang_IndexFuctionApi_h
#define CaiLiFang_IndexFuctionApi_h

// 首页banner
#define GetBanner2 @"http://app.myfund.com:8484/Service/DemoService.svc/GetBanner2?type=1"

//优惠劵
#define IFyouhuijuan @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CouponsState?username=%@&Status=%@"
#define GetPrivateproductsList @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetPrivateproductsList?sdzjnumber=%@"
#define CouponsState @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CouponsState?username=%@&Status=%@" // 优惠劵
#define OrderFinancingNew @"http://app.myfund.com:8484/Service/MyfundDemo.svc/OrderFinancingNew?username=%@"
#define GetPrivateFund4APPOther2 @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetPrivateFund4APPOther2"      // 私募 其他人都在买
#define CheckIsSteward @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CheckIsSteward?sdzjnumber=%@&username=%@"  // 是否预约管家通



#define HOTFUND "http://app.myfund.com:8484/Service/MyfundDemo.svc/GetHotfundList2"
#define INCOME "http://app.myfund.com:8484/Service/MyfundDemo.svc/GetSpecfixList"
#define INCOMESINGER "http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=09"

//优选30
#define BESTCHOOSE @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetHotfundList30?type=%d"
//私募基金接口换了
#define MYFUND "http://app.myfund.com:8484/Service/MyfundDemo.svc/GetPrivateFund4APP"
#define FREEBUY "http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=08"
#define FUNDASSIGN "http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=05"
#define HIGHTMADE "http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=06"


//私募基金预约
#define POINTMENT "http://app.myfund.com:8484/Service/MyfundDemo.svc/GetAppointmentFundInfoNew?&productname=%@&username=%@"

#define GETUSERINFO @"%@/appwebnew/ws/webapp-clientspace/getDctVipInfoForOne?idcard=%@"
#define APPLYBUY @"%@/appwebnew/ws/webapp-clientspace/getTradeInfo?idcard=%@"

#define FundGetPrivateFundInfo @"%@/Service/MyfundDemo.svc/GetPrivateFundInfo?Fundcode=%@"
#define FundGetProductCode @"%@/Service/MyfundDemo.svc/GetProductCode?proCode=%@"

#define FundGetEquitychart @"%@/Service/MyfundDemo.svc/GetEquitychart?Fundcode=%@"

#define FundGetHistoryrate @"%@/Service/MyfundDemo.svc/GetHistoryrate?Fundcode=%@"

#define FundGetFundCompany @"%@/Service/MyfundDemo.svc/GetFundCompany?CompCode=%@"

#define FundGetSellingProducts @"%@/Service/MyfundDemo.svc/GetSellingProducts?CompCode=%@"

#define FundGetFundManager @"%@/Service/MyfundDemo.svc/GetFundManager?PersonID=%@"

#define FundGetCurrentProduct @"%@/Service/MyfundDemo.svc/GetCurrentProduct?PersonID=%@"


// 提现
//
#define GETPOINTBACK @"%@/appwebnew/ws/webapp-clientspace/getPointBackRecordFoApp?idcard=%@"
#define GETBANKACCOUNT @"%@/appwebnew/ws/webapp-clientspace/getAccountBankList?idcard=%@"
#define MYSCREEN [[UIScreen mainScreen]applicationFrame]
#define CANGETM @"%@/appwebnew/ws/webapp-clientspace/checkMemberDealTime?idcard=%@"
#define GETMONEYFROMBANK @"%@/appwebnew/ws/webapp-clientspace/addPointRecord?idcard=%@&point=%@&depositacct=%@"
#define CANCELGETMONEY @"%@/appwebnew/ws/webapp-clientspace/chexiaoPointBackRecord?idcard=%@&cancelId=%@"
#define SEARCHKET @"http://app.myfund.com:8484/Service/DemoService.svc/GetFundKeywordMate?InputFundPartValue=%@"
#define VERIFYNUM @"%@/appwebnew/ws/webapp-cxf/findMobileno?mobileno=%@"  //
#define TICKET @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CouponsState?username=%@&Status=0"
#define ONLINEPAY @"http://www.myfund.com/yeeappay/paypre.aspx?ophone=%@&osource=APP&ousername=%@&oJiangLi=%@&opid=1&op3_Amt=%ld&orid=4&op5_Pid=%@&oTuiJianR=%@&yhq=%@"
#define BANKPAY @"http://app.myfund.com:8484/Service/MyfundDemo.svc/OpenDianCaiTong3?username=%@&name=%@&JiangLi=%@&UMobile=%@&PaymentMethod=1&op3_Amt=%d&Referral=%@&yhq=%@"

#define MEMBERPAY @"http://app.myfund.com:8484/Service/MyfundDemo.svc/OpenDianCaiTongbycardNew?CardNum=%@&Cardmi=%@&username=%@&name=%@&JiangLi=一年期会员/￥399&UMobile=%@&PaymentMethod=3&Amt=0&Referral=%@&PassDT=%@&DueDT=%@"


#define AGREEMENT @"http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=07"
//判断是否是点财通会员
#define ISMEMEBER @"http://app.myfund.com:8484/Service/MyfundDemo.svc/huiyuanpanduan?Username=%@"
#define ISOPENACCOUNT @"%@/appwebnew/ws/webapp-cxf/findMobileno?mobileno=%@"
//展恒账号登陆
#define ACCOUNTLOGIN @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetAPPUserLoginDES?UserName=%@&PassWord=%@"
//获取个人信息
#define GETUSERDETAILINFO @"http://app.myfund.com:8484/Service/DemoService.svc/GetUserInfoDES?UserName=%@"
//交易系统登录apptrade.myfund.com:8000
#define DEALLOGIN @"%@/appwebnew/ws/webapp-cxf/validLoginDES?id=%@&passwd=%@"
//以身份账号获取个人信息
#define GETUSERDETAILINFOBYID @"%@/Service/MyfundDemo.svc/IDCardToUserInfoDES?IDcard=%@"
//个人基金持有详情getHoldFundsnew?sessionId=
#define PERSONFUNDDETAIL @"%@/appwebnew/ws/webapp-cxf/getHoldFundsnew?sessionId=%@"
//交易验证登陆
#define USERLOGIN @"%@/appwebnew/ws/webapp-cxf/userloginDES?idcard=%@"
//风险测评
///appwebnew/ws/webapp-cxf/getQuestionnew?sessionId=&papercode=&pointList=&iscontinue=&answer=&invtp=
#define RISKLEVEL @"%@/appwebnew/ws/webapp-cxf/getQuestionnew?sessionId=%@&papercode=%@&pointList=%@&iscontinue=%@&answer=%@&invtp=%@"
//风险测评提交

//通过idcard判断是否开户
#define ISOPENACCOUTBYIDCARD @"%@/appwebnew/ws/webapp-cxf/getOpenAccountStatus?certificateno=%@&depositacct=&certificatetype=0"

//小额打款验证http://apptrade.myfund.com:8080/appwebnew/ws/webapp-cxf/qrySmallMoney?certificateno=%@&depositacct=%@&depositacctname=%@&certificatetype=0&channelid=%@
#define QRYSMALLMONEY @"%@/appwebnew/ws/webapp-cxf/qrySmallMoney?certificateno=%@&depositacct=%@&depositacctname=%@&certificatetype=0&channelid=%@"
//    //http://ip:port/appwebnew/ws/webapp-cxf/qrySmallMoney?certificateno=&depositacct=&depositacctname=&certificatetype=&channelid=

#define DINGTOU @"%@/appwebnew/ws/webapp-cxf/getFundTotalInfonew?sessionId=%@&condition=%@&pagesize=%@&startindex=%@"
//基金赎回
#define FUNDGETBACK @"%@/appwebnew/ws/webapp-cxf/getHoldFundsnew?sessionId=%@"

 //查询基金详细信息

// 基金赎回
#define SELLFUND @"%@/appwebnew/ws/webapp-cxf/sellFundnewDES?sessionId=%@&passwd=%@&fundcode=%@&applicationamount=%@&fundtype=%@&fundstatus=%@&tano=%@&transactionaccountid=%@&vastredeemflag=%@"
//查询基金
#define fundSearchnew @"%@/appwebnew/ws/webapp-cxf/fundSearchnew?sessionId=%@&company=%@&fundType=%@&condition=%@"
//交易查询
#define searchTradesnew @"%@/appwebnew/ws/webapp-cxf/searchTradesnew?sessionId=%@"
//查询银行卡
#define GETMyDqdeBankList @"%@/appwebnew/ws/webapp-cxf/getMyDqdeBankListnew?sessionId=%@"
//撤单
#define deleteTradesnew @"%@/appwebnew/ws/webapp-cxf/deleteTradesnew?sessionId=%@&originalappsheetno=%@"
#define searchSavePlanListnew @"%@/appwebnew/ws/webapp-cxf/searchSavePlanListnew?sessionId=%@&saveplanflag=1"
//定投终止确认
#define deleteSavePlan @"%@/appwebnew/ws/webapp-cxf/deleteSavePlannew?sessionId=%@&saveplanno=%@&transactionaccountid=%@&depositacct=%@&direction=B&branchcode=%@&channelid=%@"
#define queryAssetsnew @"%@/appwebnew/ws/webapp-cxf/queryAssetsnew?sessionId=%@&businessflag=%@"

//@"%@appweb/ws/webapp-cxf/setDefdividendMethod?id=%@&passwd=%@&transactorcerttype=&fundcode=%@&transactionaccountid=%@&ratio=1&branchcode=%@&dividendmethod=%@&transactorname=&transactorcertno="
//更改分红方式
#define setDefdividendMethodnew @"%@/appwebnew/ws/webapp-cxf/setDefdividendMethodnew?sessionId=%@&transactorcerttype=&fundcode=%@&transactionaccountid=%@&ratio=1&branchcode=%@&dividendmethod=%@&transactorname=&transactorcertno="
//申请查询
#define searchHisAppnew @"%@/appwebnew/ws/webapp-cxf/searchHisAppnew?sessionId=%@&begindate=%@&enddate=%@"
//修改邮箱
#define upemail @"%@/Service/DemoService.svc/GetUserInfoUpdate?UserName=%@&Realname=%@&Mobile=%@&Sex=%@&IDCard=%@&Email=%@"
//历史查询
#define searchHisAcknew @"%@/appwebnew/ws/webapp-cxf/searchHisAcknew?begindate=%@&enddate=%@&sessionId=%@"
// 银行列表
#define getAllBankList @"%@/appwebnew/ws/webapp-cxf/getALLBankList"
//开户
#define openAccountParamMap @"%@/appwebnew/ws/webapp-cxf/openAccountDES?paramMap=%@"

#define querybankCode @"%@/appwebnew/ws/webapp-cxf/querybankCode?paracity=%@&channelid=%@"
//持仓信息
#define  ChiCang @"%@/appwebnew/ws/webapp-clientspace/getFund?idcard=%@"
//开户信息同步 // 固收 更新用户信息
#define sysuserinfo @"%@/Service/MyfundDemo.svc/UpdateCMSDES?DisplayName=%@&Mobile=%@&IDcard=%@"

//快钱验证码获取
#define identifySend @"%@/appwebnew/ws/webapp-cxf/identifySendLog?channelid=%@&channelname=%@&certificateno=%@&depositacct=%@&depositacctname=%@&mobiletelno=%@&hometelno=%@&Keep_phone_num1=%@&source=iOS获取验证码Myfund&groupId=%@"

// 验证码 验证是否正确
#define verifySend @"%@/appwebnew/ws/webapp-cxf/verifySendLog?channelid=%@&channelname=%@&certificateno=%@&depositacct=%@&depositacctname=%@&mobiletelno=%@&hometelno=%@&Keep_phone_num1=%@&token=%@&keep_phone_code_num1=%@&source=iOS核对验证码Myfund&groupId=%@"


#define updateAccountRiskLevelnew @"%@/appwebnew/ws/webapp-cxf/updateAccountRiskLevelnew?sessionId=%@&papercode=%@&pointList=%@&iscontinue=%@&answer=%@&invtp=%@"
#define apptrade8484 @"http://app.myfund.com:8484"
#define apptrade8383 @"http://app.myfund.com:8383"
#define appsms8000 @"http://sms.myfund.com:8000"


#define apptradeLocal @"https://apptrade.myfund.com:9000"
#define apptrade8000 @"https://apptrade.myfund.com:9000"

/*
 * 测试端口********************************************
 */

//http://10.20.25.197:8080/appwebnew
//本地服务器http://10.20.24.98:8080/

//#define apptrade8000 @"http://10.20.24.122:8090"
//#define apptradeLocal @"http://10.20.24.122:8090"
//10.20.30.6
//10.20.24.122:8080


// 新容器 测试
//#define apptradeLocal @"https://shendeng.myfund.com:80"
//#define apptrade8000 @"https://shendeng.myfund.com:80"
/*
 * 测试端口********************************************
 */


/*
 * 加密 KEY
 */

#define ENCRYPT_KEY @"MyFund0k"

//请求验证码 端口
//// 块钱短信验证码 验证是否正确 接口


#define appradeSendMsg @"https://apptrade.myfund.com:8383"
#define SEND_MSG @"%@/appweb/ws/webapp-cxf/randomNum"


//配资会员判断
#define IFpeizi @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CheckIsFinancing2_0?username=%@&sdzjnumber=%@"



//*******************************整理接口*************************************************//
//**************************************************************************************//


#define ZHCheckUserInfoURL @"%@appweb/ws/webapp-cxf/checkInfo?certificateno=%@&custname=%@&certificatetype=%@&mobileno=%@",ZHServerAddress

//获取验证码 接口
#define ZHGetRandomCodeURL @"%@appweb/ws/webapp-cxf/randomNum",ZHServerAddress
#define ZHSendMsgURL @"%@appweb/ws/webapp-cxf/sendMsg?mobileno=%@&saveInfo=&custno=%@&Random=%@",ZHServerAddress


#define kAddCommentsUrl @"%@Service/DemoService.svc/GetFundReviewUpdate?UserName=%@&FundCode=%@&FundName=%@&FundReview=%@"

#define kUpAdviceUrl @"%@Service/DemoService.svc/GetCusSuggest?Mobile=%@&FundReview=%@"

#define kGetCommentsUrl @"%@Service/DemoService.svc/GetFundReview?fundcode=%@"

#define kCorrectPhoneUrl @"%@Service/DemoService.svc/GetMobileUpdate?UserName=%@&Mobile=%@"

#define kPopCheckUrl @"http://sms.myfund.com:8000/javaDemo/CheckCodeServlet/sendOneMsgApp.do?Mobile=%@&Content=您好！您在展恒获取的手机验证码是%d，加入展恒点财通，可免认申购费，详情可电话咨询4008886661【展恒基金】"


#define kModifyPasswordUrl @"http://app.myfund.com:8484/Service/DemoService.svc/GetPassWord?UserName=%@&Mobile=%@&PassWord=%@"


#define kForgetNextUrl @"%@Service/DemoService.svc/ForgetPassWord?Mobile=%@&PassWord=%@"

#define kUseHelpUrl @"http://app.myfund.com:8484/Service/DemoService.svc/GethelpContent"

#define api @"http://sms.myfund.com:8000/data-platform/webservice/web/setFinanceInfo?idcard=%@&guaranteemon=%@&ratio=%@&term=%@"

#define CountForIOS @"http://app.myfund.com:8484/Service/DemoService.svc/myfundCountForIOS"

#define api2 @"http://sms.myfund.com:8000/data-platform/webservice/web/getAdoptFinanceInfo?idcard=%@"

#define  apizhifu @"http://www.myfund.com/yeeappay/paypre.aspx?ophone=%@&osource=APP&ousername=%@&oJiangLi=%@/￥%@&opid=1&op3_Amt=%@&orid=4&op5_Pid=展恒点财通&oTuiJianR=&yhq=%@"

#define DRTapi @"http://app.myfund.com:8484/Service/MyfundDemo.svc/OrderStewardNew?username=%@"

#define DINGTOUEVERY @"%@appweb/ws/webapp-cxf/getRatefee?id=%@&passwd=%@&sharetype=%@&fundcode=%@&applicationamount=%@&businesscode=%@&applicationvol=%@&tano=%@&channelid=%@"

#define FUNDEVEYTWO @"%@/appwebnew/ws/webapp-cxf/checkBeforeAutoSavePlannewDES?sessionId=%@&passwd=%@&moneyaccount=%@&firstinvestamount=%@&continueinvestamount=%@&firstinvestdate=%@&channelid=%@&saveplanflag=%@&investmode=%@&tano=%@&investcyclevalue=%@&investcycle=%@&fundcode=%@&certificateno=%@&investperiods=%@&depositacct=%@&buyflag=%@&riskmatching=%@&investperiodsvalue=%@&paycenterid=%@&certificatetype=%@"


#define FUNDEVEYTURL @"%@/appwebnew/ws/webapp-cxf/signSendnew?sessionId=%@&certIdLength=%@&fundcode=%@&saveplanno=%@&moneyaccount=%@&applicationamount=%@&fundname=%@&signInfo=%@"

#define FUNDREDM @"%@appwebnew/ws/webapp-cxf/getFundTotalInfonew?sessionId=%@&condition=%@"

#define FUNDTRENDV @"%@Service/DemoService.svc/GetFundDetailInfoNew?InputFundValue=%@"

#define FUNDTRENDVI @"%@Service/DemoService.svc/GetFundDetailInfo%d?inputFundValue=%@&UnityDate=%d"

#define FUNDGet5unitEquity @"%@Service/DemoService.svc/Get5unitEquity?count=10&InputFundValue=%@"

#define  GetStewardInfoApi @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetStewardInfo?sdzjnumber=%@"

#define TuiJiangBanner @"http://app.myfund.com:8484/Service/MyfundDemo.svc/TuiJiangBanner?type=1"

#define knockTicket @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetQuanList"

#define chkSmallMoney @"%@/appwebnew/ws/webapp-cxf/chkSmallMoney?amount=%@&certificateno=%@&moneyaccount=%@&depositacct=%@&custno=%@&depositacctname=%@&channelid=%@&certificatetype=%@"


#define paypreaspx @"http://www.myfund.com/yeeappay/paypre.aspx?ophone=%@&osource=APP&ousername=%@&oJiangLi=会员费(380元/年)&opid=1&op3_Amt=380&orid=9&op5_Pid=展恒点融通&oTuiJianR="

#define UpdatePaymentMethod @"http://app.myfund.com:8484/Service/MyfundDemo.svc/UpdatePaymentMethod?PaymentMethod=1&username=%@"

#define WhetherToPay @"http://app.myfund.com:8484/Service/MyfundDemo.svc/WhetherToPay?username=%@"



//*******************************添加接口*************************************************//
//**************************************************************************************//

#define Height_mainScreen [[UIScreen mainScreen] bounds].size.height
#define Width_mainScreen [[UIScreen mainScreen] bounds].size.width

/**
 *  固守 恒得利  恒有才
 */

/*恒得利 合同*/
#define HENGDELI_congtract @"http://m.myfund.com/Ccenter/chdl_xieyi.html";
#define HENGDELI_qustion @"http://m.myfund.com/hdl/chdl_question.html";

/*恒有才 合同*/
#define HENGYOUCAI_congtract @"http://m.myfund.com/Hyc/xieyi.html";
#define HENGYOUCAI_qustion @"http://m.myfund.com/Hyc/chyc_question.html";




//固守在线支付 接口
#define GUSHOU_OnlinPaty @"http://www.myfund.com/yeeappay/paypre.aspx?ophone=%@&osource=APP&ousername=%@&oJiangLi=%@&opid=%@&op3_Amt=%@&orid=%@&op5_Pid=%@&oTuiJianR=%@&yhq="

// 银行汇款接口
#define GUSHOU_Banker @"http://app.myfund.com:8484/Service/MyfundDemo.svc/BankHuikuanPayHdlHyc?username=%@&name=%@&Level=%@&UMobile=%@&PaymentMethod=1&op3_Amt=%@&Referral=%@&Pid=%@&ApplyFrom=APP&RoleID=%@"

// 固守产品已售出份额
#define GUSHOUProductSell @"http://app.myfund.com:8484/Service/MyfundDemo.svc/GetFixedSaled?id=%@"
#define GSHengLI @"http://sms.myfund.com:8000/data-platform/webservice/web/TheCurrentProduct?procode=hdl"
#define GSHengYouCai @"http://sms.myfund.com:8000/data-platform/webservice/web/TheCurrentProduct?procode=hyc"


//新： 判断手机号是否注册
#define new_VerfyPhoneNumber @"http://app.myfund.com:8484/Service/MyfundDemo.svc/CheckCMSMobile?Mobile=%@"


//登陆注册
#define NEW_REGISGER @"%@/Service/MyfundDemo.svc/GetAPPUserRegistDES?Mobile=%@&PassWord=%@"

//发送验证码
#define dctMessage @"%@/data-platform/webservice/web/dctMessage?phone=%@&code=%d&tempid=dct_msg2"

//启用短信验证码日志后新的 发送验证码接口
#define dctMessageNew @"%@/data-platform/webservice/web/dct_Message2?phone=%@&code=%d&tempid=dct_msg2&source=iOS开户Myfund&groupId=%@&address=%@"

// 发送验证码日志
#define MessageLogInfo @"%@/Service/MyfundDemo.svc/MessageLogInfo?mobile=%@&status=%@&source=iOS开户Myfund&Remarks=%@&stepNum=%@&groupID=%@&ipAddress=%@"



#define RECOMMEND @"%@/Service/MyfundDemo.svc/GetHotfundList2"  // 展恒推荐

// 购买 查找查询
#define BUYFUYNDNEW @"%@/appwebnew/ws/webapp-cxf/getFundListnew?sessionId=%@&condition=%@&pagesize=%@&startindex=%d"


#define BANK @"%@/appwebnew/ws/webapp-cxf/getMyActiveBankListnew?sessionId=%@" // 银行代扣信息
#define REMIT @"%@/appwebnew/ws/webapp-cxf/getMyHKBankListnew?sessionId=%@"  // 汇款支付
#define MAKEDATE @"%@/appwebnew/ws/webapp-cxf/buyFundStepnewDES?sessionId=%@&passwd=%@&fundcode=%@&applicationamount=%@&fundtype=%@&fundstatus=%@&sharetype=%@&channelid=%@&tano=%@&moneyaccount=%@&buyflag=%@&paytype=%@"  // 下单接口 新
#define PAYFOR  @"%@/appwebnew/ws/webapp-cxf/readyPayStepnew?sessionId=%@&certIdLength=%@&applicationamount=%@&fundtype=%@&fundstatus=%@&channelid=%@&tano=%@&moneyaccount=%@&liqdate=%@&fundcode=%@&appsheetserialno=%@&fundname=%@" // 支付接口
#define SENDMESSAGE @"%@/appwebnew/ws/webapp-cxf/sendMsg?mobileno=%@&saveInfo=&custno=%@&Random=%@"  // 更改绑定手机号发送 验证码
#define PHONEPEFRSONAL @"%@/appwebnew/ws/webapp-clientspace/updateMobileno?certificateno=%@&mobileno=%@" // 更改个人空间绑定手机号

#define TRANSFUND @"%@/appwebnew/ws/webapp-cxf/changeFundnewDES?sessionId=%@&passwd=%@&fundcode=%@&applicationamount=%@&transactionaccountid=%@&targetfundcode=%@&tano=%@"                            //基金转换

#define TRANSCHECK @"%@/appwebnew/ws/webapp-cxf/getHoldFundsnew?sessionId=%@"                          // 查询可转换基金
#define TRANSTOTARKETSFUND @"%@/appwebnew/ws/webapp-cxf/getchangeToFundnew?sessionId=%@&fundcode=%@&tano=%@&sharetype=%@" //转换成目标基金

#define LITTLEMONEYCONFIRM @"%@/appwebnew/ws/webapp-cxf/smallMoney?depositacctprov=%@&certificateno=%@&depositacct=%@&subbankno=8867&depositacctcity=%@&depositacctname=%@&channelid=%@&certificatetype=0"            // 小额打款验证

#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]


// 主页无sessionid 基金搜索
#define HOMESEARCHFOUND @"%@/Service/DemoService.svc/GetFundKeywordMate?InputFundPartValue=%@"
#define NEWHOTFUND @"%@/Service/MyfundDemo.svc/GetHotfundList3?UserName=%@"
//主页 有sessionid 搜索
#define HOMESEARCHWITHUSERNAME @"%@/Service/DemoService.svc/GetFundKeywordMate1?InputFundPartValue=%@&UserName=%@"
#define HOMEFIRSTFOUND @"%@/Service/MyfundDemo.svc/GetIndexFundList?type=%d" // 主页基金： 1为热销 2 为投资热点


//**字符串转UTF**//
#define NSSTRING_TRANSTO_UTF8(string)  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, NULL, kCFStringEncodingUTF8));

/*
 * 基金资讯模块
 */
#define FUNDNEWS @"%@/Service/DemoService.svc/GetFundNews2?newstype=1" //1 为最新资讯  2 为展恒快讯 3基金公告 4活动公告
#define FUNDSTUDYNEWS @"%@/Service/DemoService.svc/GetFundNews2?newstype=2" // 1.专题文章 2宏观策略 3经济策略 4投资策略
#define FUND_DETAILEDNEWS @"%@/Service/DemoService.svc/GetContents2?id=%@"




#endif