package org.joongmae.controller;

import org.joongmae.domain.DealVO;
import org.joongmae.domain.PayVO;
import org.joongmae.service.DealService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/deal/*")
@Log4j
public class DealController {
	
	@Setter(onMethod_ = @Autowired)
	private DealService service;
	
	@PostMapping("/register")
	public String register(@ModelAttribute DealVO deal){
		
		deal.setStatus("거래중");
		
		service.registerDeal(deal);
		
		return null;
	}
	
	@GetMapping(value = "/cancel", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> cancel(int dealNo){
		int i = service.cancel(dealNo);
		
		return i == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/send")
	public String send(int dealNo){
		
		service.send(dealNo);
		
		return "redirect:/myPage/dealList";
	}
	
	@GetMapping(value = "/done", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> done(int dealNo){
		int i = service.done(dealNo);
		
		return i == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pay", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> pay(int dealNo){
		
		PayVO pay = service.detailDeal(dealNo);
		
		int i = service.registerPay(pay);
		service.registerPayDone(dealNo);
		
		return i == 1 ? new ResponseEntity<String>(Integer.toString(dealNo), HttpStatus.OK) : new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/refund", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> refund(int dealNo){
		int i = service.refund(dealNo);
		
		return i == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) : new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
