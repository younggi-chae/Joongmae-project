package org.joongmae.controller;

import org.joongmae.domain.ReviewVO;
import org.joongmae.service.RESTService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/REST/*")
@RestController
@Log4j
public class RESTController {
	
	@Setter(onMethod_ = @Autowired)
	private RESTService service;

	@PostMapping(value = "/insertReview", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String > create(@RequestBody ReviewVO review){
		log.info("insertReview : " + review);
		
		int insertCount = service.registerReview(review);
	
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/showScore", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> showScore(String id){
		log.info("id : " + id);
		
		String avgScore = service.showScore(id);
		
		log.info("avgScore : " + avgScore);
		
		return avgScore != null ? new ResponseEntity<>(avgScore, HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/readAlarm", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> readAlarm(int alarmNo){
		int i = service.readAlarm(alarmNo);
		
		return i == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
