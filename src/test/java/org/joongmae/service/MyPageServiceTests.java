package org.joongmae.service;

import org.joongmae.domain.ReplyVO;
import org.joongmae.mapper.MyPageMapperTests;
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
public class MyPageServiceTests {

	@Setter(onMethod_={@Autowired})
	private MypageService service;
	
	@Test
	public void testInsert(){
		ReplyVO reply = new ReplyVO();
		reply.setDealNo(204);
		reply.setReply("테스트");
		reply.setId("user00");
		
		service.replyInsert(reply);
		
		log.info("생성된 게시물의 번호" + reply.getReplyNo());
	}
}





