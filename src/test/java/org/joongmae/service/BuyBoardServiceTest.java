package org.joongmae.service;

import static org.junit.Assert.*;

import org.joongmae.domain.BuyVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BuyBoardServiceTest {
	
	@Autowired
	private BuyBoardService service;
	
	@Test
	public void insertTest() {
		
		BuyVO vo = new BuyVO();
		
		vo.setId("test10");
	    vo.setTitle("구매등록 테스트");
	    vo.setKeyword1("의류");
	    vo.setKeyword2("상의");
	    vo.setKeyword3("키워드");
	    vo.setType("택배거래");
	    vo.setRegion("서울시 구로구 항동");
	    vo.setMinPrice(100000);
	    vo.setMaxPrice(200000);
	    vo.setBigClassifier("의류");
	    vo.setMediumClassifier("상의");
	    
	    if(service.register(vo)){
	    	log.info("---------구매등록 테스트 성공---------");
	    }else{
	    	log.info("---------구매등록 테스트 실패---------");
	    }
	      
	}

}
