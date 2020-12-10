package org.joongmae.mapper;

import static org.junit.Assert.*;

import java.util.List;

import org.joongmae.domain.BuyListWithPaging;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.joongmae.domain.DealVO;
import org.joongmae.domain.SellVO;
import org.joongmae.service.MypageService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",				       
					   "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MyPageMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;
			
	@Test
	public void sellDetailTest() {		
		SellVO sell = mapper.getSellDetail(63);
		log.info(sell);		
	}	
	@Test
	public void buyDetailTest(){
		BuyVO buy = mapper.getBuyDetail(50);
		log.info(buy);
	}	
	@Test
	public void dealDetailTest(){
		DealAndSell deal = mapper.getDealDetail(30);
		log.info(deal);
	}
}
