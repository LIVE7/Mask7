package com.project.mask7.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.mask7.common.CommonUtil;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	private CommonUtil util;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "main";
	}
	
	@RequestMapping("/top")
	public void showTop() {
		
	}
	@RequestMapping("/foot")
	public void showFoot() {
		
	}
	
	@GetMapping("/main")
	public String main(Model m) {
		System.out.println("main¿äÃ» µé¾î¿È");
		return "main";
	}
	
	@GetMapping("/covid")
	public String covid(Model m) {
		System.out.println("covid¿äÃ» µé¾î¿È");
		return "covid";
	}
	
	@GetMapping("/mask")
	public String mask(Model m) {
		System.out.println("mask¿äÃ» µé¾î¿È");
		return "mask";
	}
	
	@GetMapping("/mask5")
	public String mask5(Model m) {
		System.out.println("mask5¿äÃ» µé¾î¿È");
		return "mask5";
	}
	
	@GetMapping("/developer")
	public String developer(Model m) {
		System.out.println("about¿äÃ» µé¾î¿È");
		return "developer";
	}
	
}
