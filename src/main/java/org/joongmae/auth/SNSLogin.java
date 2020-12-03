package org.joongmae.auth;

import org.joongmae.domain.MemberVO;

import org.joongmae.service.MemberService;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SNSLogin {

	private OAuth20Service oauthService;
	private SnsValue sns;
	private MemberService service;
	
	public SNSLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.scope("profile")
				.build(sns.getApi20Instance());
		this.sns = sns;
	}

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public MemberVO getUserProfile(String code) throws Exception{
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);
				
		Response response = oauthService.execute(request);
		return parseJson(response.getBody());
		
	}
	
	private MemberVO parseJson(String body) throws Exception{
		System.out.println("============"+body);
		//User user = new User();
		MemberVO member = new MemberVO();
		
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		
		
		if(this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
			member.setId(resNode.get("id").asText());
			member.setName(resNode.get("nickname").asText());
			member.setEmail(resNode.get("email").asText());
			member.setPassword("0000");
	        member.setPhoneNo(" ");
	        member.setAddress(" ");
	        member.setSex(" ");
	        member.setPicture(" ");
	        member.setIntroduction(" ");
	        
	        

		}
		
		return member;
	}
}
