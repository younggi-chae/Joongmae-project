package org.joongmae.service;

import java.util.HashMap;
import java.util.Map;

import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {

	public void join(MemberVO member);
	public void certifiedPhoneNumber(String phoneNumber,String cerNum);
	public String idCheck(String id);
	public void registerAccount(MemberAccountVO account);
	public MemberAuthDTO getMember(String id);
	public void addOption(MemberVO member);
	public String restore(MultipartFile file);
	public String getAccessToken (String authorize_code);
	public void registerAuth(MemberAuthDTO userInfo);
	public void kakaoLogout(String access_Token);
	
	
	public String findId(HashMap<String, String> map);
	public HashMap<String, Object> getUserInfo(String access_Token);
	
}
