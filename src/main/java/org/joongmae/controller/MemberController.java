package org.joongmae.controller;

import java.util.HashMap;
import java.util.Random;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.joongmae.auth.SNSLogin;
import org.joongmae.auth.SnsValue;
import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;
import org.joongmae.service.MemberService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class MemberController {

	private MemberService service;
	private SnsValue naverSns;
	HttpSession session;


	

	/*회원가입*/
	@GetMapping("/member/join")
	public void joinForm() {
		log.info("회원가입폼으로 이동");
	}

	@PostMapping("/member/join")
	public String join(MemberVO member, MemberAuthDTO auth, MemberAccountVO account, Model model) {
		log.info("회원가입: " + member);

		service.join(member);
		service.registerAuth(auth);

		// 계좌등록
		service.registerAccount(account);
		log.info("계좌정보:" + account);

		model.addAttribute("member", member);

		return "member/detailInfoForm";

	}

	/*선택사항 작성*/
	@GetMapping("/member/option")
	public String optionForm(@RequestParam("id") String id) {
		return "/member/detailInfoForm";
	}

	@PostMapping("/member/option")
	public String option(Model model, @RequestParam("id") String id, @RequestParam("picture") MultipartFile file,
			@RequestParam("introduction") String introduction, RedirectAttributes rttr) {

		String url = service.restore(file);
		model.addAttribute("url", url);

		MemberVO member = new MemberVO();
		member.setId(id);
		member.setIntroduction(introduction);
		member.setPicture(file.getOriginalFilename());

		System.out.println(file.getOriginalFilename());

		log.info(member);
		service.addOption(member);

		return "redirect:/main";

	}
	
	
	/*로그인*/
	@GetMapping("/member/login")
	public void loginPage(Model model) {

		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getNaverAuthURL());

	}
	

	@PostMapping("/member/login")
	public String loginProcessing(String error) {
		log.info("login-processing!");
		log.info("err :" + error);

		return "redirect:/main";
	}
	
	

	/*카카오 로그인*/
	@RequestMapping("/member/kakao_login")
	public String kakao_login(@RequestParam(value = "code", required = false) String code, Model model)
			throws Exception {
		String access_Token = service.getAccessToken(code);

		
		session.removeAttribute("userId");
		session.removeAttribute("access_Token");
		session.removeAttribute("pic");
		session.removeAttribute("nickname");
		
		HashMap<String, Object> userInfo = new HashMap<>();
		userInfo = service.getUserInfo(access_Token);

		System.out.println("###access_Token#### : " + access_Token);
		System.out.println("###userInfo#### : " + userInfo.get("email"));
		System.out.println("###id###" + userInfo.get("id"));
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###profile_image#### : " + userInfo.get("profile_image"));

		if (userInfo.get("id") != null) {

			session.setAttribute("userId", userInfo.get("id"));
			session.setAttribute("access_Token", access_Token);
			session.setAttribute("pic", userInfo.get("profile_image"));
			session.setAttribute("nickname", userInfo.get("nickname"));

		}

		if (service.getMember((String) userInfo.get("id")) == null) {
			// 회원없으면 등록
			String picture = (String) userInfo.get("profile_image");
			
			
			MemberVO member = new MemberVO();
			member.setId((String) userInfo.get("id"));
			member.setName((String) userInfo.get("nickname"));
			member.setPassword("0000");
			member.setPhoneNo(" ");
			member.setEmail((String) userInfo.get("email"));
			// member.setEmail(" ");
			member.setAddress(" ");
			member.setSex(" ");
			member.setPicture((String) userInfo.get("profile_image"));
			member.setIntroduction(" ");

			MemberAuthDTO auth = new MemberAuthDTO();
			auth.setId((String) userInfo.get("id"));
			auth.setPassword("0000");

			model.addAttribute("nickname", userInfo.get("nickname"));
			model.addAttribute("pic", userInfo.get("profile_image"));

			service.join(member);
			service.registerAuth(auth);
			service.addOption(member);

		}

		return "/member/login";
	}
	
	/*소셜 로그인*/
	@RequestMapping(value = "/auth/{snsService}/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String snsLoginCallback(@PathVariable String snsService, Model model, @RequestParam String code,
			HttpSession session) throws Exception {

		log.info("snsLogincallback:service={}" + snsService);

		SnsValue sns = null;
		if (StringUtils.equals("naver", snsService)) {
			sns = naverSns; // sns마다 추가가능
		}

		SNSLogin snsLogin = new SNSLogin(naverSns);
		MemberVO member = snsLogin.getUserProfile(code);

		System.out.println("Profile>>" + member);

		String id = member.getId();
		MemberAuthDTO presentMember = service.getMember(id);

		if (presentMember == null) {
			MemberAuthDTO auth = new MemberAuthDTO();
			auth.setId(member.getId());
			auth.setPassword("0000");

			service.join(member);
			service.registerAuth(auth);
			service.addOption(member);

		} else {
			session.removeAttribute("userId");
			session.removeAttribute("nickname");
			session.removeAttribute("access_Token");
			session.setAttribute("userId", member.getId());
			session.setAttribute("nickname", member.getName());
		}

		return "/member/login";
	}

	/*로그아웃*/
	@RequestMapping(value = "/member/logout")
	public String logout(HttpSession session) {
		service.kakaoLogout((String) session.getAttribute("access_Token"));

		session.removeAttribute("access_Token");
		session.removeAttribute("userId");
		session.removeAttribute("pic");
		session.removeAttribute("nickname");

		return "redirect:/main";
	}

	/*문자 인증*/
	@GetMapping("/member/check/sendSMS")
	public @ResponseBody String sendSMS(String phoneNumber) {

		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		service.certifiedPhoneNumber(phoneNumber, numStr);
		return numStr;

	}

	/*아이디 중복검사*/
	@GetMapping("/member/idCheck")
	public @ResponseBody String id_check(String id) {
		System.out.println(id);

		return service.idCheck(id);
	}

	/*아이디, 비밀번호 찾기*/
	@GetMapping("/member/findMember")
	public void findMember() {

	}

	@GetMapping("/member/findId")
	public @ResponseBody String findId(String inputName, String inputPhoneNo, Model model) {

		System.out.println(inputName);
		System.out.println(inputPhoneNo);

		HashMap<String, String> map = new HashMap<>();

		map.put("name", inputName);
		map.put("phoneNo", inputPhoneNo);

		return service.findId(map);
	}

}