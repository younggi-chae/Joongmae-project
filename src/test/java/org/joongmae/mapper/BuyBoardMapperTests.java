package org.joongmae.mapper;

import org.joongmae.domain.BuyCriteria;
import org.joongmae.domain.BuyVO;
import org.joongmae.domain.Criteria;
import org.joongmae.service.BuyBoardService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BuyBoardMapperTests {
	
	@Autowired
	private BuyBoardMapper mapper;
	
	@Autowired
	private BuyBoardService service;
	

	/*@Test
	public void test() {
		
		BuyVO buy = mapper.detail(41);
		
		log.info(buy);
	}
	*/
	/*@Test
	public void searchTest(){
		
		BuyCriteria cri = new BuyCriteria();
		
		cri.setBigClassifier("의류");
		cri.setMediumClassifier("상의");
		cri.setKeyword1("의류");
		cri.setKeyword2("자켓");
		cri.setKeyword3("명품");
		cri.setMinPrice(100000);
		cri.setMaxPrice(500000);
		cri.setAmount(10);
		
		log.info(service.list(cri));
		
	}*/
	
	@Test
	public void sortTest(){
		
		BuyCriteria cri = new BuyCriteria();
		
		cri.setSort("highPrice");
		cri.setAmount(10);
		
		log.info(service.list(cri));
		
	}
	

}


















