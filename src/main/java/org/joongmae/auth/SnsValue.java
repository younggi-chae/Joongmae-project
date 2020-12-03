package org.joongmae.auth;


import org.apache.commons.lang.StringUtils;

import com.github.scribejava.core.builder.api.DefaultApi20;

import lombok.Data;

@Data
public class SnsValue implements SnsUrls{
	private String service;
	private String clientId;
	private String clientSecret;
	private String redirectUrl;
	private DefaultApi20 api20Instance;
	private String profileUrl;
	
	private boolean isNaver;
	
	public SnsValue(String service, String clientId, String clientSecret, String redirectUrl) {
		this.service=service;
		this.clientId=clientId;
		this.clientSecret=clientSecret;
		this.redirectUrl=redirectUrl;
		
		this.isNaver=StringUtils.equalsIgnoreCase("naver", this.service);

		
		if (isNaver) {
			this.api20Instance=NaverAPI20.getInstance();
			this.profileUrl=NAVER_PROFILE_URL;
		}
		
	}
}
