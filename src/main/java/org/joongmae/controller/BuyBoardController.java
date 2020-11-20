package org.joongmae.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyDTO;
import org.joongmae.domain.BuyPageDTO;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.service.BuyBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/buyBoard/*")
public class BuyBoardController {
	
	@Autowired
	private BuyBoardService service;
	
	@GetMapping("/registerForm")
	public String registerForm(){
		
		return "buyBoard/registerForm";
	}
	
	@PostMapping("/register")
	public String register(BuyDTO dto){
		System.out.println(dto);
		
		BuyVO vo = new BuyVO();
		
		vo.setId("test");
		vo.setTitle(dto.getTitle());
		vo.setKeyword1(dto.getKeyword1());
		vo.setKeyword2(dto.getKeyword2());
		vo.setKeyword3(dto.getKeyword3());
		vo.setType(dto.getType());
		vo.setRegion(dto.getRegion());
		vo.setMinPrice(Integer.parseInt(dto.getMinPrice().replace(",", "")));
		vo.setMaxPrice(Integer.parseInt(dto.getMaxPrice().replace(",", "")));
		vo.setStatus(dto.getStatus());
		vo.setBigClassifier(dto.getBigClassifier());
		vo.setMediumClassifier(dto.getMediumClassifier());
		
		service.register(vo);
		
		return "redirect:/buyBoard/list";
	}
	
	
	@RequestMapping("/list")
	public String list(BuyCriteria cri, Model model, HttpServletRequest request){
		
		if(cri.getBigClassifier() != null){
			String price = request.getParameter("price");
			model.addAttribute("price", price);
			System.out.println("price : " + price);
			int minPrice = Integer.parseInt(price.substring(0, price.indexOf('-') - 1));
			int maxPrice = Integer.parseInt(price.substring(price.indexOf('-') + 2));
			cri.setMinPrice(minPrice);
			cri.setMaxPrice(maxPrice);
		}
		
		model.addAttribute("list", service.list(cri));
		System.out.println(cri);
		
		int total = service.buyTotalCount(cri);
		log.info(service.buyTotalCount(cri));
		model.addAttribute("pageMaker", new BuyPageDTO(total, cri));
		
		List<MemberVO> memberList = service.memberList();
		model.addAttribute("member", memberList);
		
		return "buyBoard/list";
		
	}
	
	@GetMapping("/detail")
	public String detail(BuyCriteria cri ,@RequestParam("buyNo") int buyNo, 
			@RequestParam("id") String id, Model model, HttpServletRequest request){
		
		if(cri.getBigClassifier() != null){
			String price =request.getParameter("price");
			model.addAttribute("price", price);
		}
		
		int total = service.buyTotalCount(cri);
		model.addAttribute("pageMaker", new BuyPageDTO(total, cri));
		
		model.addAttribute("member", service.memberDetail(id));
		
		model.addAttribute("buy", service.detail(buyNo));
		
		return "buyBoard/detail";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("buyNo") int buyNo){
		
		service.delete(buyNo);
		
		return "redirect:/buyBoard/list";
	}
	
	@GetMapping("/reRegisterForm")
	public String reRegisterForm(@RequestParam("buyNo") int buyNo, Model model){
		
		model.addAttribute("buy", service.detail(buyNo));
		
		return "/buyBoard/reRegisterForm";
	}
	
	@PostMapping("/reRegister")
	public String reRegister(@RequestParam("buyNo") int buyNo, BuyDTO dto){
		
		BuyVO buy = new BuyVO();
		
		buy.setId("test");
		buy.setTitle(dto.getTitle());
		buy.setKeyword1(dto.getKeyword1());
		buy.setKeyword2(dto.getKeyword2());
		buy.setKeyword3(dto.getKeyword3());
		buy.setType(dto.getType());
		buy.setRegion(dto.getRegion());
		buy.setMinPrice(Integer.parseInt(dto.getMinPrice().replace(",", "")));
		buy.setMaxPrice(Integer.parseInt(dto.getMaxPrice().replace(",", "")));
		buy.setStatus(dto.getStatus());
		buy.setBigClassifier(dto.getBigClassifier());
		buy.setMediumClassifier(dto.getMediumClassifier());
		
		service.reRegister(buy, buyNo);
		
		return "redirect:/buyBoard/list";
	}
	
}












