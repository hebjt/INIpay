package com.tanghsk.inipay.action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class INIpayAction {
	@RequestMapping(value="ini_securestart",method=RequestMethod.GET)
	public String INIsecurestart(Model model){
		
		return "INIpay/INIsecurestart";
	}

}
