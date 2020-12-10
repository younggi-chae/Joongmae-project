package org.joongmae.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.joongmae.domain.SellVO;
import org.joongmae.service.SellService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sell/*")
@Log4j
public class SellController {
	
	@Setter(onMethod_ = @Autowired)
	private SellService service;
	
	@GetMapping("/detail")
	public String detail(int sellNo, Model model){
		SellVO sell = service.detail(sellNo);
		log.info(sell);
		
		model.addAttribute("sell", sell);
		
		return "sell/detail";
	}
	
	@GetMapping("/registerForm")
	public String registerForm(){
		return "sell/register";
	}
	
	@GetMapping("/modifyForm")
	public String modifyForm(int sellNo, Model model){
		SellVO sell = service.detail(sellNo);
		
		model.addAttribute("sell", sell);
		log.info(sell);
		
		return "sell/modify";
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute SellVO sell, @RequestParam("fileName") MultipartFile[] files, Principal principal){
		sell.setId(principal.getName());
		sell.setStatus("등록");
		
		String picture = "";
		for (MultipartFile file : files) {
			log.info(file.getOriginalFilename());
			picture += file.getOriginalFilename() + ",";
			try {
				file.transferTo(new File(file.getOriginalFilename()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		sell.setPicture(picture.substring(0, picture.length() - 1));
		
		log.info(sell);
		
		service.register(sell);
		service.registerAlarm(sell);
		
		return "redirect:/myPage/sellList";
	}
	
	@PostMapping("/modify")
	public String modify(@ModelAttribute SellVO sell, @RequestParam("fileName") MultipartFile[] files){
		sell.setId("test");
		sell.setStatus("등록");
		
		String picture = "";
		for (MultipartFile file : files) {
			log.info(file.getOriginalFilename());
			picture += file.getOriginalFilename() + ",";
			try {
				file.transferTo(new File(file.getOriginalFilename()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		sell.setPicture(picture.substring(0, picture.length() - 1));
		
		log.info(sell);
		
		service.modify(sell);
		
		return "redirect:/sell/list";
	}
	
	@GetMapping("/delete")
	public String delete(int sellNo){
		service.delete(sellNo);
		
		return null;
	}
	
	@GetMapping("/list")
	public String list(Model model){
		List<SellVO> list = service.list();
		log.info(list);
		
		model.addAttribute("list", list);
		
		return "sell/list";
	}
	
	@GetMapping("/deleteSelectedSell")
	public String deleteSelecteSell(@RequestParam("list") String list){
		String[] sellNo = list.split(",");
		
		for (int i = 0; i < sellNo.length; i++) {
			service.delete(Integer.parseInt(sellNo[i]));
		}
		
		return "redirect:/sell/list";
	}
	
	@GetMapping("/reRegister")
	public String reRegister(int sellNo){
		service.reRegister(sellNo);
		
		return "redirect:/sell/list";
	}
	
}
