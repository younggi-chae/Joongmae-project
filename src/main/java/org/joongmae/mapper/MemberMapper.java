package org.joongmae.mapper;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;

public interface MemberMapper {

	
	public List<MemberVO> getList();
	public void insertMember(MemberVO member);
	public int chk_id(String chk_id);
	public void insertAccount(MemberAccountVO account);
	public MemberAuthDTO getMember(String id);
	public void addOption(MemberVO member);
	public void memberAuth(MemberAuthDTO userInfo);
	public MemberVO read(String userId);
	public void addAuth(MemberAuthDTO userInfo);
	public String findId(HashMap<String, String> map);
	public String getPassword(Map<String, String> paramMap);
	
}
