package org.joongmae.mapper;

import static org.junit.Assert.*;

import java.util.List;

import org.joongmae.domain.BuyVO;
import org.joongmae.domain.MemberVO;
import org.joongmae.service.BuyBoardService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BuyBoardMapperTests {
	
	@Autowired
	private BuyBoardMapper mapper;
	
	@Autowired
	private BuyBoardService service;
	

	@Test
	public void test() {
		
		BuyVO buy = mapper.detail(41);
		
		log.info(buy);
	}
	

}








