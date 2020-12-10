package org.joongmae.mapper;

import static org.junit.Assert.*;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
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
public class DataSourceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private DataSource dataSource;
	
	@Setter(onMethod_ = {@Autowired})
	private SqlSessionFactory sqlsessionFactory;
	
	@Test
	public void test() {
				
		try {
			SqlSession session = sqlsessionFactory.openSession();
			Connection con = dataSource.getConnection();			
			log.info(con);
			log.info(session);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}

}
