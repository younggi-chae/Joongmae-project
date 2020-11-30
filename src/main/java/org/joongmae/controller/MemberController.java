package org.joongmae.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;
import org.joongmae.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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

   @GetMapping("/member/join")
   public void joinForm() {
      log.info("회원가입폼 이동");
   }

   @PostMapping("/member/join")
   public String join(MemberVO member, MemberAuthDTO auth, MemberAccountVO account, Model model) {
      log.info("회원가입: " + member);

      service.join(member);
      service.registerAuth(auth);
      // rttr.addFlashAttribute("member", member);

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
      log.info("로그인 페이지로 이동~");
      log.info("err :" + error);
      log.info("logout : " + logout);
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
   public String kakao_login(@RequestParam(value = "code", required = false) String code) throws Exception {
      //System.out.println("#########" + code);
      String access_Token = service.getAccessToken(code);

      HashMap<String, Object> userInfo = new HashMap<>();
      userInfo = service.getUserInfo(access_Token);

      System.out.println("###access_Token#### : " + access_Token);
      // System.out.println("###userInfo#### : " + userInfo.get("email"));
      System.out.println("###id###" + userInfo.get("id"));
      System.out.println("###nickname#### : " + userInfo.get("nickname"));
      // System.out.println("###profile_image#### : " +
      // userInfo.get("profile_image"));

      
       if (userInfo.get("id") != null) {
           session.setAttribute("userId", userInfo.get("id"));
           session.setAttribute("access_Token", access_Token);
       }
      

      return "redirect:/main";
   }

   

   @GetMapping("/main")
   public String main() {
      log.info("메인화면 이동");
      return "index_jsh";

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

   @GetMapping("/all")
   public void doAll() {
      log.info("all");
   }

   @GetMapping("/user")
   public void user() {
      log.info("user");
   }

   @GetMapping("/member/logout")
   public String logout() {
      session.removeAttribute("userId");
      session.removeAttribute("access_Token");
      return "redirect:/user";
   }

}