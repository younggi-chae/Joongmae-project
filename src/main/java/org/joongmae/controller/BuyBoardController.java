package org.joongmae.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyDTO;
import org.joongmae.domain.BuyPageDTO;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.SellVO;
import org.joongmae.service.BuyBoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/buyBoard/*")
public class BuyBoardController {
   
   @Autowired
   private BuyBoardService service;
   
   
   //구매등록 폼 이동
   @GetMapping("/registerForm")
   public String registerForm(){
      return "buyBoard/registerForm";
   }
   
   
   //구매등록
   @PostMapping("/register")
   public String register(BuyDTO dto, Principal principal){
      System.out.println(dto);
      
      BuyVO vo = new BuyVO();
      
      vo.setId(principal.getName());
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
      service.registerAlarm(vo);
      
      return "redirect:/buyBoard/list";
   }
   
   
   //구매게시판
   @RequestMapping("/list")
   public String list(BuyCriteria cri, Model model, HttpServletRequest request, Principal principal){
      
      if(cri.getBigClassifier() != null){
         
         String price = request.getParameter("price");
         model.addAttribute("price", price);
         System.out.println("price : " + price);
         int minPrice = Integer.parseInt(price.substring(0, price.indexOf('-') - 1));
         int maxPrice = Integer.parseInt(price.substring(price.indexOf('-') + 2));
         cri.setMinPrice(minPrice);
         cri.setMaxPrice(maxPrice);
         
      }
      
      if(principal != null){
    	  String id = principal.getName();
    	  model.addAttribute("alarm", service.alarmList(id));
      }
      
      model.addAttribute("list", service.list(cri));
      System.out.println("cri : " + cri);
      System.out.println(service.list(cri));
      log.info(cri);
      log.info(service.list(cri));
      
      int total = service.buyTotalCount(cri);
      log.info(service.buyTotalCount(cri));
      model.addAttribute("pageMaker", new BuyPageDTO(total, cri));
      
      List<MemberVO> memberList = service.memberList();
      model.addAttribute("member", memberList);
      
      return "buyBoard/list";
      
   }
   
   //상세보기
   @GetMapping("/detail")
   public String detail(BuyCriteria cri ,@RequestParam("buyNo") int buyNo, 
         @RequestParam("id") String id, Model model, HttpServletRequest request, Principal principal){
      
      if(cri.getBigClassifier() != null){
         String price =request.getParameter("price");
         model.addAttribute("price", price);
      }
      
      if(principal != null){
    	  model.addAttribute("sell", service.sellList(principal.getName()));
      }
      
      int total = service.buyTotalCount(cri);
      model.addAttribute("pageMaker", new BuyPageDTO(total, cri));
      
      model.addAttribute("member", service.memberDetail(id));
      
      model.addAttribute("buy", service.detail(buyNo));
      log.info(service.detail(buyNo));
      
      return "buyBoard/detail";
   }
   
   //구매등록 삭제
   @GetMapping("/delete")
   public String delete(@RequestParam("buyNo") int buyNo){
      
      service.delete(buyNo);
      
      return "redirect:/buyBoard/list";
   }
   
   //재등록 폼 이동
   @GetMapping("/reRegisterForm")
   public String reRegisterForm(@RequestParam("buyNo") int buyNo, Model model){
      model.addAttribute("buy", service.detail(buyNo));
      
      return "/buyBoard/reRegisterForm";
   }
   
   
   //재등록
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
   
   
   //견적서 상세 보기
   @GetMapping(value = "/sellDetail/{sellNo}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
   @ResponseBody
   public SellVO sellDetail(@PathVariable("sellNo") int sellNo){
	   
	   SellVO sellDetail = service.sellDetail(sellNo);
	   
	   return sellDetail;
	   
   }
   
   
   //알람 등록
   @GetMapping(value = "/registerAlarm/{buyNo}/{buyId}/{sellId}/{list}")
   @ResponseBody
   public void registerAlarm(@PathVariable("buyNo") int buyNo, @PathVariable("buyId") String buyId, 
		   @PathVariable("sellId") String sellId, @PathVariable("list") String[] list){
	   
	   AlarmVO alarm = new AlarmVO();
	   alarm.setBuyNo(buyNo);
	   alarm.setBuyId(buyId);
	   alarm.setSellId(sellId);
	   
	   for (int i = 0; i < list.length; i++) {
		alarm.setSellNo(Integer.parseInt(list[i]));
		service.registerAlarm(alarm);
	}
	  
   }
   
   
}














