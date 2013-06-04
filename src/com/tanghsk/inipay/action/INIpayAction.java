package com.tanghsk.inipay.action;

import java.io.UnsupportedEncodingException;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inicis.inipay.INIpay;
import com.inicis.inipay.INIpay50;

@Controller
public class INIpayAction {
	
	protected static Logger logger = Logger.getLogger(INIpayAction.class);
	@RequestMapping(value = "ini_securestart", method = RequestMethod.GET)
	public String INIsecurestart(HttpServletRequest request, HttpServletResponse response, Model model) throws UnsupportedEncodingException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("euc-kr");

		/***************************************
		 * 2. INIpay 인스턴스 생성 new instance *
		 ***************************************/
		INIpay50 inipay = new INIpay50();

		/***************************************
		 * 3. 암호화 대상/값 설정 set field value *
		 ***************************************/
		// /home/cuijingtao/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/INIpay
		String contentUrl = request.getSession().getServletContext().getRealPath("/");
		inipay.SetField("inipayhome", contentUrl); // 이니페이
		//inipay.SetField("inipayhome", "/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이
																						// 홈디렉터리(상점수정
																						// 필요)
		inipay.SetField("admin", "1111"); // 키패스워드(상점아이디에 따라 변경)
		// ***********************************************************************************************************
		// * admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다. *
		// * 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기
		// 바랍니다.*
		// * 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다. *
		// * 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오. *
		// ***********************************************************************************************************
		inipay.SetField("type", "chkfake"); // 고정 (절대 수정 불가)

		inipay.SetField("enctype", "asym"); // 고정 (절대 수정 불가) asym:비대칭, symm:대칭
		inipay.SetField("checkopt", "false"); // 고정 (절대 수정 불가) base64함:false,
												// base64안함:true
		inipay.SetField("debug", "true"); // 로그모드("true"로 설정하면 상세로그가 생성됨.)

		// 필수항목 : mid, price, nointerest, quotabase
		// 추가가능 : INIregno, oid
		// *주의* : 추가가능한 항목중 암호화 대상항목에 추가한 필드는 반드시 hidden 필드에선 제거하고
		// SESSION이나 DB를 이용해 다음페이지(INIsecureresult.jsp)로 전달/셋팅되어야 합니다.
		inipay.SetField("mid", "INIpayTest"); // 상점아이디
		inipay.SetField("price", "1000"); // 가격
		inipay.SetField("nointerest", "no"); // 무이자여부
		inipay.SetField("quotabase", "선택:일시불:2개월:3개월:6개월"); // 할부기간
		String[] parameters = { "price", "nointerest", "quotabase" };
		inipay.SetField("parameters", parameters);

		/********************************
		 * 4. 암호화 대상/값을 암호화함 *
		 ********************************/

		inipay.startAction();

		/*********************
		 * 5. 암호화 결과 The results of encryption *
		 *********************/
		String rn_resultMsg = "";
		if (inipay.GetResult("ResultCode") != "00") {
			rn_resultMsg = inipay.GetResult("ResultMsg");
		}

		/*********************
		 * 6. 세션정보 저장 *
		 *********************/
		session.setAttribute("INI_MID", inipay.GetResult("mid"));
		session.setAttribute("INI_RN", inipay.GetResult("rn"));
		session.setAttribute("INI_ENCTYPE", inipay.GetResult("enctype"));
		session.setAttribute("INI_PRICE", inipay.GetResult("price"));
		session.setAttribute("admin", inipay.GetResult("admin"));

		/*******************************************
		 * 7. 플러그인 전달 정보, hidden field 설정 pass to plug-in hidden field setting*
		 *******************************************/
		String ini_encfield = inipay.GetResult("encfield");
		String ini_certid = inipay.GetResult("certid");

		/*********************
		 * 6. 인스턴스 해제 *
		 *********************/

		model.addAttribute("rn_resultMsg", rn_resultMsg);
		model.addAttribute("ini_encfield", ini_encfield);
		model.addAttribute("ini_certid", ini_certid);

