package org.joongmae.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;
import org.joongmae.mapper.MemberMapper;
import org.joongmae.security.CustomUserDetailsService;
import org.joongmae.security.domain.CustomUser;
import org.joongmae.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
//@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
   
   private MemberService service;

   @GetMapping("/join")
   public void joinForm() {
      log.info("회원가입폼으로 이동");
   }

   
   
   /* GoogleLogin */
   @Autowired
   private GoogleConnectionFactory googleConnectionFactory;
   @Autowired
   private OAuth2Parameters googleOAuth2Parameters;

   // 로그인 첫 화면 요청 메소드
   @RequestMapping(value = "/member/googleLogin", method = { RequestMethod.GET, RequestMethod.POST })
   public String login(Model model, HttpSession session) {

      /* 구글code 발행 */
      OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
      String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

      System.out.println("구글:" + url);

      model.addAttribute("google_url", url);

      /* 생성한 인증 URL을 View로 전달 */
      return "/member/googleLogin";
   }

   @RequestMapping(value = "/oauth2callback", method = { RequestMethod.GET, RequestMethod.POST })
     public String googleCallback(Model model, @RequestParam String code) throws IOException {

       System.out.println("Google login success");

       return "redirect:main";
     }

   
   
   @PostMapping("/member/join")
   public String join(MemberVO member, MemberAuthDTO auth, MemberAccountVO account,Model model) {
      log.info("회원가입: " + member);

      service.join(member);
      service.registerAuth(auth);
      

      // 계좌등록
      service.registerAccount(account);
      log.info("계좌정보:" + account);

      model.addAttribute("member", member);

      return "member/detailInfoForm";

   }

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

   @GetMapping("/member/login")
   public void loginPage(String error, String logout, Model model) {
      
      if (error != null) {
         model.addAttribute("error", "로그인 실패");
      }
      if (logout != null) {
         model.addAttribute("logout", "로그아웃");
      }
   }



   @PostMapping("/member/login")
   public String loginProcessing(String error) {
      log.info("login-processing!");
      log.info("err :" + error);

      return "redirect:/main";
   }
   

   HttpSession session;
   
   @RequestMapping("/member/kakao_login")
   public String kakao_login(@RequestParam(value = "code", required = false) String code,Model model) throws Exception {
      //System.out.println("#########" + code);
      String access_Token = service.getAccessToken(code);

      HashMap<String, Object> userInfo = new HashMap<>();
      userInfo = service.getUserInfo(access_Token);

      System.out.println("###access_Token#### : " + access_Token);
      System.out.println("###userInfo#### : " + userInfo.get("email"));
      System.out.println("###id###" + userInfo.get("id"));
      System.out.println("###nickname#### : " + userInfo.get("nickname"));
      System.out.println("###profile_image#### : " +userInfo.get("profile_image"));

      
       if (userInfo.get("id") != null) {
          
           session.setAttribute("userId", userInfo.get("id"));
           session.setAttribute("access_Token", access_Token);
           session.setAttribute("pic", userInfo.get("profile_image"));
           session.setAttribute("nickname",userInfo.get("nickname"));
          
           
       }
       
       if(service.getMember((String)userInfo.get("id"))==null){
          //회원없으면 등록
          MemberVO member = new MemberVO();
          member.setId((String)userInfo.get("id"));
          member.setName((String)userInfo.get("nickname"));
          member.setPassword("0000");
          member.setPhoneNo(" ");
          member.setEmail((String)userInfo.get("email"));
          member.setEmail(" ");
          member.setAddress(" ");
          member.setSex(" ");
          member.setPicture((String)userInfo.get("profile_image"));
          member.setIntroduction(" ");
          
          MemberAuthDTO auth = new MemberAuthDTO();
          auth.setId((String)userInfo.get("id"));
          auth.setPassword("0000");
          
          
          model.addAttribute("nickname", (String)userInfo.get("nickname"));
          model.addAttribute("pic",(String)userInfo.get("profile_image"));
   
          
          service.join(member);
          service.registerAuth(auth);
          service.addOption(member);

          

       }
       
       return "/member/login";
   }
   
   @RequestMapping(value="/member/logout")
   public String logout(HttpSession session) {
       service.kakaoLogout((String)session.getAttribute("access_Token"));
       
       session.removeAttribute("access_Token");
       session.removeAttribute("userId");
       session.removeAttribute("pic");
       session.removeAttribute("nickname");
       
      
       
       return "redirect:/main";
   }
   


   

   

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

   @GetMapping("/member/idCheck")
   public @ResponseBody String id_check(String id) {
      System.out.println(id);

      return service.idCheck(id);
   }

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

      // model.addAttribute("map", map);
      System.out.println(map);

      return service.findId(map);
   }
   
   


   


   
   
   



}