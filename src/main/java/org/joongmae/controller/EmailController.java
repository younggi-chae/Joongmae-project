package org.joongmae.controller;

import java.util.HashMap;
import java.util.Map;

import org.joongmae.service.EmailService;
import org.joongmae.service.email.Email;
import org.joongmae.service.email.EmailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class EmailController {

	
	private EmailSender emailSender;
	private Email email;
	private JavaMailSender mailSender;
	private EmailService service;
	
	@GetMapping("/sendPassword")
	public @ResponseBody String sendEmail(String id,String emailId, Model model) throws Exception{
		
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("emailId", emailId);
		paramMap.put("id",id);
		//id, email주소  => paramMap
		
		
		String password = service.getPassword(paramMap);
			
		if(password!=null){
			
			email.setContent("회원님의 비밀번호는 "+password+"입니다.");
			email.setReceiver(emailId);
			email.setSubject(id+"님의 비밀번호 찾기 메일입니다.");
			emailSender.SendEmail(mailSender, email);
			
			model.addAttribute("errType","mailSendingComplete");
			model.addAttribute("errMsg",emailId+"로 비밀번호 정보 전송 완료");
			
			return "1";  //이메일 성공
		}else{
			// 메시지 띄우고 해당 페이지 그대로 놔두기
			model.addAttribute("errType", "mailSendingFail");
			model.addAttribute("errMsg", emailId + " 는 회원이 아닙니다.");
						
			return "0";
		}
	}
		
}
