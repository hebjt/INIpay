<%------------------------------------------------------------------------------
 FILE NAME : INIsecurestart.jsp
 AUTHOR : ts@inicis.com
 DATE : 2007/08
 USE WITH : config.jsp, INIpay50.jar
 
 이니페이 플러그인을 이용하여 지불을 요청한다.
 
 Copyright 2007 Inicis, Co. All rights reserved.
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<title>INIpay50 결제페이지 데모</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body,tr,td {
	font-size: 10pt;
	font-family: 굴림, verdana;
	color: #433F37;
	line-height: 19px;
}

table,img {
	border: none
}

/* Padding ******/
.pl_01 {
	padding: 1 10 0 10;
	line-height: 19px;
}

.pl_03 {
	font-size: 20pt;
	font-family: 굴림, verdana;
	color: #FFFFFF;
	line-height: 29px;
}

/* Link ******/
.a:link {
	font-size: 9pt;
	color: #333333;
	text-decoration: none
}

.a:visited {
	font-size: 9pt;
	color: #333333;
	text-decoration: none
}

.a:hover {
	font-size: 9pt;
	color: #0174CD;
	text-decoration: underline
}

.txt_03a:link {
	font-size: 8pt;
	line-height: 18px;
	color: #333333;
	text-decoration: none
}

.txt_03a:visited {
	font-size: 8pt;
	line-height: 18px;
	color: #333333;
	text-decoration: none
}

.txt_03a:hover {
	font-size: 8pt;
	line-height: 18px;
	color: #EC5900;
	text-decoration: underline
}
</style>

<script>
	var openwin=window.open("childwin.html","childwin","width=299,height=149");
	openwin.close();
	
	function show_receipt(tid) // 영수증 출력
	{
		if(<%=inipay.GetResult("ResultCode")%> == "00")
		{
			var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=<%=inipay.GetResult("tid")%>&noMethod=1";
			window.open(receiptUrl,"receipt","width=430,height=700");
		}
		else
		{
			alert("해당하는 결제내역이 없습니다");
		}
	}
		
	function errhelp() // 상세 에러내역 출력
	{
		var errhelpUrl = "http://www.inicis.com/ErrCode/Error.jsp?result_err_code=<%=inipay.GetResult("ResultErrorCode")%>&mid=<%=inipay.GetResult("MID")%>&tid=<%=inipay.GetResult("tid")%>"+
		"&goodname=<%=inipay.GetResult("goodname")%>&price=<%=inipay.GetResult("price")%>&paymethod=<%=inipay.GetResult("PayMethod")%>&buyername=<%=inipay.GetResult("buyerName")%>"+
		"&buyertel=<%=inipay.GetResult("buyertel")%>&buyeremail=<%=inipay.GetResult("buyeremail")%>&codegw=<%=inipay.GetResult("HPP_GWCode")%>";
		window.open(errhelpUrl, "errhelp",
				"width=520,height=150, scrollbars=yes,resizable=yes");
	}
</script>

