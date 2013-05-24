package com.tanghsk.inipay.action;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.inicis.inipay.INIpay;
import com.inicis.inipay.INIpay50;

@Controller
public class INIpayAction {
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
		inipay.SetField("inipayhome", "/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이
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
		inipay.SetField("inipayhome", "/home/cuijingtao/workspace/INIpay/WebContent/"); // 이니페이
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

}
