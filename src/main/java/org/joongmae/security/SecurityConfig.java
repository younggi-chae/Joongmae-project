package org.joongmae.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration  //IoC관리
@EnableWebSecurity  //security 필터 추가
@EnableGlobalMethodSecurity(prePostEnabled = true)  //특정주소 접근하면 권한 및 인증 미리 체크하기
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
			.antMatchers("/member/auth/**")
			.permitAll()
			.anyRequest()
			.authenticated();
	}
	
}
