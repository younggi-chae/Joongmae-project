package org.joongmae.controller;

import java.io.File;
import java.io.FileOutputStream;
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
import org.joongmae.domain.ReplyVO;
import org.joongmae.domain.SellListWithPaging;
import org.joongmae.domain.SellVO;
import org.joongmae.domain.WishListVO;
import org.joongmae.domain.WishListWithPaging;
import org.joongmae.service.MypageService;
import org.joongmae.service.RESTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RestController
@RequestMapping("/restMyPage/*")
@Log4j
public class RestMyPageController {

	@Setter(onMethod_ = @Autowired)
	private MypageService service;
	
	@GetMapping("/buyListAjax/{page}/{month}")	
	public ResponseEntity<BuyListWithPaging> buyList(@PathVariable("page") int page,
				Criteria cri ,@PathVariable("month") int month, Principal id) {		
		cri = new Criteria(page, 5);			
		cri.setMonth(month);
		cri.setId(id.getName());		
		return new ResponseEntity<>(service.getBuyListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/dateSearchRange/{page}/{startDate}/{endDate}")	
	public ResponseEntity<BuyListWithPaging> dateSearchRange(@PathVariable("page") int page,
			Criteria cri, @PathVariable String startDate, @PathVariable String endDate, Principal id){			
			cri = new Criteria(page, 5);	
			cri.setStartDate(startDate);
			cri.setEndDate(endDate);
			cri.setId(id.getName());
			return new ResponseEntity<>(service.dateSearchRange(cri), HttpStatus.OK);
	}
	
	@PostMapping("/deleteBuy/{buyNo}")	
	public void deleteBuy(@PathVariable("buyNo") int buyNo){
		service.deleteBuy(buyNo);		
	}
	
	@GetMapping("/buyDetail/{buyNo}")	
	public BuyVO getBuyDetail(@PathVariable("buyNo") int buyNo){		
		BuyVO vo = service.getBuyDetail(buyNo);		
		return vo;
	}
	
	@GetMapping("/dealListAjax/{page}")	
	public ResponseEntity<DealListWithPaging> dealList(@PathVariable("page") int page, Principal id, Criteria cri) {	
		cri = new Criteria(page, 9);
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());		
		return new ResponseEntity<>(service.getDealListWithPaging(cri), HttpStatus.OK);
	}
	
	@GetMapping("/selectDeal/{page}/{status}")	
	public ResponseEntity<DealListWithPaging> selectDeal(@PathVariable("page") int page,
				Criteria cri, @PathVariable("status") String status, Principal id) {			
		cri = new Criteria(page, 9);
		cri.setStatus(status);
		cri.setBuyId(id.getName());
		cri.setSellId(id.getName());
		return new ResponseEntity<>(service.selectDeal(cri), HttpStatus.OK);
	}
	
	@GetMapping("/dealDetail/{dealNo}")	
	public DealAndSell getDealDetail(@PathVariable("dealNo") int dealNo){		
		DealAndSell vo = new DealAndSell();
		vo = service.getDealDetail(dealNo);		
		log.info(vo);
		return vo;
	}
	
	@PutMapping("/deleteDeal/{dealNo}")	
	public void deleteDeal(@PathVariable("dealNo") int dealNo){
		service.deleteDeal(dealNo);
	}
	
	@RequestMapping(value="/replyInsert", method={RequestMethod.GET, RequestMethod.POST})	
	public ResponseEntity<String> replyInsert(@RequestBody ReplyVO reply, Principal id){
		reply.setId(id.getName());
		int insertCount = service.replyInsert(reply);			
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/replyList/{dealNo}")	
	public ResponseEntity<List<ReplyVO>> replyList(@PathVariable("dealNo") int dealNo){
		System.out.println(dealNo);
		return new ResponseEntity<>(service.replyList(dealNo), HttpStatus.OK);
	}
	
	@RequestMapping(value="/replyDelete/{replyNo}", method={RequestMethod.GET, RequestMethod.POST})	
	public ResponseEntity<String> replyDelete(@PathVariable("replyNo") int replyNo){
		int insertCount = service.replyDelete(replyNo);		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/addWishList/{sellNo}")	
	public void addWishList(WishListVO wishList, @PathVariable("sellNo") int sellNo){		
		service.addWishList(wishList);			
	}
	
	@DeleteMapping("/deleteWishList/{sellNo}")	
	public void deleteWishList(@PathVariable("sellNo") int sellNo){
		service.deleteWishList(sellNo);
	}
	
	@GetMapping("/heartColor")	
	public Map<String,List<?>> heartColor(Criteria cri, Principal id) {			
		
		HashMap<String, List<?>> jsonMap = new HashMap<>();
		cri.setId(id.getName());
		jsonMap.put("wishList", service.getWishList(cri));
		jsonMap.put("sellList", service.getSellList(cri));		
		
		return jsonMap;
	}	
	
	@PutMapping("/deleteSell/{sellNo}")	
	public void deleteSell(@PathVariable("sellNo") int sellNo){
		service.deleteWishList(sellNo);
		service.deleteSell(sellNo);		
	}
	
	@GetMapping("/sellDetail/{sellNo}")	
	public SellVO getSellDetail(@PathVariable("sellNo") int sellNo){		
		SellVO vo = service.getSellDetail(sellNo);		
		return vo;
	}	
	
	@GetMapping("/sellListAjax/{page}")	
	public ResponseEntity<SellListWithPaging> sellList(@PathVariable("page") int page,
			Principal id, Criteria cri){
		cri = new Criteria(page, 6);
		cri.setBuyId(id.getName());
		return new ResponseEntity<>(service.matchingSellList(cri), HttpStatus.OK);
	}	
	
	@GetMapping("/wishListAjax/{page}")	
	public ResponseEntity<WishListWithPaging> wishList(@PathVariable("page") int page,
			Criteria cri, Model model, Principal id) {
		cri = new Criteria(page, 5);
		cri.setId(id.getName());
		model.addAttribute("count", service.countWish(cri));
		return new ResponseEntity<>(service.getWishListWithPaging(cri), HttpStatus.OK);
	}	
	
	@RequestMapping(value="/deleteWish", method={RequestMethod.GET, RequestMethod.POST})	
	public void deleteWish(@RequestParam(value="checkArr[]", required=false) List<String> checkArr){		
		service.deleteWish(checkArr);		
	}
	
	@PostMapping("/uploadAjaxAction")	
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
