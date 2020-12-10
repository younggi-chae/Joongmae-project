package org.joongmae.mapper;

import java.util.List;

import org.joongmae.domain.Criteria;
import org.joongmae.domain.DealAndSell;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DealListPagingTest {

	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;
	
	@Test
	public void test() {		
		Criteria cri = new Criteria();
		
		cri.setPageNum(1);
		cri.setAmount(9);
		
		List<DealAndSell> list = mapper.getDealList(cri);
		
		list.forEach(deal -> log.info(deal.getDealNo()));
	}

}
