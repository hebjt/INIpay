<%------------------------------------------------------------------------------
 FILE NAME : INIsecurestart.jsp
 AUTHOR : ts@inicis.com
 DATE : 2007/08
 USE WITH : config.jsp, INIpay50.jar
 
 �̴����� �÷������� �̿��Ͽ� ������ ��û�Ѵ�.
 
 Copyright 2007 Inicis, Co. All rights reserved.
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<html>
<head>
<title>INIpay50 ���������� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body,tr,td {
	font-size: 10pt;
	font-family: ����, verdana;
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
	font-family: ����, verdana;
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
	
	function show_receipt(tid) // ������ ���
	{
		if(<%=inipay.GetResult("ResultCode")%> == "00")
		{
			var receiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?noTid=<%=inipay.GetResult("tid")%>&noMethod=1";
			window.open(receiptUrl,"receipt","width=430,height=700");
		}
		else
		{
			alert("�ش��ϴ� ���������� �����ϴ�");
		}
	}
		
	function errhelp() // �� �������� ���
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
 *  �Ʒ� �κ��� ��� ���������� �������� ����޼��� ��� �κ��Դϴ�.
 *
 *  1. inipay.GetResult("ResultCode")  (�� �� �� ��)
 *  2. inipay.GetResult("ResultMsg")   (��� �޼���)
 *  3. inipay.GetResult("PayMethod")   (�� �� �� ��)
 *  4. inipay.GetResult("TID")         (�� �� �� ȣ)
 *  5. inipay.GetResult("MOID")        (�� �� �� ȣ)
 -------------------------------------------------------------------------------------------------------->

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
							<td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>�������</b></font></td>
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
                 *       ��. �� �� �� ��: "00" �� ��� ���� ����[�������Ա��� ��� - ������ �������Ա� ��û�� �Ϸ�]	*
                 *       ��. �� �� �� ��: "00"���� ���� ��� ���� ����  						*
                 --------------------------------------------------------------------------------------------------------> <b>${rs_msg}</b></td>
										<td width="8"><img src="img/right.gif" width="8" height="30"></td>
									</tr>
								</table> <br>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="407" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">��������</font></strong></td>
										<td width="103">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2" style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>

													<!-------------------------------------------------------------------------------------------------------
                 * 2. inipay.GetResult("PayMethod")
                 *       ��. ���� ����� ���� ��
                 *       	1. �ſ�ī�� 	- 	Card
                 *       	2. ISP		-	VCard
                 *       	3. �������	-	DirectBank
                 *       	4. �������Ա�	-	VBank
                 *       	5. �ڵ���	- 	HPP
                 *       	6. ��ȭ���� (ars��ȭ ����)	-	Ars1588Bill
                 *       	7. ��ȭ���� (�޴���ȭ����)	-	PhoneBill
                 *       	8. OK CASH BAG POINT		-	OCBPoint
                 *       	9. ��ȭ��ǰ��			-	Culture
                 *       	10. ƾĳ�� ���� 		- 	TEEN
                 *       	11. ���ӹ�ȭ ��ǰ�� 		-	DGCL
                 *       	12. ������ȭ ��ǰ�� 		-	BCSH
                 *-------------------------------------------------------------------------------------------------------->
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${paymethod}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="26">�� �� �� ��</td>
													<td width="343"><table width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td>${resultCode}</td>
																<td width='142' align='right'>
																	<!-------------------------------------------------------------------------------------------------------
                 * 3. inipay.GetResult("ResultCode") ���� ���� "������ ����" �Ǵ� "���� ���� �ڼ��� ����" ��ư ���		*
                 *       ��. ���� �ڵ��� ���� "00"�� ��쿡�� "������ ����" ��ư ���					*
                 *       ��. ���� �ڵ��� ���� "00" ���� ���� ��쿡�� "���� ���� �ڼ��� ����" ��ư ���			*
                 --------------------------------------------------------------------------------------------------------> <!-- ���а�� �� ���� ��ư ��� -->
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
                 *    - ��� ������ ���� �ش� ���нÿ��� "[�����ڵ�] ���� �޼���" ���·� ���� �ش�.                     *
                 *		��> [9121]����Ȯ�ο���									*
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${resultmsg}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 5. inipay.GetResult("tid")											*
                 *    - �̴Ͻý��� �ο��� �ŷ� ��ȣ -��� �ŷ��� ������ �� �ִ� Ű�� �Ǵ� ��			        *
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ȣ</td>
													<td width="343">${tid}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 6. inipay.GetResult("MOID")											*
                 *    - �������� �Ҵ��� �ֹ���ȣ 									*
                 -------------------------------------------------------------------------------------------------------->
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ȣ</td>
													<td width="343">${moid}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

												<!-------------------------------------------------------------------------------------------------------
                 * 7. inipay.GetResult("TotPrice")										*
                 *    - �����Ϸ� �ݾ�                  									*
	 			 *																					*
	 			 * ���� �Ǵ� �ݾ� =>����ǰ���ݰ�  ��������ݾװ� ���Ͽ� �ݾ��� �������� �ʴٸ�  *
	 			 * ���� �ݾ��� �������� �ǽɵ����� �������� ó���� �����ʵ��� ó�� �ٶ��ϴ�. (�ش� �ŷ� ��� ó��) *
	 			 *																									*
                 -------------------------------------------------------------------------------------------------------->

												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�����Ϸ�ݾ�</td>
													<td width="343">${totprice} ��</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>

											<c:if test="${paymethod=='Card' or paymethod=='VCard'}">
											
											
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�ſ�ī���ȣ</td>
													<td width="343">${CARD_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ȣ</td>
													<td width="343">${ApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${CARD_Quota}����&nbsp;<b> <font color=red> ${EventCode}</font></b></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ī �� �� ��</td>
													<td width="343">${CARD_Code}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ī��߱޻�</td>
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
															color="433F37">�޷����� ����</font></strong></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� ȭ �� ��</td>
													<td width="343">${OrgCurrency}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ȯ ��</td>
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
															color="433F37">OK CASHBAG ���� �� ��볻��</font></strong></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ī �� �� ȣ</td>
													<td width="343">${OCB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">���� ���ι�ȣ</td>
													<td width="343">${OCB_SaveApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">��� ���ι�ȣ</td>
													<td width="343">${OCB_PayApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${OCB_ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">����Ʈ���ұݾ�</td>
													<td width="343">${OCB_PayPrice}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

												<c:if test="${paymethod=='DirectBank'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ACCT_BankCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">���ݿ�����<br>�߱ް���ڵ�
													</td>
													<td width="343">${CSHR_ResultCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">���ݿ�����<br>�߱ޱ����ڵ�
													</td>
													<td width="343">${CSHR_Type} <font color=red><b>(0 - �ҵ������, 1 - ����������)</b></font></td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>
	
											<c:if test="${paymethod=='VBank'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�Աݰ��¹�ȣ</td>
													<td width="343">${VACT_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�Ա� �����ڵ�</td>
													<td width="343">${VACT_BankCode}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">������ ��</td>
													<td width="343">${VACT_Name}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�۱��� ��</td>
													<td width="343">${VACT_InputName}</td>
												</tr>
												<!-- modify in 2007.11.23
                    		<tr> 
                    		  <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    		</tr>
                    		<tr> 
                    		  <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                    		  <td width="109" height="25">�۱��� �ֹι�ȣ</td>
                    		  <td width="343"><%=(inipay.GetResult("VACT_RegNum"))%>
              </td>
                    		</tr>
                    		-->
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">��ǰ �ֹ���ȣ</td>
													<td width="343">${MOID}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�۱� ����</td>
													<td width="343">${VACT_Date}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�۱� �ð�</td>
													<td width="343">${VACT_Time}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

<c:if test="${paymethod=='HPP'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�޴�����ȣ</td>
													<td width="343">${HPP_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
	</c:if>
												
							<c:if test="${paymethod=='Ars1588Bill'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� ȭ �� ȣ</td>
													<td width="343">${ARSB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
							</c:if>
												
						<c:if test="${paymethod=='PhoneBill'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� ȭ �� ȣ</td>
													<td width="343">${PHNB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
								</c:if>

												<c:if test="${paymethod=='OCBPoint'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ī �� �� ȣ</td>
													<td width="343">${OCB_Num}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ¥</td>
													<td width="343">${ApplDate}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�� �� �� ��</td>
													<td width="343">${ApplTime}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">���� ���ι�ȣ</td>
													<td width="343">${OCB_SaveApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">��� ���ι�ȣ</td>
													<td width="343">${OCB_PayApplNum}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">����Ʈ���ұݾ�</td>
													<td width="343">${OCB_PayPrice}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>


												<c:if test="${paymethod=='Culture'}">
												
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">���ķ��� ID</td>
													<td width="343">${CULT_UserID}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												</c:if>

												<c:if test="${paymethod=='TEEN'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ƾĳ���ܾ�</td>
													<td width="343">${TEEN_Remains}</td>
												</tr>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">ƾĳ�þ��̵�</td>
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
													 *  �Ʒ� �κ��� ���� ���ܺ� ��� �޼��� ��� �κ��Դϴ�.    						*	
													 *													*
													 *  10.  ���ӹ�ȭ ��ǰ�� ����						                			*
													 -------------------------------------------------------------------------------------------------------*/
													else if ("DGCL".equals(inipay.GetResult("PayMethod"))) {
												%>
						<c:if test="${paymethod=='DGCL'}">
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">����� ī�� ��</td>
													<td width="343"><%=(inipay.GetResult("GAMG_Cnt"))%> ��</td>
												</tr>

												<%
													/* �Ʒ��κ��� ����� ���ӹ�ȭ ��ǰ�� ��ȣ�� �ܾ��� �����ݴϴ�.(���� ���нÿ��� �ܾ״�� ������������ �����ݴϴ�.) */
														/* �ִ� 6����� ����� �����ϸ�, ������ ���� ī�常 ��µ˴ϴ�. */
														for (int i = 1; i <= Integer.parseInt(inipay.GetResult("GAMG_Cnt")); i++) {
												%>
												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">����� ī���ȣ</td>
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
													<td width="109" height="25">ī�� �ܾ�</td>
													<td width="343"><b><%=(inipay.GetResult("GAMG_Remains" + i))%> ��</b></td>
												</tr>
												<%
													} else {
												%>

												<tr>
													<td height="1" colspan="3" align="center" background="img/line.gif"></td>
												</tr>
												<tr>
													<td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
													<td width="109" height="25">�����޼���</td>
													<td width="343"><b><%=(inipay.GetResult("GAMG_ErrMsg" + i))%> </b></td>
												</tr>
												
				
												<%
													}
														}
													}

													/*-------------------------------------------------------------------------------------------------------
													 *
													 *  �Ʒ� �κ��� ���� ���ܺ� ��� �޼��� ��� �κ��Դϴ�.
													 *
													 *  11.  ������ȭ ��ǰ�� ���� (BCSH)
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
 *  ���� ������(inipay.GetResult("ResultCode").equals("00"�� ��� ) "�̿�ȳ�"  �����ֱ� �κ��Դϴ�.
 *  ���� ���ܺ��� �̿������ ���� ���ܿ� ���� ���� ������ ���� �ݴϴ�.
 *  switch , case�� ���·� ���� ���ܺ��� ��� �ϰ� �ֽ��ϴ�.
 *  �Ʒ� ������ ��� �մϴ�.
 *
 *  1.	�ſ�ī��
 *  2.  ISP ����
 *  3.  �ڵ���
 *  4.  �Ŵ� ��ȭ ���� (ARS1588Bill)
 *  5.  �޴� ��ȭ ���� (PhoneBill)
 *  6.	OK CASH BAG POINT
 *  7.  ���������ü
 *  8.  ������ �Ա� ����
 *  9.  ��ȭ��ǰ�� ����
 *  10. ƾĳ�� ����
 *  11. ���ӹ�ȭ ��ǰ�� ����
 *  12. ������ȭ ��ǰ�� ����
 --------------------------------------------------------------------------------------------------------> <%
 	if (inipay.GetResult("ResultCode").equals("00")) {

 		/*--------------------------------------------------------------------------------------------------------
 		 *													*
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  1.  �ſ�ī�� 						                			*
 				--------------------------------------------------------------------------------------------------------*/
 		if (inipay.GetResult("PayMethod").equals("Card")) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) �ſ�ī�� û������ <b>\"�̴Ͻý�(inicis.com)\"</b>���� ǥ��˴ϴ�.<br> (2) LGī�� �� BCī���� ��� <b>\"�̴Ͻý�(�̿� ������)\"</b>����
														ǥ��ǰ�, �Ｚī���� ��� <b>\"�̴Ͻý�(�̿���� URL)\"</b>�� ǥ��˴ϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  2.  ISP 						                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("VCard".equals(inipay.GetResult("PayMethod"))) { // ISP
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) �ſ�ī�� û������ <b>\"�̴Ͻý�(inicis.com)\"</b>���� ǥ��˴ϴ�.<br> (2) LGī�� �� BCī���� ��� <b>\"�̴Ͻý�(�̿� ������)\"</b>����
														ǥ��ǰ�, �Ｚī���� ��� <b>\"�̴Ͻý�(�̿���� URL)\"</b>�� ǥ��˴ϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  3. �ڵ��� 						                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("HPP".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) �ڵ��� û������ <b>\"�Ҿװ���\"</b> �Ǵ� <b>\"�ܺ������̿��\"</b>�� û���˴ϴ�.<br> (2) ������ �� �ѵ��ݾ��� Ȯ���Ͻð��� �� ��� �� �̵���Ż���
														�����͸� �̿����ֽʽÿ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  4. ��ȭ ���� (ARS1588Bill)				                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("Ars1588Bill".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) ��ȭ û������ <b>\"������ �̿��\"</b>�� û���˴ϴ�.<br> (2) �� �ѵ��ݾ��� ��� ������ �������� ��� ��ϵ� ��ȭ��ȣ ������ �ƴ� �ֹε�Ϲ�ȣ�� ��������
														å���Ǿ� �ֽ��ϴ�.<br> (3) ��ȭ ������Ҵ� ������� �����մϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  5. ���� ���� (PhoneBill)				                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("PhoneBill".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) ��ȭ û������ <b>\"���ͳ� ������ (����)�����̿��\"</b>�� û���˴ϴ�.<br> (2) �� �ѵ��ݾ��� ��� ������ �������� ��� ��ϵ� ��ȭ��ȣ ������ �ƴ�
														�ֹε�Ϲ�ȣ�� �������� å���Ǿ� �ֽ��ϴ�.<br> (3) ��ȭ ������Ҵ� ������� �����մϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  6. OK CASH BAG POINT					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("OCBPoint".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) OK CASH BAG ����Ʈ ������Ҵ� ������� �����մϴ�.</td>
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  7. ���������ü					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("DirectBank".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) ������ ���忡�� �̿��Ͻ� �������� ǥ��˴ϴ�.<br> (2) ������ ���� ����ȸ�� www.inicis.com�� ���� ��� <b>\"��볻�� �� û����� ��ȸ\"</b>������
														Ȯ�ΰ����մϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  8. ������ �Ա� ����					                			*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("VBank".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1) ��� ����� �Աݿ����� �Ϸ�� ���ϻ� ���� �ԱݿϷᰡ �̷���� ���� �ƴմϴ�.<br> (2) ��� �Աݰ��·� �ش� ��ǰ�ݾ��� �������Ա�(â���Ա�)�Ͻðų�, ���ͳ� ��ŷ ���� ���� �¶��� �۱���
														�Ͻñ� �ٶ��ϴ�.<br> (3) �ݵ�� �Աݱ��� ���� �Ա��Ͻñ� �ٶ��, ����Աݽ� �ݵ�� �ֹ��Ͻ� �ݾ׸� �Ա��Ͻñ� �ٶ��ϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  9. ��ȭ��ǰ�� ����					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("Culture".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) ��ȭ��ǰ���� �¶��ο��� �̿��Ͻ� ��� �������ο����� ����Ͻ� �� �����ϴ�.<br> (2) ����ĳ�� �ܾ��� �����ִ� ���, ������ ����ĳ�� �ܾ��� �ٽ� ����Ͻ÷��� ���ķ���
														ID�� ����Ͻñ� �ٶ��ϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  10. ƾĳ�� ����					                				*
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("TEEN".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1)ƾĳ�ô� ���ͳ� ����Ʈ �Ǵ� PC�濡�� �����Ӱ� ����� �� �ִ� ���� ���������Դϴ�.<br> (2)ƾĳ�� ī���ȣ ���� : ƾĳ�� ī�� �޸鿡 ���� 12�ڸ� ��ȣ�� �Է��Ͽ� �����ϴ� ����Դϴ�.<br>
														(3)ƾĳ�� ���̵� ���� : ƾĳ�� ����Ʈ (www.teencash.co.kr)�� ȸ������ �� ƾĳ�� ����Ʈ�� �����Ͽ� ������ ƾĳ�� ī�带 ����Ͽ� �̿��ϴ� ����Դϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ� 			    						*	
 		 *													*
 		 *  11. ���ӹ�ȭ ��ǰ�� ����				                				*
 			--------------------------------------------------------------------------------------------------------*/
 		else if ("DGCL".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td>(1)���ӹ�ȭ ��ǰ���� ��ǰ�ǿ� �μ�Ǿ��ִ� ��ũ��ġ ��ȣ�� �����ϴ� ����Դϴ�.<br> (2)���ӹ�ȭ ��ǰ�� ������ ��ȭ��ǰ��(www.cultureland.co.kr)���� ���� �ϽǼ� �ֽ��ϴ�.<br>
														(3)���ӹ�ȭ ��ǰ���� �ִ� 6����� ����� �����մϴ�.
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
 		 * ���� ������ �̿�ȳ� �����ֱ�
 		 *
 		 *  12. ������ȭ��ǰ�� ����
 				--------------------------------------------------------------------------------------------------------*/
 		else if ("BCSH".equals(inipay.GetResult("PayMethod"))) {
 %>
								<table width="510" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="25" style="padding: 0 0 0 9"><img src="img/icon.gif" width="10" height="11"> <strong><font
												color="433F37">�̿�ȳ�</font></strong></td>
									</tr>
									<tr>
										<td style="padding: 0 0 0 23">
											<table width="470" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td height="25">(1) ������ȭ��ǰ���� �¶��ο��� �̿��Ͻ� ��� �������ο����� ����Ͻ� �� �����ϴ�.<br> (2) �ܾ��� �������� ���, �϶����� ID�� ����Ͽ� �� �� �ٸ� ������ �̿��Ͻʽÿ�.
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
 %> <!-- �̿�ȳ� �� -->

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

