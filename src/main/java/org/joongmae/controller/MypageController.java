package org.joongmae.controller;


import java.security.Principal;

import org.joongmae.domain.Criteria;

import org.joongmae.domain.MemberVO;
import org.joongmae.domain.PageDTO;

import org.joongmae.service.MypageService;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
@RequestMapping("/myPage/*")
@AllArgsConstructor
public class MypageController {

	private MypageService service;

	@GetMapping("/main")	
	public String main(Principal id, Model model, Criteria cri) {
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());
		model.addAttribute("member", service.getMemberDetail(id.getName()));		
		model.addAttribute("buyCnt", service.buyCnt(id.getName()));
		model.addAttribute("sellCnt", service.sellCnt(id.getName()));
		model.addAttribute("completeCnt", service.completeCnt(cri));
		model.addAttribute("progressCnt", service.progressCnt(cri));
		return "mypage/myPage_main";
	}
	
	@GetMapping("/buyList")
	public String getBuyList(Criteria cri, Model model, Principal id) {			
		cri.setId(id.getName());
		return "mypage/myPage_buy";
	}

	@GetMapping("/sellList")
	public String getSellList(Criteria cri, Model model, Principal id) {
		cri.setId(id.getName());
		model.addAttribute("list", service.getSellList(cri));
		model.addAttribute("wishlist", service.getWishList(cri));
		model.addAttribute("count", service.countSell(cri));		
		int total = service.countSell(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));			
		return "mypage/myPage_sell";
	}	
	
	@GetMapping("/matchingSellList")
	public String getMatchingSellList(Principal id, Criteria cri, Model model){
		cri.setBuyId(id.getName());		
		return "mypage/myPage_matching";		
	}

	@GetMapping("/dealList")
	public String getDealList(Criteria cri ,Model model, Principal id) {		
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());
		
		model.addAttribute("completeCnt", service.completeCnt(cri));
		model.addAttribute("progressCnt", service.progressCnt(cri));
		return "mypage/myPage_deal";
	}
	
	@GetMapping("/wishList")
	public String getWishList(Criteria cri, Model model, Principal id) {
		cri.setId(id.getName());
		model.addAttribute("count", service.countWish(cri));		
		return "mypage/myPage_wishList";
	}

	@GetMapping({ "/detailMember", "/modifyMember" })
	public String getMemberDetail(Principal id, Model model) {
		model.addAttribute("member", service.getMemberDetail(id.getName()));
		return "mypage/myPage_member";
	}

	@PostMapping("/modifyMember")
	public String modifyMember(MemberVO member) {		
		service.modifyMember(member);
		return "redirect:/myPage/main";
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember(@RequestParam(value="id", required=false) Principal id){
		service.deleteMember(id.getName());
		return "redirect:/member/login";
	}
	
	@RequestMapping("/deleteAllSell")	
	public String deleteAllSell(){
		service.deleteAllSell();		
		return "redirect:/myPage/sellList";
	}	
	
	@RequestMapping("/deleteAllWish")
	public String deleteAllWish(){
		service.deleteAllWish();
		return "redirect:/myPage/wishList";
	}	
	
}
