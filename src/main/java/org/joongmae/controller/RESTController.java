package org.joongmae.controller;

import java.util.List;

import org.joongmae.domain.AlarmVO;
import org.joongmae.domain.MemberAlarmSetVO;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sun.mail.iap.Response;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/REST/*")
@RestController
@Log4j
public class RESTController {
	
	@Setter(onMethod_ = @Autowired)
	private RESTService service;

	@PostMapping(value = "/insertReview", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String > create(ReviewVO review){
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
	
	@PostMapping(value = "/setAlarm", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> setAlarm(@RequestBody MemberAlarmSetVO memberAlarmSet){
		System.out.println(memberAlarmSet);
		
		int i = service.setAlarm(memberAlarmSet);
		
		return i == 1 ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/getAlarmConfig", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<MemberAlarmSetVO> getAlarmConfig(String id){
		System.out.println("id : " + id);
		
		MemberAlarmSetVO result = service.getAlarmConfig(id);
		log.info(result);
		
		return result != null ? new ResponseEntity<MemberAlarmSetVO>(result, HttpStatus.OK) : new ResponseEntity<MemberAlarmSetVO>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/getAlarmCount", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> getAlarmCount(String id){
		System.out.println("id : " + id);
		
		int result = service.getAlarmCount(id);
		log.info(result);
		
		return new ResponseEntity<String>(Integer.toString(result), HttpStatus.OK);
	}
	
	@GetMapping(value = "/alarmList", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<AlarmVO>> alarmList(String id){
		System.out.println("id : " + id);
		
		List<AlarmVO> result = service.alarmList(id);
		log.info(result);
		
		return new ResponseEntity<List<AlarmVO>>(result, HttpStatus.OK);
	}
}
