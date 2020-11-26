package org.joongmae.mapper;

import org.joongmae.domain.MemberVO;
import org.joongmae.mapper.MemberMapper;
import org.joongmae.service.MemberServiceTests;
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
public class MemberMapperTests {

	@Setter(onMethod_={@Autowired})
	private MemberMapper mapper;
	
	
	
	@Test
	public void testGetList(){
		mapper.getList().forEach(member->log.info(member));
	}
	
	@Test
	public void insertTest(){
		MemberVO member = new MemberVO();
		member.setId("test1");

		mapper.insertMember(member);
		
		log.info(member);
	}
}
