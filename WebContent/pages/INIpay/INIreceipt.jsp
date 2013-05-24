<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<title>INIpay50 현금영수증 발행 데모</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body,tr,td {
	font-size: 9pt;
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
	var openwin = window.open("childwin.action", "childwin",
			"width=299,height=149");
	openwin.close();

	function showreceipt() // 현금 영수증 출력
	{
		var showreceiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/Cash_mCmReceipt.jsp?noTid=${tid}"
				+ "&clpaymethod=22";
		window.open(showreceiptUrl, "showreceipt",
				"width=380,height=540, scrollbars=no,resizable=no");
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
				<td height="83" background="${cash_top}" style="padding: 0 0 0 64">
					<!-- // 지불수단에 따라 상단 이미지가 변경 된다 -->

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
							<td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>현금결제 영수증 발급결과</b></font></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td bgcolor="#FFFFFF" style="padding: 0 0 0 56">
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="7"><img src="img/life.gif" width="7" height="30"></td>
										<td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10"> <b>고객님께서 요청하신 현금영수증 발급 내용입니다. </b></td>
										<td width="8"><img src="img/right.gif" width="8" height="30"></td>
									</tr>
								</table> <br>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="407" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">발급내역</font></strong></td>
										<td width="103">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2" style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">

												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="26">결 과 코 드</td>
													<td width="343"><table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>${resultcode}</td>
																<td width='142' align='right'><a href='javascript:showreceipt();'><img src='img/button_02.gif' width='94'
																		height='24' border='0'></a></td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">결 과 내 용</td>
													<td width="343">${resultMsg}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">거 래 번 호</td>
													<td width="343">${tid}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">승 인 번 호</td>
													<td width="343">${applnum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>승 인 날 짜</td>
													<td width='343'>${appldate}</td>
												</tr>

												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>승 인 시 각</td>
													<td width='343'>${appltime}</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>총 현금결제금액</td>
													<td width='343'>${cshr_price} 원</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>공 급 가 액</td>
													<td width='343'>${rsup_price} 원</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>부 가 세</td>
													<td width='343'>${rtax} 원</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>봉 사 료</td>
													<td width='343'>${rsrvc_price} 원</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>
												<tr>
													<td width='18' align='center'><img src='img/icon02.gif' width='7' height='7'></td>
													<td width='109' height='25'>사 용 용 도</td>
													<td width='343'>${message}</td>
												</tr>
												<tr>
													<td height='1' colspan='3' align='center' background='img/line.gif'></td>
												</tr>


											</table>
										</td>
									</tr>
								</table> <br>
							</td>
						</tr>
					</table></td>
			</tr>
			<tr>
				<td><img src="img/bottom01.gif" width="632" height="13"></td>
			</tr>
		</table>
	</center>
</body>
</html>