		return "INIpay/INIsecurestart";
	}

	@RequestMapping(value = "ini_cancel", method = RequestMethod.GET)
	public String iniCancel(Model model) {

		return "INIpay/INIcancel-first";
	}

	@RequestMapping(value = "finsh_inicancel", method = RequestMethod.POST)
	public String finsh_inicancel(HttpServletRequest request, HttpServletResponse response, Model model)
			throws UnsupportedEncodingException {

		request.setCharacterEncoding("euc-kr");
		/***************************************
		 * 2. INIpay 클래스의 인스턴스 생성 *
		 ***************************************/
		INIpay inipay = new INIpay();

		/*********************
		 * 3. 취소 정보 설정 *
		 *********************/
		String contentUrl = request.getSession().getServletContext().getRealPath("/");
		inipay.SetField("inipayhome", contentUrl); // 이니페이
		//inipay.SetField("inipayhome", "/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이
																						// 홈디렉터리(상점수정
		// 필요)
		inipay.SetField("type", "cancel"); // 고정 (절대 수정 불가)
		inipay.SetField("debug", "true"); // 로그모드("true"로 설정하면 상세로그가 생성됨.)
		inipay.SetField("mid", request.getParameter("mid")); // 상점아이디
		inipay.SetField("admin", "1111"); // 상점 키패스워드 (비대칭키)
		inipay.SetField("cancelreason", request.getParameter("cancelreason")); // 현금영수증
																				// 취소코드
		// ***********************************************************************************************************
		// * admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다. *
		// * 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기
		// 바랍니다.*
		// * 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다. *
		// * 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오. *
		// ***********************************************************************************************************
		inipay.SetField("tid", request.getParameter("tid")); // 취소할 거래의 거래아이디
		inipay.SetField("cancelmsg", request.getParameter("msg")); // 취소사유

		/****************
		 * 4. 취소 요청 *
		 ****************/
		inipay.startAction();

		/****************************************************************
		 * 5. 취소 결과
		 * 
		 * 결과코드 : inipay.GetResult("ResultCode") ("00"이면 취소 성공) 결과내용 :
		 * inipay.GetResult("ResultMsg") (취소결과에 대한 설명) 취소날짜 :
		 * inipay.GetResult("CancelDate") (YYYYMMDD) 취소시각 :
		 * inipay.GetResult("CancelTime") (HHMMSS) 현금영수증 취소 승인번호 :
		 * inipay.GetResult("CSHR_CancelNum") (현금영수증 발급 취소시에만 리턴됨)
		 ****************************************************************/

		String background_img = "img/spool_top.gif"; // default image
		if ("01".equals(inipay.GetResult("ResultCode"))) {
			background_img = "img/cancle_top.gif";
		}
		String resultCode = inipay.GetResult("ResultCode");
		String resultMsg = inipay.GetResult("ResultMsg");
		String tid = request.getParameter("tid");
		String cancelDate = inipay.GetResult("CancelDate");
		String cancelTime = inipay.GetResult("CancelTime");
		String CSHR_CancelNum = inipay.GetResult("CSHR_CancelNum");

		model.addAttribute("background_img", background_img);
		model.addAttribute("resultCode", resultCode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("tid", tid);
		model.addAttribute("cancelDate", cancelDate);
		model.addAttribute("cancelTime", cancelTime);
		model.addAttribute("CSHR_CancelNum", CSHR_CancelNum);
		return "INIpay/INIcancel";
	}

	@RequestMapping(value = "ini_INIreceipt", method = RequestMethod.GET)
	public String iniINIreceipt(Model model) {
		return "INIpay/INIreceipt-first";
	}

	@RequestMapping(value = "finsh_inireceipt", method = RequestMethod.POST)
	public String finsh_inireceipt(HttpServletRequest request, HttpServletResponse response, Model model)
			throws UnsupportedEncodingException {

		request.setCharacterEncoding("euc-kr");
		/**************************************
		 * 1. INIpay 클래스의 인스턴스 생성 *
		 **************************************/
		INIpay50 inipay = new INIpay50();

		/*********************
		 * 2. 발급 정보 설정 *
		 *********************/
		inipay.SetField("inipayhome", "/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이 홈디렉터리(상점수정
																// 필요)
		inipay.SetField("mid", request.getParameter("mid")); // 상점아이디
		inipay.SetField("admin", "1111"); // 키패스워드(상점아이디에 따라 변경)
		// ***********************************************************************************************************
		// * admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다. *
		// * 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기
		// 바랍니다.*
		// * 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다. *
		// * 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오. *
		// ***********************************************************************************************************
		inipay.SetField("type", "receipt"); // 고정
		inipay.SetField("paymethod", "CASH"); // 고정(요청분류)
		inipay.SetField("debug", "true"); // 로그모드("true"로 설정하면 상세로그가 생성됨.)

		inipay.SetField("currency", request.getParameter("currency")); // 화폐단위
																		// (고정)
		inipay.SetField("goodname", request.getParameter("goodname")); // 상품명
		inipay.SetField("price", request.getParameter("cr_price")); // 총 현금결제 금액
		inipay.SetField("sup_price", request.getParameter("sup_price")); // 공급가액
		inipay.SetField("tax", request.getParameter("tax")); // 부가세
		inipay.SetField("srvc_price", request.getParameter("srvc_price")); // 봉사료
		inipay.SetField("reg_num", request.getParameter("reg_num")); // 현금결제자
																		// 주민등록번호
		inipay.SetField("useopt", request.getParameter("useopt")); // 현금영수증 발행용도
																	// ("0" -
																	// 소비자
																	// 소득공제용,
																	// "1" - 사업자
																	// 지출증빙용)

		inipay.SetField("buyername", request.getParameter("buyername")); // 구매자
																			// 성명
		inipay.SetField("buyeremail", request.getParameter("buyeremail")); // 구매자
																			// 이메일
																			// 주소
		inipay.SetField("buyertel", request.getParameter("buyertel")); // 구매자
																		// 전화번호

		/****************
		 * 3. 지불 요청 *
		 ****************/
		inipay.startAction();

		/*****************************************************************
		 * 4. 발급 결과 *
		 ****************************************************************/

		String tid = inipay.GetResult("tid"); // 거래번호
		String resultcode = inipay.GetResult("ResultCode"); // 현금영수증 발행 결과코드
															// (4자리 - "0000"이면
															// 발급성공)
		if (resultcode.equals("0000")) {
			model.addAttribute("cash_top", "img/cash_top.gif");
		} else {
			model.addAttribute("cash_top", "img/spool_top.gif");
		}


		String resultMsg = inipay.GetResult("ResultMsg"); // 결과내용 (발행결과에 대한 설명)
		String payMethod = inipay.GetResult("paymethod"); // 지불방법 (매뉴얼 참조)
		String applnum = inipay.GetResult("ApplNum"); // 현금영수증 발행 승인 번호
		String appldate = inipay.GetResult("ApplDate"); // 이니시스 승인날짜 (YYYYMMDD)
		String appltime = inipay.GetResult("ApplTime"); // 이니시스 승인시각 (HHMMSS)
		String cshr_price = inipay.GetResult("CSHR_ApplPrice"); // 총현금결제 금액 ( or
																// "TotPrice")
		String rsup_price = inipay.GetResult("CSHR_SupplyPrice"); // 공급가
		String rtax = inipay.GetResult("CSHR_Tax"); // 부가세
		String rsrvc_price = inipay.GetResult("CSHR_ServicePrice"); // 봉사료
		String rshr_type = inipay.GetResult("CSHR_Type"); // 현금영수증 사용구분

		if (rshr_type.trim().equals("0")) {
			model.addAttribute("message", "소비자 소득공제용");
		} else {
			model.addAttribute("message", "사업자 지출증빙용");
		}
		
		model.addAttribute("tid", tid);
		model.addAttribute("resultcode", resultcode);
		model.addAttribute("resultMsg", resultMsg);
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("applnum", applnum);
		model.addAttribute("appldate", appldate);
		model.addAttribute("appltime", appltime);
		model.addAttribute("cshr_price", cshr_price);
		model.addAttribute("rsup_price", rsup_price);
		model.addAttribute("rtax", rtax);
		model.addAttribute("rsrvc_price", rsrvc_price);
		model.addAttribute("rshr_type", rshr_type);

		return "INIpay/INIreceipt";
	}
	@RequestMapping(value="childwin",method=RequestMethod.GET)
	public String childwin(Model model){
		return "INIpay/childwin";
	}
	@RequestMapping(value="inipay_result",method=RequestMethod.POST)
	public String inipayResult(HttpServletRequest request,HttpServletResponse response,Model model) throws UnsupportedEncodingException{
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("euc-kr");
		/***************************************
		 * 2. INIpay 인스턴스 생성             *
		 ***************************************/
		INIpay50 inipay = new INIpay50();

		/*********************
		 * 3. 지불 정보 설정 *
		 *********************/

		String contentUrl = request.getSession().getServletContext().getRealPath("/");
		inipay.SetField("inipayhome", contentUrl); // 이니페이
		//inipay.SetField("inipayhome","/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이 홈디렉터리(상점수정 필요)
		inipay.SetField("type", "securepay"); // 고정 (절대 수정 불가)
		inipay.SetField("admin", session.getAttribute("admin")); // 키패스워드(상점아이디에 따라 변경)
		//***********************************************************************************************************
		//* admin 은 키패스워드 변수명입니다. 수정하시면 안됩니다. 1111의 부분만 수정해서 사용하시기 바랍니다.      *
		//* 키패스워드는 상점관리자 페이지(https://iniweb.inicis.com)의 비밀번호가 아닙니다. 주의해 주시기 바랍니다.*
		//* 키패스워드는 숫자 4자리로만 구성됩니다. 이 값은 키파일 발급시 결정됩니다.                               *
		//* 키패스워드 값을 확인하시려면 상점측에 발급된 키파일 안의 readme.txt 파일을 참조해 주십시오.             *
		//***********************************************************************************************************
		inipay.SetField("debug", "true"); // 로그모드("true"로 설정하면 상세로그가 생성됨.)

		inipay.SetField("uid", request.getParameter("uid")); // INIpay User ID (절대 수정 불가)
		inipay.SetField("oid", request.getParameter("oid")); // 상품명 
		inipay.SetField("goodname", request.getParameter("goodname")); // 상품명 
		inipay.SetField("currency", request.getParameter("currency")); // 화폐단위
		inipay.SetField("mid", session.getAttribute("INI_MID")); // 상점아이디
		inipay.SetField("enctype", session.getAttribute("INI_ENCTYPE")); //웹페이지 위변조용 암호화 정보
		inipay.SetField("rn", session.getAttribute("INI_RN")); //웹페이지 위변조용 RN값
		inipay.SetField("price", session.getAttribute("INI_PRICE")); //가격

		/**---------------------------------------------------------------------------------------
		 * price 등의 중요데이터는
		 * 브라우저상의 위변조여부를 반드시 확인하셔야 합니다.
		 *
		 * 결제 요청페이지에서 요청된 금액과
		 * 실제 결제가 이루어질 금액을 반드시 비교하여 처리하십시오.
		 *
		 * 설치 메뉴얼 2장의 결제 처리페이지 작성부분의 보안경고 부분을 확인하시기 바랍니다.
		 * 적용참조문서: 이니시스홈페이지->가맹점기술지원자료실->기타자료실 의
		 *              '결제 처리 페이지 상에 결제 금액 변조 유무에 대한 체크' 문서를 참조하시기 바랍니다.
		 * 예제)
		 * 원 상품 가격 변수를 OriginalPrice 하고  원 가격 정보를 리턴하는 함수를 Return_OrgPrice()라 가정하면
		 * 다음 같이 적용하여 원가격과 웹브라우저에서 Post되어 넘어온 가격을 비교 한다.
		 *
			String originalPrice = merchant.getOriginalPrice();
			String postPrice = inipay.GetResult("price"); 
			if ( originalPrice != postPrice )
			{
				//결제 진행을 중단하고  금액 변경 가능성에 대한 메시지 출력 처리
				//처리 종료 
			}
		---------------------------------------------------------------------------------------**/

		inipay.SetField("paymethod", request.getParameter("paymethod")); // 지불방법 (절대 수정 불가)
		inipay.SetField("encrypted", request.getParameter("encrypted")); // 암호문
		inipay.SetField("sessionkey", request.getParameter("sessionkey")); // 암호문
		inipay.SetField("buyername", request.getParameter("buyername")); // 구매자 명
		inipay.SetField("buyertel", request.getParameter("buyertel")); // 구매자 연락처(휴대폰 번호 또는 유선전화번호)
		inipay.SetField("buyeremail", request.getParameter("buyeremail")); // 구매자 이메일 주소
		//inipay.SetField("url", "http://www.your_domain.co.kr"); // 실제 서비스되는 상점 SITE URL로 변경할것http://49.5.1.250:8080/INIpay/inipay_result.action
		inipay.SetField("url", "http://49.5.1.250:8080/INIpay/inipay_result.action");
		inipay.SetField("cardcode", request.getParameter("cardcode")); // 카드코드 리턴
		inipay.SetField("parentemail", request.getParameter("parentemail")); // 보호자 이메일 주소(핸드폰 , 전화결제시에 14세 미만의 고객이 결제하면  부모 이메일로 결제 내용통보 의무, 다른결제 수단 사용시에 삭제 가능)

		/*-----------------------------------------------------------------*
		 * 수취인 정보 *                                                   *
		 *-----------------------------------------------------------------*
		 * 실물배송을 하는 상점의 경우에 사용되는 필드들이며               *
		 * 아래의 값들은 INIsecurestart.jsp 페이지에서 포스트 되도록        *
		 * 필드를 만들어 주도록 하십시요.                                  *
		 * 컨텐츠 제공업체의 경우 삭제하셔도 무방합니다.                   *
		 *-----------------------------------------------------------------*/
		inipay.SetField("recvname", request.getParameter("recvname")); // 수취인 명
		inipay.SetField("recvtel", request.getParameter("recvtel")); // 수취인 연락처
		inipay.SetField("recvaddr", request.getParameter("recvaddr")); // 수취인 주소
		inipay.SetField("recvpostnum", request.getParameter("recvpostnum")); // 수취인 우편번호
		inipay.SetField("recvmsg", request.getParameter("recvmsg")); // 전달 메세지

		inipay.SetField("joincard", request.getParameter("joincard")); // 제휴카드코드
		inipay.SetField("joinexpire", request.getParameter("joinexpire")); // 제휴카드유효기간
		inipay.SetField("id_customer", request.getParameter("id_customer")); // 일반적인 경우 사용하지 않음, user_id

		/****************
		 * 4. 지불 요청 *
		 ****************/
		inipay.startAction();

		/*****************
		 * 5. 결제  결과 *
		 *****************/
		/*****************************************************************************************************************
		 *  1 모든 결제 수단에 공통되는 결제 결과 데이터
		 * 	거래번호 : inipay.GetResult("tid")
		 * 	결과코드 : inipay.GetResult("ResultCode") ("00"이면 지불 성공)
		 * 	결과내용 : inipay.GetResult("ResultMsg") (지불결과에 대한 설명)
		 * 	지불방법 : inipay.GetResult("PayMethod") (매뉴얼 참조)
		 * 	상점주문번호 : inipay.GetResult("MOID")
		 *	결제완료금액 : inipay.GetResult("TotPrice")
		 * 	이니시스 승인날짜 : inipay.GetResult("ApplDate") (YYYYMMDD)
		 * 	이니시스 승인시각 : inipay.GetResult("ApplTime") (HHMMSS)  
		 *
		 *
		 * 결제 되는 금액 =>원상품가격과  결제결과금액과 비교하여 금액이 동일하지 않다면
		 * 결제 금액의 위변조가 의심됨으로 정상적인 처리가 되지않도록 처리 바랍니다. (해당 거래 취소 처리)
		 *
		 *  2. 일부 결제 수단에만 존재하지 않은 정보,
		 *     OCB Point/VBank 를 제외한 지불수단에 모두 존재.
		 * 	승인번호 : inipay.GetResult("ApplNum") 
		 *
		 *
		 *  3. 신용카드 결제 결과 데이터 (Card, VCard 공통)
		 * 	할부기간 : inipay.GetResult("CARD_Quota")
		 * 	무이자할부 여부 : inipay.GetResult("CARD_Interest") ("1"이면 무이자할부), 
		 *                    또는 inipay.GetResult("EventCode") (무이자/할인 행사적용 여부, 값에 대한 설명은 메뉴얼 참조)
		 * 	신용카드사 코드 : inipay.GetResult("CARD_Code") (매뉴얼 참조)
		 * 	카드발급사 코드 : inipay.GetResult("CARD_BankCode") (매뉴얼 참조)
		 * 	본인인증 수행여부 : inipay.GetResult("CARD_AuthType") ("00"이면 수행)
		 *  각종 이벤트 적용 여부 : inipay.GetResult("EventCode")
		 *
		 *
		 *      ** 달러결제 시 통화코드와  환률 정보 **
		 *	해당 통화코드 : inipay.GetResult("OrgCurrency")
		 *	환율 : inipay.GetResult("ExchangeRate")
		 *
		 *      아래는 "신용카드 및 OK CASH BAG 복합결제" 또는"신용카드 지불시에 OK CASH BAG적립"시에 추가되는 데이터
		 * 	OK Cashbag 적립 승인번호 : inipay.GetResult("OCB_SaveApplNum")
		 * 	OK Cashbag 사용 승인번호 : inipay.GetResult("OCB_PayApplNum")
		 * 	OK Cashbag 승인일시 : inipay.GetResult("OCB_ApplDate") (YYYYMMDDHHMMSS)
		 * 	OCB 카드번호 : inipay.GetResult("OCB_Num")
		 * 	OK Cashbag 복합결재시 신용카드 지불금액 : inipay.GetResult("CARD_ApplPrice")
		 * 	OK Cashbag 복합결재시 포인트 지불금액 : inipay.GetResult("OCB_PayPrice")
		 *
		 * 4. 실시간 계좌이체 결제 결과 데이터
		 *
		 * 	은행코드 : inipay.GetResult("ACCT_BankCode")
		 *	현금영수증 발행결과코드 : inipay.GetResult("CSHR_ResultCode")
		 *	현금영수증 발행구분코드 : inipay.GetResult("CSHR_Type")
		 *
		 * 5. OK CASH BAG 결제수단을 이용시에만  결제 결과 데이터
		 * 	OK Cashbag 적립 승인번호 : inipay.GetResult("OCB_SaveApplNum")
		 * 	OK Cashbag 사용 승인번호 : inipay.GetResult("OCB_PayApplNum")
		 * 	OK Cashbag 승인일시 : inipay.GetResult("OCB_ApplDate") (YYYYMMDDHHMMSS)
		 * 	OCB 카드번호 : inipay.GetResult("OCB_Num")
		 *
		 * 6. 무통장 입금 결제 결과 데이터
		 * 	가상계좌 채번에 사용된 주민번호 : inipay.GetResult("VACT_RegNum")
		 * 	가상계좌 번호 : inipay.GetResult("VACT_Num")
		 * 	입금할 은행 코드 : inipay.GetResult("VACT_BankCode")
		 * 	입금예정일 : inipay.GetResult("VACT_Date") (YYYYMMDD)
		 * 	송금자 명 : inipay.GetResult("VACT_InputName")
		 * 	예금주 명 : inipay.GetResult("VACT_Name")
		 *
		 * 7. 핸드폰, 전화 결제 결과 데이터( "실패 내역 자세히 보기"에서 필요 , 상점에서는 필요없는 정보임)
		 * 	전화결제 사업자 코드 : inipay.GetResult("HPP_GWCode")
		 *
		 * 8. 핸드폰 결제 결과 데이터
		 * 	휴대폰 번호 : inipay.GetResult("HPP_Num") (핸드폰 결제에 사용된 휴대폰번호)
		 *
		 * 9. 전화 결제 결과 데이터
		 * 	전화번호 : inipay.GetResult("ARSB_Num") (전화결제에  사용된 전화번호)
		 *
		 * 10. 문화 상품권 결제 결과 데이터
		 * 	컬쳐 랜드 ID : inipay.GetResult("CULT_UserID")
		 *
		 * 11. 현금영수증 발급 결과코드 (은행계좌이체시에만 리턴)
		 *    inipay.GetResult("CSHR_ResultCode")
		 *
		 * 12.틴캐시 잔액 데이터
		 *    inipay.GetResult("TEEN_Remains")
		 *  틴캐시 ID : inipay.GetResult("TEEN_UserID")
		 *
		 * 13.게임문화 상품권
		 *	사용 카드 갯수 : inipay.GetResult("GAMG_Cnt")
		 *
		 * 14.도서문화 상품권
		 *	사용자 ID : inipay.GetResult("BCSH_UserID")
		 *
		 ****************************************************************************************************************/

		/*******************************************************************
		 * 7. DB연동 실패 시 강제취소                                      *
		 *                                                                 *
		 * 지불 결과를 DB 등에 저장하거나 기타 작업을 수행하다가 실패하는  *
		 * 경우, 아래의 코드를 참조하여 이미 지불된 거래를 취소하는 코드를 *
		 * 작성합니다.                                                     *
		 *******************************************************************/
		/*
		boolean cancelFlag = false;
		// cancelFlag를 "ture"로 변경하는 condition 판단은 개별적으로
		// 수행하여 주십시오.

		if(cancelFlag)
		{
		  String tmp_TID = inipay.GetResult("tid");
		  inipay.SetField("type", "cancel");         // 고정
		  inipay.SetField("tid", tmp_TID);              // 고정
		  inipay.SetField("cancelmsg", "DB FAIL");   // 취소사유
		  inipay.startAction();
		}
		 */
		/*-------------------------------------------------------------------------------------------------------
		 * 결제 방법에 따라 상단 이미지가 변경 된다								*
		 * 	 가. 결제 실패 시에 "img/spool_top.gif" 이미지 사용						*
		 *       가. 결제 방법에 따라 상단 이미지가 변경							*
		 *       	1. 신용카드 	- 	"img/card.gif"							*
		 *		2. ISP		-	"img/card.gif"							*
		 *		3. 은행계좌	-	"img/bank.gif"							*
		 *		4. 무통장입금	-	"img/bank.gif"							*
		 *		5. 핸드폰	- 	"img/hpp.gif"							*
		 *		6. 전화결제 (ars전화 결제)	-	"img/phone.gif"					*
		 *		7. 전화결제 (받는전화결제)	-	"img/phone.gif"					*
		 *		8. OK CASH BAG POINT		-	"img/okcash.gif"				*
		 *		9. 문화상품권		-	"img/ticket.gif"					*
		 *              10. K-merce 상품권 	- 	"img/kmerce.gif"                                        *
		 *		11. 틴캐시 결제		- 	"img/teen_top.gif"                                      *
		 *              12. 게임문화 상품권    -       "img/dgcl_top.gif"                                       *
		 -------------------------------------------------------------------------------------------------------*/
		String background_img = "";
		if (inipay.GetResult("ResultCode").equals("01")) {
			background_img = "img/spool_top.gif";
		} else {
			Hashtable data_bgrImg = new Hashtable();
			background_img = "img/card.gif"; //default image

			try {
				data_bgrImg.put("Card", "img/card.gif"); //신용카드
				data_bgrImg.put("VCard", "img/card.gif"); //ISP
				data_bgrImg.put("HPP", "img/hpp.gif"); //휴대폰
				data_bgrImg.put("Ars1588Bill", "img/phone.gif"); //1588
				data_bgrImg.put("PhoneBill", "img/phone.gif");// 폰빌
				data_bgrImg.put("OCBPoint", "img/okcash.gif");// OKCASHBAG
				data_bgrImg.put("DirectBank", "img/bank.gif");// 은행계좌이체
				data_bgrImg.put("VBank", "img/bank.gif"); // 무통장 입금 서비스
				data_bgrImg.put("Culture", "img/ticket.gif");// 문화상품권 결제
				data_bgrImg.put("TEEN", "img/teen_top.gif");// 틴캐시 결제
				data_bgrImg.put("DGCL", "img/dgcl_top.gif"); // 게임문화 상품권
				data_bgrImg.put("BCSH", "img/ticket_top.gif"); // 도서문화 상품권

				Object tmp = data_bgrImg.get(inipay.GetResult("PayMethod"));
				background_img = (tmp != null) ? (String) tmp : background_img;
			} catch (Exception ex) {
				// default image
			}
		}
	 	if (inipay.GetResult("ResultCode").equals("00") && inipay.GetResult("PayMethod").equals("VBank")) {
	 		model.addAttribute("rs_msg", "고객님의 무통장입금 요청이 완료되었습니다.");
	 		//out.write("고객님의 무통장입금 요청이 완료되었습니다.");
	 	} else if (inipay.GetResult("ResultCode").equals("00")) {
	 		//out.write("고객님의 결제요청이 성공되었습니다.");
	 		model.addAttribute("rs_msg","고객님의 결제요청이 성공되었습니다.");
	 	} else {
	 		//out.write("고객님의 결제요청이 실패되었습니다.");
	 		model.addAttribute("rs_msg", "고객님의 결제요청이 실패되었습니다.");
	 	}
	 	
	 	if ("1".equals(inipay.GetResult("CARD_Interest"))) {
	 		model.addAttribute("EventCode", "무이자");
 			//out.println("무이자");
 		} else if ("1".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "무이자 (이니시스&카드사부담 일반 무이자 할부 이벤트)");
 			//out.println("무이자 (이니시스&카드사부담 일반 무이자 할부 이벤트)");
 		} else if ("12".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "카드사부담 일반 무이자 + 상점 일반 할인 이벤트");
 			//out.println("카드사부담 일반 무이자 + 상점 일반 할인 이벤트");
 		} else if ("14".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "카드사부담 일반 무이자 + 카드번호별 할인 이벤트");
 			//out.println("카드사부담 일반 무이자 + 카드번호별 할인 이벤트");
 		} else if ("24".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "카드사부담 일반 무이자 + 카드 Prefix별 할인 이벤트");
 			//out.println("카드사부담 일반 무이자 + 카드 Prefix별 할인 이벤트");
 		} else if ("A1".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "상점부담 일반 무이자 할부 이벤트");
 			//out.println("상점부담 일반 무이자 할부 이벤트");
 		} else if ("A2".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "무이자");
 			//out.println("상점 일반 할인 이벤트");
 		} else if ("A3".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "상점 무이자 + 상점 일반 할인 이벤트");
 			//out.println("상점 무이자 + 상점 일반 할인 이벤트");
 		} else if ("A4".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "상점 무이자 + 카드번호별 할인 이벤트");
 			//out.println("상점 무이자 + 카드번호별 할인 이벤트");
 		} else if ("A5".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "카드번호별 할인 이벤트");
 			//out.println("카드번호별 할인 이벤트");
 		} else if ("B4".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "상점 무이자 + 카드 Prefix별 할인 이벤트");
 			//out.println("상점 무이자 + 카드 Prefix별 할인 이벤트");
 		} else if ("B5".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "카드 Prefix별 할인 이벤트");
 			//out.println("카드 Prefix별 할인 이벤트");
 		} else if ("C0".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "당사&카드사부담 특별 무이자 할부 이벤트");
 			//out.println("당사&카드사부담 특별 무이자 할부 이벤트");
 		} else if ("C1".equals(inipay.GetResult("EventCode"))) {
 			model.addAttribute("EventCode", "상점부담 특별 무이자 할부 이벤트");
 			//out.println("상점부담 특별 무이자 할부 이벤트");
 		} else {
 			model.addAttribute("EventCode", "일반");
 			//out.println("일반");
 		}
		
		model.addAttribute("resultCode", inipay.GetResult("ResultCode"));
		model.addAttribute("tid", inipay.GetResult("tid"));
		model.addAttribute("resultErrorCode", inipay.GetResult("ResultErrorCode"));
		model.addAttribute("mid", inipay.GetResult("MID"));
		model.addAttribute("goodname", inipay.GetResult("goodname"));
		model.addAttribute("price", inipay.GetResult("price"));
		model.addAttribute("paymethod", inipay.GetResult("PayMethod"));
		model.addAttribute("buyername", inipay.GetResult("buyerName"));
		model.addAttribute("buyertel", inipay.GetResult("buyertel"));
		model.addAttribute("buyeremail", inipay.GetResult("buyeremail"));
		model.addAttribute("codegw", inipay.GetResult("HPP_GWCode"));
		model.addAttribute("bg_img", inipay.GetResult("background_img"));
		model.addAttribute("resultmsg", inipay.GetResult("ResultMsg"));
		model.addAttribute("moid", inipay.GetResult("MOID"));
		model.addAttribute("totprice", inipay.GetResult("TotPrice"));
		model.addAttribute("CARD_Num", inipay.GetResult("CARD_Num"));
		model.addAttribute("ApplDate", inipay.GetResult("ApplDate"));
		model.addAttribute("ApplTime", inipay.GetResult("ApplTime"));
		model.addAttribute("ApplNum", inipay.GetResult("ApplNum"));
		model.addAttribute("CARD_Quota", inipay.GetResult("CARD_Quota"));
		model.addAttribute("CARD_Code", inipay.GetResult("CARD_Code"));
		model.addAttribute("CARD_BankCode", inipay.GetResult("CARD_BankCode"));
		model.addAttribute("OrgCurrency", inipay.GetResult("OrgCurrency"));
		model.addAttribute("ExchangeRate", inipay.GetResult("ExchangeRate"));
		model.addAttribute("OCB_Num", inipay.GetResult("OCB_Num"));
		model.addAttribute("OCB_SaveApplNum", inipay.GetResult("OCB_SaveApplNum"));
		model.addAttribute("OCB_PayApplNum", inipay.GetResult("OCB_PayApplNum"));
		model.addAttribute("OCB_ApplDate", inipay.GetResult("OCB_ApplDate"));
		model.addAttribute("OCB_PayPrice", inipay.GetResult("OCB_PayPrice"));
		model.addAttribute("VACT_RegNum", inipay.GetResult("VACT_RegNum"));
		
		model.addAttribute("ACCT_BankCode", inipay.GetResult("ACCT_BankCode"));
		model.addAttribute("CSHR_ResultCode", inipay.GetResult("CSHR_ResultCode"));
		model.addAttribute("CSHR_Type", inipay.GetResult("CSHR_Type"));
		model.addAttribute("VACT_Num", inipay.GetResult("VACT_Num"));
		model.addAttribute("VACT_BankCode", inipay.GetResult("VACT_BankCode"));
		model.addAttribute("VACT_Name", inipay.GetResult("VACT_Name"));
		model.addAttribute("VACT_InputName", inipay.GetResult("VACT_InputName"));
		model.addAttribute("VACT_Date", inipay.GetResult("VACT_Date"));
		model.addAttribute("VACT_Time", inipay.GetResult("VACT_Time"));
		model.addAttribute("HPP_Num", inipay.GetResult("HPP_Num"));
		model.addAttribute("PHNB_Num", inipay.GetResult("PHNB_Num"));
		model.addAttribute("ARSB_Num", inipay.GetResult("ARSB_Num"));
		
		model.addAttribute("CULT_UserID", inipay.GetResult("CULT_UserID"));
		model.addAttribute("TEEN_Remains", inipay.GetResult("TEEN_Remains"));
		model.addAttribute("TEEN_UserID", inipay.GetResult("TEEN_UserID"));
		model.addAttribute("GAMG_Cnt", inipay.GetResult("GAMG_Cnt"));
		model.addAttribute("GAMG_Num", inipay.GetResult("GAMG_Num"));
		model.addAttribute("GAMG_Remains", inipay.GetResult("GAMG_Remains"));
		model.addAttribute("GAMG_ErrMsg", inipay.GetResult("GAMG_ErrMsg"));
		model.addAttribute("BCSH_UserID", inipay.GetResult("BCSH_UserID"));
		
		logger.info("mid 商户id"+inipay.GetResult("MID"));
		logger.info("tid 业务处理id"+inipay.GetResult("tid"));
		logger.info("moid 订单id 等于oid"+inipay.GetResult("MOID"));
		return "INIpay/INIsecureresult";
	}

}