<script language="JavaScript" type="text/JavaScript">
<!--
	function MM_reloadPage(init) { //reloads the window if Nav4 resized
		if (init == true)
			with (navigator) {
				if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
					document.MM_pgW = innerWidth;
					document.MM_pgH = innerHeight;
					onresize = MM_reloadPage;
				}
			}
		else if (innerWidth != document.MM_pgW
				|| innerHeight != document.MM_pgH)
			location.reload();
	}
	MM_reloadPage(true);
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0>
	<center>
		<table width="632" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="85" background=${bg_img} style="padding: 0 0 0 64">
					<!-------------------------------------------------------------------------------------------------------
 *
 *  아래 부분은 모든 결제수단의 공통적인 결과메세지 출력 부분입니다.
 *
 *  1. inipay.GetResult("ResultCode")  (결 과 코 드)
 *  2. inipay.GetResult("ResultMsg")   (결과 메세지)
 *  3. inipay.GetResult("PayMethod")   (결 제 수 단)
 *  4. inipay.GetResult("TID")         (거 래 번 호)
 *  5. inipay.GetResult("MOID")        (주 문 번 호)
 -------------------------------------------------------------------------------------------------------->

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
							<td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>결제결과</b></font></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" bgcolor="6095BC">
					<table width="620" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td bgcolor="#FFFFFF" style="padding: 0 0 0 56">
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="7"><img src="img/life.gif" width="7" height="30"></td>
										<td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10"> <!-------------------------------------------------------------------------------------------------------
                 * 1. inipay.GetResult("ResultCode") 										*	
                 *       가. 결 과 코 드: "00" 인 경우 결제 성공[무통장입금인 경우 - 고객님의 무통장입금 요청이 완료]	*
                 *       나. 결 과 코 드: "00"외의 값인 경우 결제 실패  						*
                 --------------------------------------------------------------------------------------------------------> <b>${rs_msg}</b></td>
										<td width="8"><img src="img/right.gif" width="8" height="30"></td>
									</tr>
								</table> <br>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="407" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">결제내역</font></strong></td>
										<td width="103">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2" style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>

													<!-------------------------------------------------------------------------------------------------------
                 * 2. inipay.GetResult("PayMethod")
                 *       가. 결제 방법에 대한 값
                 *       	1. 신용카드 	- 	Card
                 *       	2. ISP		-	VCard
                 *       	3. 은행계좌	-	DirectBank
                 *       	4. 무통장입금	-	VBank
                 *       	5. 핸드폰	- 	HPP
                 *       	6. 전화결제 (ars전화 결제)	-	Ars1588Bill
                 *       	7. 전화결제 (받는전화결제)	-	PhoneBill
                 *       	8. OK CASH BAG POINT		-	OCBPoint
                 *       	9. 문화상품권			-	Culture
                 *       	10. 틴캐시 결제 		- 	TEEN
                 *       	11. 게임문화 상품권 		-	DGCL
                 *       	12. 도서문화 상품권 		-	BCSH
                 *-------------------------------------------------------------------------------------------------------->
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">결 제 방 법</td>
													<td width="343">${paymethod}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="26">결 과 코 드</td>
													<td width="343"><table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>${resultCode}</td>
																<td width='142' align='right'>
																	<!-------------------------------------------------------------------------------------------------------
                 * 3. inipay.GetResult("ResultCode") 값에 따라 "영수증 보기" 또는 "실패 내역 자세히 보기" 버튼 출력		*
                 *       가. 결제 코드의 값이 "00"인 경우에는 "영수증 보기" 버튼 출력					*
                 *       나. 결제 코드의 값이 "00" 외의 값인 경우에는 "실패 내역 자세히 보기" 버튼 출력			*
                 --------------------------------------------------------------------------------------------------------> <!-- 실패결과 상세 내역 버튼 출력 -->
                 						<c:if test="${resultCode=='00'}">
                 									<a href='javascript:show_receipt();'><img src='img/button_02.gif' width='94' height='24' border='0'></a>
                 						</c:if>
                 						<c:if test="${resultCode!='00'}">
                 									<a href='javascript:errhelp();'><img src='img/button_01.gif' width='142' height='24' border='0'></a>
                 						</c:if>
																	
																</td>
															</tr>
														</table></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 4. inipay.GetResult("ResultMsg") 										*
                 *    - 결과 내용을 보여 준다 실패시에는 "[에러코드] 실패 메세지" 형태로 보여 준다.                     *
                 *		예> [9121]서명확인오류									*
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">결 과 내 용</td>
													<td width="343">${resultmsg}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 5. inipay.GetResult("tid")											*
                 *    - 이니시스가 부여한 거래 번호 -모든 거래를 구분할 수 있는 키가 되는 값			        *
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">거 래 번 호</td>
													<td width="343">${tid}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 6. inipay.GetResult("MOID")											*
                 *    - 상점에서 할당한 주문번호 									*
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">주 문 번 호</td>
													<td width="343">${moid}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 7. inipay.GetResult("TotPrice")										*
                 *    - 결제완료 금액                  									*
	 			 *																					*
	 			 * 결제 되는 금액 =>원상품가격과  결제결과금액과 비교하여 금액이 동일하지 않다면  *
	 			 * 결제 금액의 위변조가 의심됨으로 정상적인 처리가 되지않도록 처리 바랍니다. (해당 거래 취소 처리) *
	 			 *																									*
                 -------------------------------------------------------------------------------------------------------->

												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">결제완료금액</td>
													<td width="343">${totprice} 원</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

											<c:if test="${paymethod=='Card' or paymethod=='VCard'}">
											
											
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">신용카드번호</td>
													<td width="343">${CARD_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 번 호</td>
													<td width="343">${ApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">할 부 기 간</td>
													<td width="343">${CARD_Quota}개월&nbsp;<b> <font color=red> ${EventCode}</font></b></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">카 드 종 류</td>
													<td width="343">${CARD_Code}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">카드발급사</td>
													<td width="343">${CARD_BankCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td height="1" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="padding: 0 0 0 9" colspan="3"><img src="img/icon.gif" width="10" height="11"> <strong><font
															color="433F37">달러결제 정보</font></strong></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">통 화 코 드</td>
													<td width="343">${OrgCurrency}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">환 율</td>
													<td width="343">${ExchangeRate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td height="1" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="padding: 0 0 0 9" colspan="3"><img src="img/icon.gif" width="10" height="11"> <strong><font
															color="433F37">OK CASHBAG 적립 및 사용내역</font></strong></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">카 드 번 호</td>
													<td width="343">${OCB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">적립 승인번호</td>
													<td width="343">${OCB_SaveApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">사용 승인번호</td>
													<td width="343">${OCB_PayApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 일 시</td>
													<td width="343">${OCB_ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">포인트지불금액</td>
													<td width="343">${OCB_PayPrice}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

												<c:if test="${paymethod=='DirectBank'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">은 행 코 드</td>
													<td width="343">${ACCT_BankCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">현금영수증<br>발급결과코드
													</td>
													<td width="343">${CSHR_ResultCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">현금영수증<br>발급구분코드
													</td>
													<td width="343">${CSHR_Type} <font color=red><b>(0 - 소득공제용, 1 - 지출증빙용)</b></font></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>
	
											<c:if test="${paymethod=='VBank'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">입금계좌번호</td>
													<td width="343">${VACT_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">입금 은행코드</td>
													<td width="343">${VACT_BankCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">예금주 명</td>
													<td width="343">${VACT_Name}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">송금자 명</td>
													<td width="343">${VACT_InputName}</td>
												</tr>
												<!-- modify in 2007.11.23
                    		<tr> 
                    		  <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    		</tr>
                    		<tr> 
                    		  <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                    		  <td width="109" height="25">송금자 주민번호</td>
                    		  <td width="343"><%=(inipay.GetResult("VACT_RegNum"))%>
              </td>
                    		</tr>
                    		-->
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">상품 주문번호</td>
													<td width="343">${MOID}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">송금 일자</td>
													<td width="343">${VACT_Date}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">송금 시간</td>
													<td width="343">${VACT_Time}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

<c:if test="${paymethod=='HPP'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">휴대폰번호</td>
													<td width="343">${HPP_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
	</c:if>
												
							<c:if test="${paymethod=='Ars1588Bill'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">전 화 번 호</td>
													<td width="343">${ARSB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
							</c:if>
												
						<c:if test="${paymethod=='PhoneBill'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">전 화 번 호</td>
													<td width="343">${PHNB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
								</c:if>

												<c:if test="${paymethod=='OCBPoint'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">카 드 번 호</td>
													<td width="343">${OCB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 날 짜</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 시 각</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">적립 승인번호</td>
													<td width="343">${OCB_SaveApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">사용 승인번호</td>
													<td width="343">${OCB_PayApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">포인트지불금액</td>
													<td width="343">${OCB_PayPrice}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>


												<c:if test="${paymethod=='Culture'}">
												
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">컬쳐랜드 ID</td>
													<td width="343">${CULT_UserID}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

												<c:if test="${paymethod=='TEEN'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">틴캐시잔액</td>
													<td width="343">${TEEN_Remains}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">틴캐시아이디</td>
													<td width="343">${TEEN_UserID}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>
												<%
													}

													/*-------------------------------------------------------------------------------------------------------
													 *													*
													 *  아래 부분은 결제 수단별 결과 메세지 출력 부분입니다.    						*	
													 *													*
													 *  10.  게임문화 상품권 결제						                			*
													 -------------------------------------------------------------------------------------------------------*/
													else if ("DGCL".equals(inipay.GetResult("PayMethod"))) {
												%>
						<c:if test="${paymethod=='DGCL'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">사용한 카드 수</td>
													<td width="343"><%=(inipay.GetResult("GAMG_Cnt"))%> 장</td>
												</tr>

												<%
													/* 아래부분은 사용한 게임문화 상품권 번호와 잔액을 보여줍니다.(결제 실패시에는 잔액대신 에러메제지를 보여줍니다.) */
														/* 최대 6장까지 사용이 가능하며, 결제에 사용된 카드만 출력됩니다. */
														for (int i = 1; i <= Integer.parseInt(inipay.GetResult("GAMG_Cnt")); i++) {
												%>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">사용한 카드번호</td>
													<td width="343"><b><%=(inipay.GetResult("GAMG_Num" + i))%> </b></td>
												</tr>

												<%
													if (inipay.GetResult("ResultCode").equals("00")) {
												%>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">카드 잔액</td>
													<td width="343"><b><%=(inipay.GetResult("GAMG_Remains" + i))%> 원</b></td>
												</tr>
												<%
													} else {
												%>

												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">에러메세지</td>
													<td width="343"><b><%=(inipay.GetResult("GAMG_ErrMsg" + i))%> </b></td>
												</tr>
												
				
												<%
													}
														}
													}

													/*-------------------------------------------------------------------------------------------------------
													 *
													 *  아래 부분은 결제 수단별 결과 메세지 출력 부분입니다.
													 *
													 *  11.  도서문화 상품권 결제 (BCSH)
													 -------------------------------------------------------------------------------------------------------*/
													else if ("BCSH".equals(inipay.GetResult("PayMethod"))) {
												%>
					</c:if>
					<c:if test="${paymethod=='BCSH'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ID</td>
													<td width="343"><%=(inipay.GetResult("BCSH_UserID"))%></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
					</c:if>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table> <br> <!-------------------------------------------------------------------------------------------------------
 *
 *  결제 성공시(inipay.GetResult("ResultCode").equals("00"인 경우 ) "이용안내"  보여주기 부분입니다.
 *  결제 수단별로 이용고객에게 결제 수단에 대한 주의 사항을 보여 줍니다.
 *  switch , case문 형태로 결제 수단별로 출력 하고 있습니다.
 *  아래 순서로 출력 합니다.
 *
 *  1.	신용카드
 *  2.  ISP 결제
 *  3.  핸드폰
 *  4.  거는 전화 결제 (ARS1588Bill)
 *  5.  받는 전화 결제 (PhoneBill)
 *  6.	OK CASH BAG POINT
 *  7.  은행계좌이체
 *  8.  무통장 입금 서비스
 *  9.  문화상품권 결제
 *  10. 틴캐시 결제
 *  11. 게임문화 상품권 결제
 *  12. 도서문화 상품권 결제
 --------------------------------------------------------------------------------------------------------> <%
 	if (inipay.GetResult("ResultCode").equals("00")) {

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  1.  신용카드 						                			*
 				--------------------------------------------------------------------------------------------------------*/
 		if (inipay.GetResult("PayMethod").equals("Card")) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 신용카드 청구서에 <b>\"이니시스(inicis.com)\"</b>으로 표기됩니다.<br> (2) LG카드 및 BC카드의 경우 <b>\"이니시스(이용 상점명)\"</b>으로
														표기되고, 삼성카드의 경우 <b>\"이니시스(이용상점 URL)\"</b>로 표기됩니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(Card)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  2.  ISP 						                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("VCard".equals(inipay.GetResult("PayMethod"))) { // ISP
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 신용카드 청구서에 <b>\"이니시스(inicis.com)\"</b>으로 표기됩니다.<br> (2) LG카드 및 BC카드의 경우 <b>\"이니시스(이용 상점명)\"</b>으로
														표기되고, 삼성카드의 경우 <b>\"이니시스(이용상점 URL)\"</b>로 표기됩니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(VCard)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  3. 핸드폰 						                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("HPP".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 핸드폰 청구서에 <b>\"소액결제\"</b> 또는 <b>\"외부정보이용료\"</b>로 청구됩니다.<br> (2) 본인의 월 한도금액을 확인하시고자 할 경우 각 이동통신사의
														고객센터를 이용해주십시오.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(HPP)
 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  4. 전화 결제 (ARS1588Bill)				                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("Ars1588Bill".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 전화 청구서에 <b>\"컨텐츠 이용료\"</b>로 청구됩니다.<br> (2) 월 한도금액의 경우 동일한 가입자의 경우 등록된 전화번호 기준이 아닌 주민등록번호를 기준으로
														책정되어 있습니다.<br> (3) 전화 결제취소는 당월에만 가능합니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if (Ars1588Bill)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  5. 폰빌 결제 (PhoneBill)				                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("PhoneBill".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 전화 청구서에 <b>\"인터넷 컨텐츠 (음성)정보이용료\"</b>로 청구됩니다.<br> (2) 월 한도금액의 경우 동일한 가입자의 경우 등록된 전화번호 기준이 아닌
														주민등록번호를 기준으로 책정되어 있습니다.<br> (3) 전화 결제취소는 당월에만 가능합니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(PhoneBill)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  6. OK CASH BAG POINT					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("OCBPoint".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) OK CASH BAG 포인트 결제취소는 당월에만 가능합니다.</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if (OCBPoint)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  7. 은행계좌이체					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("DirectBank".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 고객님의 통장에는 이용하신 상점명이 표기됩니다.<br> (2) 결제에 대한 상세조회는 www.inicis.com의 왼쪽 상단 <b>\"사용내역 및 청구요금 조회\"</b>에서도
														확인가능합니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	} //if(DirectBank)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  8. 무통장 입금 서비스					                			*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("VBank".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1) 상기 결과는 입금예약이 완료된 것일뿐 실제 입금완료가 이루어진 것이 아닙니다.<br> (2) 상기 입금계좌로 해당 상품금액을 무통장입금(창구입금)하시거나, 인터넷 뱅킹 등을 통한 온라인 송금을
														하시기 바랍니다.<br> (3) 반드시 입금기한 내에 입금하시기 바라며, 대금입금시 반드시 주문하신 금액만 입금하시기 바랍니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(VBank)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  9. 문화상품권 결제					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("Culture".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 문화상품권을 온라인에서 이용하신 경우 오프라인에서는 사용하실 수 없습니다.<br> (2) 컬쳐캐쉬 잔액이 남아있는 경우, 고객님의 컬쳐캐쉬 잔액을 다시 사용하시려면 컬쳐랜드
														ID를 기억하시기 바랍니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  10. 틴캐시 결제					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("TEEN".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1)틴캐시는 인터넷 사이트 또는 PC방에서 자유롭게 사용할 수 있는 선불 결제수단입니다.<br> (2)틴캐시 카드번호 결제 : 틴캐시 카드 뒷면에 적힌 12자리 번호를 입력하여 결제하는 방식입니다.<br>
														(3)틴캐시 아이디 결제 : 틴캐시 사이트 (www.teencash.co.kr)에 회원가입 후 틴캐시 사이트에 접속하여 구매한 틴캐시 카드를 등록하여 이용하는 방식입니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}// if(TEEN)

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * 결제 성공시 이용안내 보여주기 			    						*	
 		 *													*
 		 *  11. 게임문화 상품권 결제				                				*
 			--------------------------------------------------------------------------------------------------------*/
 		else if ("DGCL".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1)게임문화 상품권은 상품권에 인쇄되어있는 스크래치 번호로 결제하는 방식입니다.<br> (2)게임문화 상품권 결제은 문화상품권(www.cultureland.co.kr)에서 구입 하실수 있습니다.<br>
														(3)게임문화 상품권은 최대 6장까지 사용이 가능합니다.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if(DGCL)
 		/*--------------------------------------------------------------------------------------------------------
 		 *
 		 * 결제 성공시 이용안내 보여주기
 		 *
 		 *  12. 도서문화상품권 결제
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("BCSH".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">이용안내</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) 도서문화상품권을 온라인에서 이용하신 경우 오프라인에서는 사용하실 수 없습니다.<br> (2) 잔액이 남아있을 경우, 북라이프 ID를 기억하여 추 후 다른 결제때 이용하십시오.
													</td>
												</tr>
												<tr>
													<td height="1" colspan="2" align="center" background="img/line.gif"></td>
												</tr>

											</table>
										</td>
									</tr>
								</table> <%
 	}//if (BCSH)
 	}//if(ResultCode.equals("00"))
 %> <!-- 이용안내 끝 -->

							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td><img src="img/bottom01.gif" width="632" height="13"></td>
			</tr>
		</table>
	</center>
</body>
</html>

