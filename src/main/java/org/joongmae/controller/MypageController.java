package org.joongmae.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joongmae.domain.BuyListWithPaging;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.DealListWithPaging;
import org.joongmae.domain.MemberVO;
import org.joongmae.domain.PageDTO;
import org.joongmae.domain.SelectDTO;
import org.joongmae.domain.SellVO;

import org.joongmae.domain.WishListVO;
import org.joongmae.service.MypageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.emory.mathcs.backport.java.util.Arrays;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/myPage/*")
@AllArgsConstructor
public class MypageController {

	private MypageService service;

	@GetMapping("/main")
	public String main(@RequestParam("id") String id, Model model) {
		model.addAttribute("member", service.getMemberDetail(id));		
		return "mypage/myPage_main";
	}

	@GetMapping("/buyList")
	public String getBuyList(Criteria cri, Model model) {		
		return "mypage/myPage_buy";
	}

	@GetMapping("/sellList")
	public String getSellList(Criteria cri, Model model) {
		model.addAttribute("list", service.getSellList(cri));
		model.addAttribute("wishlist", service.getWishList(cri));
		int total = service.countSell(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));	
		
		return "mypage/myPage_sell";
	}	

	@GetMapping("/dealList")
	public String getDealList(Criteria cri ,Model model) {
		model.addAttribute("list", service.getDealList(cri));
		int total = service.countDeal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));	
		return "mypage/myPage_deal";
	}

	@GetMapping({ "/detailMember", "/modifyMember" })
	public String getMemberDetail(@RequestParam("id") String id, Model model) {

		model.addAttribute("member", service.getMemberDetail(id));
		return "mypage/myPage_member";
	}

	@PostMapping("/modifyMember")
	public String modifyMember(@RequestParam(value="id", required=false) String id,
			MemberVO member, RedirectAttributes rttr) {
		System.out.println(member);
		service.modifyMember(member);
		return "redirect:/myPage/main?id=" + id;
	}
	
	@RequestMapping(value="/deleteMember", method={RequestMethod.POST, RequestMethod.GET})
	public String deleteMember(@RequestParam("id") String id){
		service.deleteMember(id);
		return "redirect:/myPage/main?id=" + id;
	}
	
	@GetMapping("/wishList")
	public String getWishList(Criteria cri, Model model) {
		model.addAttribute("list", service.getWishList(cri));

		int total = service.countWish(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "mypage/myPage_wishList";
	}
	
	@RequestMapping("/addWishList/{sellNo}")
	@ResponseBody
	public void addWishList(WishListVO wishList, @PathVariable("sellNo") int sellNo){
		log.info(wishList);		
		service.addWishList(wishList);			
	}
	
	@RequestMapping("/deleteWishList/{sellNo}")
	@ResponseBody
	public void deleteWishList(@PathVariable("sellNo") int sellNo){
		service.deleteWishList(sellNo);
	}
	
	@RequestMapping("/deleteWish")
	public void deleteWish(@RequestParam("list") String str,SelectDTO wishNo){		
		wishNo.setList(Arrays.asList(str.split(",")));
		service.deleteWish(wishNo);
	}
	
	@GetMapping("/heartColor")
	@ResponseBody
	public Map<String,List<?>> heartColor(Criteria cri) {			
		
		HashMap<String, List<?>> jsonMap = new HashMap<>();		
		jsonMap.put("wishList", service.getWishList(cri));
		jsonMap.put("sellList", service.getSellList(cri));		
		
		return jsonMap;
	}	
	
	@GetMapping("/sellDetail/{sellNo}")
	@ResponseBody
	public SellVO getSellDetail(@PathVariable("sellNo") int sellNo){
		
		SellVO vo = service.getSellDetail(sellNo);		
		return vo;
	}
	
	@GetMapping("/dealDetail/{dealNo}")
	@ResponseBody
	public DealAndSell getDealDetail(@PathVariable("dealNo") int dealNo){
		
		DealAndSell vo = service.getDealDetail(dealNo);		
		return vo;
	}
	
	@GetMapping("/buyDetail/{buyNo}")
	@ResponseBody
	public BuyVO getBuyDetail(@PathVariable("buyNo") int buyNo){
		
		BuyVO vo = service.getBuyDetail(buyNo);		
		return vo;
	}
	
	@GetMapping("/dealListAjax/{page}")
	@ResponseBody
	public ResponseEntity<DealListWithPaging> dealList(@PathVariable("page") int page) {			
		
		Criteria cri = new Criteria(page, 9);				
		return new ResponseEntity<>(service.getDealListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/buyListAjax/{page}/{month}")
	@ResponseBody
	public ResponseEntity<BuyListWithPaging> buyList(@PathVariable("page") int page,
				Criteria cri ,@PathVariable("month") int month) {		
		cri = new Criteria(page, 10);			
		cri.setMonth(month);
		System.out.println(month);
		return new ResponseEntity<>(service.getBuyListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/dateSearchRange/{page}/{startDate}/{endDate}")
	@ResponseBody
	public ResponseEntity<BuyListWithPaging> dateSearchRange(@PathVariable("page") int page,
			Criteria cri, @PathVariable String startDate, @PathVariable String endDate){			
			cri = new Criteria(page, 10);	
			cri.setStartDate(startDate);
			cri.setEndDate(endDate);
			return new ResponseEntity<>(service.dateSearchRange(cri), HttpStatus.OK);
	}
	
	@GetMapping("/completeDeal")
	@ResponseBody
	public Map<String,List<DealAndSell>> completeDeal() {			
		
		HashMap<String, List<DealAndSell>> jsonMap = new HashMap<>();		
		jsonMap.put("complete", service.completeDeal());			
		
		return jsonMap;
	}
	
	@GetMapping("/progressDeal")
	@ResponseBody
	public Map<String,List<DealAndSell>> progressDeal() {			
		
		HashMap<String, List<DealAndSell>> jsonMap = new HashMap<>();		
		jsonMap.put("progress", service.progressDeal());			
		
		return jsonMap;
	}
	
	
	@PostMapping("/uploadAjaxAction")
	@ResponseBody
	public void uploadAjaxPost(MultipartFile uploadFile){
		
		String uploadFolder = "C:\\Users\\82109\\Documents\\project\\Architecture-kosta202\\src\\main\\webapp\\resources\\img\\upload_cyg";	
		String uploadFileName = uploadFile.getOriginalFilename();			
		
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			uploadFile.transferTo(saveFile);
			
			if(checkImageType(saveFile)){
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolder,
						"s_" + uploadFileName));
				
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
				thumbnail.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	private boolean checkImageType(File file){
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}	
	
}
