package org.joongmae.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.annotation.Repeatable;
import java.nio.file.Files;
import java.security.Principal;
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
import org.joongmae.domain.ReplyVO;
import org.joongmae.domain.SellListWithPaging;
import org.joongmae.domain.SellVO;

import org.joongmae.domain.WishListVO;
import org.joongmae.domain.WishListWithPaging;
import org.joongmae.service.MypageService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@PostMapping("/deleteBuy/{buyNo}")
	@ResponseBody
	public void deleteBuy(@PathVariable("buyNo") int buyNo){
		service.deleteBuy(buyNo);		
	}
	
	@PostMapping("/deleteSell/{sellNo}")	
	@ResponseBody
	public void deleteSell(@PathVariable("sellNo") int sellNo){
		service.deleteWishList(sellNo);
		service.deleteSell(sellNo);		
	}
	
	@PostMapping("/deleteDeal/{dealNo}")
	@ResponseBody
	public void deleteDeal(@PathVariable("dealNo") int dealNo){
		service.deleteDeal(dealNo);
	}
	
	@RequestMapping("/deleteAllSell")	
	public String deleteAllSell(){
		service.deleteAllSell();		
		return "redirect:/myPage/sellList";
	}	
	
	@RequestMapping("/addWishList/{sellNo}")
	@ResponseBody
	public void addWishList(WishListVO wishList, @PathVariable("sellNo") int sellNo){		
		service.addWishList(wishList);			
	}
	
	@RequestMapping("/deleteWishList/{sellNo}")
	@ResponseBody
	public void deleteWishList(@PathVariable("sellNo") int sellNo){
		service.deleteWishList(sellNo);
	}
	
	@RequestMapping(value="/deleteWish", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void deleteWish(@RequestParam(value="checkArr[]", required=false) List<String> checkArr){		
		service.deleteWish(checkArr);		
	}
	
	@RequestMapping("/deleteAllWish")
	public String deleteAllWish(){
		service.deleteAllWish();
		return "redirect:/myPage/wishList";
	}
	
	@GetMapping("/heartColor")
	@ResponseBody
	public Map<String,List<?>> heartColor(Criteria cri, Principal id) {			
		
		HashMap<String, List<?>> jsonMap = new HashMap<>();
		cri.setId(id.getName());
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
		DealAndSell vo = new DealAndSell();
		vo = service.getDealDetail(dealNo);		
		log.info(vo);
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
	public ResponseEntity<DealListWithPaging> dealList(@PathVariable("page") int page, Principal id, Criteria cri) {	
		cri = new Criteria(page, 9);
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());		
		return new ResponseEntity<>(service.getDealListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/buyListAjax/{page}/{month}")
	@ResponseBody
	public ResponseEntity<BuyListWithPaging> buyList(@PathVariable("page") int page,
				Criteria cri ,@PathVariable("month") int month, Principal id) {		
		cri = new Criteria(page, 5);			
		cri.setMonth(month);
		cri.setId(id.getName());		
		return new ResponseEntity<>(service.getBuyListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/sellListAjax/{page}")
	@ResponseBody
	public ResponseEntity<SellListWithPaging> sellList(@PathVariable("page") int page,
			Principal id, Criteria cri){
		cri = new Criteria(page, 6);
		cri.setBuyId(id.getName());
		return new ResponseEntity<>(service.matchingSellList(cri), HttpStatus.OK);
	}
	
	@GetMapping("/dateSearchRange/{page}/{startDate}/{endDate}")
	@ResponseBody
	public ResponseEntity<BuyListWithPaging> dateSearchRange(@PathVariable("page") int page,
			Criteria cri, @PathVariable String startDate, @PathVariable String endDate, Principal id){			
			cri = new Criteria(page, 5);	
			cri.setStartDate(startDate);
			cri.setEndDate(endDate);
			cri.setId(id.getName());
			return new ResponseEntity<>(service.dateSearchRange(cri), HttpStatus.OK);
	}
	
	@GetMapping("/wishListAjax/{page}")
	@ResponseBody
	public ResponseEntity<WishListWithPaging> wishList(@PathVariable("page") int page,
			Criteria cri, Model model, Principal id) {
		cri = new Criteria(page, 5);
		cri.setId(id.getName());
		model.addAttribute("count", service.countWish(cri));
		return new ResponseEntity<>(service.getWishListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/selectDeal/{page}/{status}")
	@ResponseBody
	public ResponseEntity<DealListWithPaging> selectDeal(@PathVariable("page") int page,
				Criteria cri, @PathVariable("status") String status, Principal id) {			
		cri = new Criteria(page, 9);
		cri.setStatus(status);
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());
		return new ResponseEntity<>(service.selectDeal(cri), HttpStatus.OK);
	}
	
	@RequestMapping(value="/replyInsert", method={RequestMethod.GET, RequestMethod.POST})	
	@ResponseBody
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO reply, Principal id){
		reply.setId(id.getName());
		int insertCount = service.replyInsert(reply);			
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/replyList/{dealNo}")
	@ResponseBody
	public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("dealNo") int dealNo){
		System.out.println(dealNo);
		return new ResponseEntity<>(service.replyList(dealNo), HttpStatus.OK);
	}
	
	@RequestMapping(value="/replyDelete/{replyNo}", method={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ResponseEntity<String> replyDelete(@PathVariable("replyNo") int replyNo){
		int insertCount = service.replyDelete(replyNo);		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
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
