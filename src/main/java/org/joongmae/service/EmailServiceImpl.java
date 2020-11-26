package org.joongmae.service;

import java.util.Map;

import org.joongmae.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class EmailServiceImpl implements EmailService{
	
	
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public String getPassword(Map<String, String> paramMap) {
		return mapper.getPassword(paramMap);
	}

}
