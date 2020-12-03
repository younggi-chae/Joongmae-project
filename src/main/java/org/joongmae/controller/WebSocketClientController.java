package org.joongmae.controller;

import org.joongmae.security.domain.CustomUser;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/websocket")
public class WebSocketClientController {
	
	@GetMapping("/chatting")
	public Model chatting(Model model){
		
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("user name : " + user.getUsername());
		
		System.out.println("nomal chat page");
		
		model.addAttribute("userid", user.getUsername());
		
		return model;
	}
	
	
}
