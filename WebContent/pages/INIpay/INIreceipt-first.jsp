<%@ page language = "java" contentType = "text/html;charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>    
<head>
<title>INIpay50 ���ݿ����� ���� ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/group.css" type="text/css">
<style>
body, tr, td {font-size:10pt; font-family:����,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/ 
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:����,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/ 
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}
</style>

<script language="javascript">

// ������ ���ÿ� ���� �з�

function RCP1(){
	document.ini.useopt.value="0" // �ҵ������
}

function RCP2(){
	document.ini.useopt.value="1" // ����������
}


var openwin;

function pay()
{	
    // �ʼ��׸� üũ (������ ���� �뵵�� ���� �ֹε�Ϲ�ȣ�� ����ڹ�ȣ ���̿� ���� üũ)
    // �ֹε�Ϲ�ȣ�� ����ڵ�Ϲ�ȣ, �޴��� ��ȣ�� �������� �Է¿��� Ȯ���� ���� �Ʒ��� �ڹٽ�ũ��Ʈ�� �ݵ�� ����Ͽ��� �ϸ�, 
    // ������� ������� �߻��� ������ ���� å���� ������ �ֽ��ϴ�.
    // ���� �޴��� ����ڰ� �߰��� ���, �ݵ�� �Ʒ��� �޴��� ��ȣ üũ �ڹٽ�ũ��Ʈ�� �޴��� ���ڸ��� �߰��Ͻñ� �ٶ��ϴ�. 
    // �̴Ͻý������� �Ǹ�Ȯ�� ���񽺸� �������� ������, �Ǹ�Ȯ�� ��ü�� �̿��Ͻñ� �ٶ��ϴ�.

	if(document.ini.useopt.value == "")
	{	
		alert("���ݿ����� ����뵵�� �����ϼ���. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.useopt.value == "0")
	{
		alert("�ҵ������ �������� �����ϼ̽��ϴ�.");
		
		if(document.ini.reg_num.value.length !=13 && document.ini.reg_num.value.length !=10 && document.ini.reg_num.value.length !=11)
		{
			alert("�ùٸ� �ֹε�Ϲ�ȣ 13�ڸ� �Ǵ� �޴��� ��ȣ 10�ڸ�(11�ڸ�)�� �Է��ϼ���.");
			return false;
		}
		else if(document.ini.reg_num.value.length == 13)
		{
			var obj = document.ini.reg_num.value;
                	var sum=0;
                	
                	for(i=0;i<8;i++) { sum+=obj.substring(i,i+1)*(i+2); }
                	
                	for(i=8;i<12;i++) { sum+=obj.substring(i,i+1)*(i-6); }
                	
                	sum=11-(sum%11);
                	
                	if (sum>=10) { sum-=10; }
                	
                	if (obj.substring(12,13) != sum || (obj.substring(6,7) !=1 && obj.substring(6,7) != 2))
                	{
                	
                	    alert("�ֹε�Ϲ�ȣ�� ������ �ֽ��ϴ�. �ٽ� Ȯ���Ͻʽÿ�.");
                	    return false;
	        	}
	        	
	        }	        
	        else if(document.ini.reg_num.value.length == 11 ||document.ini.reg_num.value.length == 10 )
	        {
	        	var obj = document.ini.reg_num.value;
	        	if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010")
	        	{
	        		alert("�޴��� ��ȣ�� �ƴϰų�, �޴��� ��ȣ�� ������ �ֽ��ϴ�. �ٽ� Ȯ�� �Ͻʽÿ�. ");
	        		return false;
	        	}
	        	
	        	var chr;
			for(var i=0; i<obj.length; i++){
	        		
	        		chr = obj.substr(i, 1);
	        		if( chr < '0' || chr > '9') {
   					alert("���ڰ� �ƴ� ���ڰ� �޴��� ��ȣ�� �߰��Ǿ� ������ �ֽ��ϴ�, �ٽ� Ȯ�� �Ͻʽÿ�. ");
   					return false;
  				}
			}
    }
	}
	else if(document.ini.useopt.value == "1")
	{
		alert("���������� �������� �����ϼ̽��ϴ�.");
		var obj = document.ini.reg_num.value;
		
		if(document.ini.reg_num.value.length !=10  && document.ini.reg_num.value.length !=11 && document.ini.reg_num.value.length !=13)
		{
			alert("�ùٸ� �ֹε�Ϲ�ȣ 13�ڸ�, ����ڵ�Ϲ�ȣ 10�ڸ� �Ǵ� �޴��� ��ȣ 10�ڸ�(11�ڸ�)�� �Է��ϼ���.");
			return false;
		}
		else if(document.ini.reg_num.value.length == 13)
		{
			var obj = document.ini.reg_num.value;
                	var sum=0;
                	
                	for(i=0;i<8;i++) { sum+=obj.substring(i,i+1)*(i+2); }
                	
                	for(i=8;i<12;i++) { sum+=obj.substring(i,i+1)*(i-6); }
                	
                	sum=11-(sum%11);
                	
                	if (sum>=10) { sum-=10; }
                	
                	if (obj.substring(12,13) != sum || (obj.substring(6,7) !=1 && obj.substring(6,7) != 2))
                	{
                	
                	    alert("�ֹε�Ϲ�ȣ�� ������ �ֽ��ϴ�. �ٽ� Ȯ���Ͻʽÿ�.");
                	    return false;
				
	        	}
	        	
	        }
		else if(document.ini.reg_num.value.length == 10 && obj.substring(0,1)!= "0"){
   			var vencod = document.ini.reg_num.value;
   			var sum = 0; 
   			var getlist =new Array(10); 
   			var chkvalue =new Array("1","3","7","1","3","7","1","3","5"); 
   			for(var i=0; i<10; i++) { getlist[i] = vencod.substring(i, i+1); } 
   			for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; } 
   			sum = sum + parseInt((getlist[8]*5)/10);  
   			sidliy = sum % 10; 
   			sidchk = 0; 
   			if(sidliy != 0) { sidchk = 10 - sidliy; } 
   			else { sidchk = 0; } 
   			if(sidchk != getlist[9]) { 
   				alert("����ڵ�Ϲ�ȣ�� ������ �ֽ��ϴ�. �ٽ� Ȯ���Ͻʽÿ�.");    
   			    return false; 
   			}
   			else return true;
		}
		else if(document.ini.reg_num.value.length == 11 ||document.ini.reg_num.value.length == 10 )
	        {
	        	var obj = document.ini.reg_num.value;
	        	if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010")
	        	{
	        		alert("�޴��� ��ȣ�� ������ �ֽ��ϴ�. �ٽ� Ȯ�� �Ͻʽÿ�. ");
	        		return false;
	        	}
	        	
	        	var chr;
			for(var i=0; i<obj.length; i++){
	        		
	        		chr = obj.substr(i, 1);
	        		if( chr < '0' || chr > '9') {
   					alert("���ڰ� �ƴ� ���ڰ� �޴��� ��ȣ�� �߰��Ǿ� ������ �ֽ��ϴ�, �ٽ� Ȯ�� �Ͻʽÿ�. ");
   					return false;
  				}
			}
	       }
	}	
	
	// �ʼ��׸� üũ (��ǰ��, ���ݰ����ݾ�, ���ް���, �ΰ���, �����, �����ڸ�, �ֹε�Ϲ�ȣ(����ڹ�ȣ,�޴�����ȣ), ������ �̸����ּ�, ������ ��ȭ��ȣ, )	
	if(document.ini.goodname.value == "")
	{
		alert("��ǰ���� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.cr_price.value == "")
	{
		alert("���ݰ����ݾ��� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.sup_price.value == "")
	{
		alert("���ް����� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.tax.value == "")
	{
		alert("�ΰ����� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.srvc_price.value == "")
	{
		alert("����ᰡ �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.buyername.value == "")
	{
		alert("�����ڸ��� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.reg_num.value == "")
	{
		alert("�ֹε�Ϲ�ȣ(�Ǵ� ����ڹ�ȣ, �޴�����ȣ)�� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
			
	}
	else if(document.ini.buyeremail.value == "")
	{
		alert("������ �̸����ּҰ� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}
	else if(document.ini.buyertel.value == "")
	{
		alert("������ ��ȭ��ȣ�� �������ϴ�. �ʼ��׸��Դϴ�.");
		return false;
	}		
	
	
	// ���ݰ����ݾ� �ջ� üũ
	// ���ݰ����ݾ� �ջ��� �Ʒ��� �ڹٽ�ũ��Ʈ�� ���� �ݵ�� Ȯ�� �ϵ��� �Ͻñ� �ٶ��, 
	// �Ʒ��� �ڹٽ�ũ��Ʈ�� ������� �ʾ� �߻��� ������ ������ å���� �ֽ��ϴ�.
	   
	var sump = eval(document.ini.sup_price.value) + eval(document.ini.tax.value) + eval(document.ini.srvc_price.value);
	if(eval(document.ini.sup_price.value) <= eval(document.ini.tax.value)){
		alert("���ް����� �ΰ������� �۽��ϴ�");
		return false;
	}
	if(document.ini.cr_price.value != sump)
	{
		
		alert("�Ѱ����ݾ� ���� ���� �ʽ��ϴ�.");
		return false;
	}
	else if(sump < 5000)
	{
		alert("�Ѱ����ݾ��� 5õ�� �̻��̾�� ���ݿ����� ������ �����մϴ�.");
		return false;
	}
	
	// ����Ŭ������ ���� �ߺ���û�� �����Ϸ��� �ݵ�� confirm()��
	// ����Ͻʽÿ�.
	
	if(confirm("���ݿ������� �����Ͻðڽ��ϱ�?"))
	{
		disable_click();
		openwin = window.open("childwin.action","childwin","width=299,height=149");
		return true;
	}
	else
	{
		return false;
	}
}


// ������ ����뵵 ����Ʈ ���̱�

var main_cnt = 1

function showhide(num){

    for (i=1; i<=main_cnt; i++){  

      menu=eval("document.all.block"+i+".style");

      if (num == i){
      	
      	if (menu.display == "block") {
        	
        	menu.display="none";        
        } 
        else{        	
        	menu.display="block";
        }
     
     }
     else{
     	
     	menu.display="none";
     }
   }
}



function enable_click()
{
	document.ini.clickcontrol.value = "enable"
}

function disable_click()
{
	document.ini.clickcontrol.value = "disable"
}

function focus_control()
{
	if(document.ini.clickcontrol.value == "disable")
		openwin.focus();
}

</script>	

<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</head>

<!-----------------------------------------------------------------------------------------------------
�� ���� ��
 �Ʒ��� body TAG�� �����߿� 
 onload="javascript:enable_click()" onFocus="javascript:focus_control()" �� �κ��� �������� �״�� ���.
 �Ʒ��� form TAG���뵵 �������� �״�� ���.
------------------------------------------------------------------------------------------------------->

<body bgcolor="#FFFFFF" text="#242424" leftmargin=0 topmargin=15 marginwidth=0 marginheight=0 bottommargin=0 rightmargin=0 onload="javascript:enable_click()" onFocus="javascript:focus_control()"><center>
<form name=ini method=post action="finsh_inireceipt.action" onSubmit="return pay(this)"> 
<table width="632" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="85" background="img/cash_top.gif" style="padding:0 0 0 64">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="3%" valign="top"><img src="img/title_01.gif" width="8" height="27" vspace="5"></td>
          <td width="97%" height="40" class="pl_03"><font color="#FFFFFF"><b>���ݿ����� �����û</b></font></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td align="center" bgcolor="6095BC"><table width="620" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td bgcolor="#FFFFFF" style="padding:8 0 0 56"> 
            <table width="530" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td>���ݿ����� �����û �����Դϴ�.</td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="7"><img src="img/life.gif" width="7" height="30"></td>
                <td background="img/center.gif"><img src="img/icon03.gif" width="12" height="10"> 
                  <b>������ �����Ͻ� �� �����ư�� �����ֽʽÿ�.</b></td>
                <td width="8"><img src="img/right.gif" width="8" height="30"></td>
              </tr>
            </table>
            <br>
            <table width="510" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="510" colspan="2"  style="padding:0 0 0 23">
                  <table width="470" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr> 
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">�� ǰ ��</td>
                      <td width="280"><input type=text name=goodname size=20 value="�౸��"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">�� �� �� ��</td>
                      <td width="280"><input type=text name=cr_price size=10 value="5000">&nbsp;&nbsp;
                      <font color=red><b>5000</b>�� �̻� �����մϴ�</font>
                      <br><font color=red>(���ݰ��� �ѱݾ�:���ް�+�ΰ���+�����)</font></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">�� �� �� ��</td>
                      <td width="280"><input type=text name=sup_price size=10 value="4000"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">�� �� ��</td>
                      <td width="280"><input type=text name=tax size=10 value="900"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="177" height="26">�� �� ��</td>
                      <td width="280"><input type=text name=srvc_price size=10 value="100"></td>
                    </tr>                    
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ��</td>
                      <td width="343"><input type=text name=buyername size=20 value="ȫ�浿"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ��</td>
                      <td width="343"><input type=text name=buyeremail size=20 value="test@test.com"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�� �� �� ȭ</td>
                      <td width="343"><input type=text name=buyertel size=20 value="011-123-1234"></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr>
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td colspan=2>
                    	 <table width=100% cellspacing=0 cellpadding=0 border=0>
                    	   <tr>
                    	     <td>
                    	     	<!--input type=checkbox name=check value="1" onClick="javascript:showhide('1');"-->���ݿ����� ����뵵�� �����ϼ���
                    	     </td>
                    	   </tr>
                    	   <tr>
                    	     <td align=center><!--SPAN id=block1 style="DISPLAY:none; xCURSOR:hand"-->
                    	     	<table>
                    	     	 <tr>
                    	     	  <td>
                    		     <input type=radio name=choose value=0 Onclick= "javascript:RCP1()">�ҵ������&nbsp;&nbsp;&nbsp;&nbsp;
				                     <input type=radio name=choose value=1 Onclick= "javascript:RCP2()">����������
                    		  </td>
                    		 </tr>
                    		</table>
                    	       </SPAN>
                    	     </td>
                    	   </tr>
                    	 </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>     
                    <tr> 
                      <td width="18" align="center"><img src="img/icon02.gif" width="7" height="7"></td>
                      <td width="109" height="25">�ֹε�� �Ǵ�<br> �޴��� ��ȣ<br>(����ڵ�Ϲ�ȣ)</td>
                      <td width="343"><input type=text name=reg_num size=13 maxlength=13 value="0111231234">&nbsp;&nbsp;&nbsp;<font color=red>"-"�� �� ���ڸ� �Է��ϼ���</font></td>
                    </tr>
                    <tr> 
                      <td height="1" colspan="3" align="center"  background="img/line.gif"></td>
                    </tr>
                    <tr valign="bottom"> 
                      <td height="40" colspan="3" align="center"><input type=image src="img/button_08.gif" width="63" height="25"></td>
                    </tr>
                    <tr valign="bottom">
                      <td height="45" colspan="3">���ڿ����� �̵���ȭ��ȣ�� �Է¹޴� ���� �������� �������� ������ E-MAIL �Ǵ� SMS ��
                   �˷��帮�� �����̿��� �ݵ�� �����Ͻñ� �ٶ��ϴ�.</td>
                   
                    </tr>
                    <tr valign="bottom">
                      <td height="45" colspan="3"><b>�ܼҵ� ������ - �ֹε�� ��ȣ�� �޴��� ��ȣ�� �߱� ����</b><BR>
                   <b>������ ������ - �ֹε�� ��ȣ, �޴��� ��ȣ, ����� ��ȣ�� �߱� ����</b></td>
                   
                    </tr>
                  </table></td>
              </tr>
            </table> 
            <br>
          </td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td><img src="img/bottom01.gif" width="632" height="13"></td>
  </tr>
</table>
</center>

<!-- 
�������̵�.
�׽�Ʈ�� ��ģ ��, �߱޹��� ���̵�� �ٲپ� �ֽʽÿ�.
-->
<input type=hidden name=mid value=INIpayTest>

<!--
ȭ�����
WON �Ǵ� USD
���� : ��ȭ������ ���� ����� �ʿ��մϴ�.
-->
<input type=hidden name=currency value="WON">

<!-- [�ʼ� �ʵ�]����/���� �Ұ� -->
<input type=hidden name=clickcontrol value="">
<input type=hidden name=useopt value="">

</form>
</body>
</html>