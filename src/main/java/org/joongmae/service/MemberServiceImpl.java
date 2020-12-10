package org.joongmae.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Calendar;
import java.util.HashMap;


import org.joongmae.domain.MemberAccountVO;
import org.joongmae.domain.MemberAuthDTO;
import org.joongmae.domain.MemberVO;
import org.joongmae.mapper.MemberMapper;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@AllArgsConstructor
@Service
@Log4j
public class MemberServiceImpl implements MemberService {

   @Setter(onMethod_ = @Autowired)
   private MemberMapper mapper;

   
   
   
   private static final String NS = "org.joongmae.mapper.MemberMapper";
   private static final String GET_BY_SNS_NAVER = NS + ".getBySnsNaver";
   
   @Override
   public void join(MemberVO member) {
      mapper.insertMember(member);

   }
   

    
   @Autowired
   private BCryptPasswordEncoder bcryPasswordEncoder;

   @Override
   public void certifiedPhoneNumber(String phoneNumber, String cerNum) {
      String api_key = "NCSM1TENHBKV18UU";
      String api_secret = "H4AK7JMGOUFJPAVLDYLUK8LAIZOQW31R";
      Message coolsms = new Message(api_key, api_secret);

      // 4 params(to, from, type, text) are mandatory. must be filled
      HashMap<String, String> params = new HashMap<String, String>();
      params.put("to", phoneNumber); 
      params.put("from", "01098330929"); 
      params.put("type", "SMS");
      params.put("text", "JOONGMAE 인증메세지 : 인증번호는" + "[" + cerNum + "]" + "입니다.");
      params.put("app_version", "test app 1.2"); // application name and version

      try {
         JSONObject obj = (JSONObject) coolsms.send(params);
         System.out.println(obj.toString());
      } catch (CoolsmsException e) {
         System.out.println(e.getMessage());
         System.out.println(e.getCode());
      }
   }

   

   
   @Override
   public String idCheck(String id) {
      System.out.println(mapper.chk_id(id));
      if (mapper.chk_id(id) == 0) {
         return "yes";
      } else {
         return "no";
      }

   }

   @Override
   public void registerAccount(MemberAccountVO account) {
      mapper.insertAccount(account);

   }

   @Override
   public MemberAuthDTO getMember(String id) {
      return mapper.getMember(id);

   }

   @Override
   public void addOption(MemberVO member) {
      mapper.addOption(member);

   }

   private static final String SAVE_PATH = "/upload/temp";
   private static final String PREFIX_URL = "/resources/img/upload_cyg/";

   @Override
   public String restore(MultipartFile multipartFile) {
      String url = null;

      try {
         
         String originFilename = multipartFile.getOriginalFilename();
         String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
         Long size = multipartFile.getSize();

         
         String saveFileName = genSaveFileName(extName);

         System.out.println("originFilename : " + originFilename);
         System.out.println("extensionName : " + extName);
         System.out.println("size : " + size);
         System.out.println("saveFileName : " + saveFileName);

         writeFile(multipartFile, saveFileName);
         url = PREFIX_URL + saveFileName;
      } catch (IOException e) {
         
         throw new RuntimeException(e);
      }
      return url;
   }

   private String genSaveFileName(String extName) {
      String fileName = "";

      Calendar calendar = Calendar.getInstance();
      fileName += calendar.get(Calendar.YEAR);
      fileName += calendar.get(Calendar.MONTH);
      fileName += calendar.get(Calendar.DATE);
      fileName += calendar.get(Calendar.HOUR);
      fileName += calendar.get(Calendar.MINUTE);
      fileName += calendar.get(Calendar.SECOND);
      fileName += calendar.get(Calendar.MILLISECOND);
      fileName += extName;

      return fileName;
   }

   
   private boolean writeFile(MultipartFile multipartFile, String saveFileName) throws IOException {
      boolean result = false;

      byte[] data = multipartFile.getBytes();
      FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFileName);
      fos.write(data);
      fos.close();

      return result;
   }

   @Override
   public String getAccessToken(String authorize_code) {
      String access_Token = "";
      String refresh_Token = "";
      String reqURL = "https://kauth.kakao.com/oauth/token";

      try {
         URL url = new URL(reqURL);
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();

         // POST  슂泥  쓣  쐞 빐 湲곕낯媛믪씠 false 씤 setDoOutput 쓣 true濡 
         conn.setRequestMethod("POST");
         conn.setDoOutput(true);

         // POST  슂泥  뿉  븘 슂濡   슂援ы븯 뒗  뙆 씪誘명꽣  뒪 듃由쇱쓣  넻 빐  쟾 넚
         BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
         StringBuilder sb = new StringBuilder();
         sb.append("grant_type=authorization_code");
         sb.append("&client_id=a38a9db2ca25c9b8affcea3c3f017c31");
         sb.append("&redirect_uri=http://localhost:8081/member/kakao_login");
         sb.append("&code=" + authorize_code);
         bw.write(sb.toString());
         bw.flush();

         // 寃곌낵 肄붾뱶媛  200 씠 씪硫   꽦怨 
         int responseCode = conn.getResponseCode();
         System.out.println("responseCode : " + responseCode);

         //  슂泥  쓣  넻 빐  뼸   JSON   엯 쓽 Response 硫붿꽭吏   씫 뼱 삤湲 
         BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
         String line = "";
         String result = "";

         while ((line = br.readLine()) != null) {
            result += line;
         }
         System.out.println("response body : " + result);

         // Gson  씪 씠釉뚮윭由ъ뿉  룷 븿 맂  겢 옒 뒪濡  JSON 뙆 떛 媛앹껜  깮 꽦
         JsonParser parser = new JsonParser();
         JsonElement element = parser.parse(result);

         access_Token = element.getAsJsonObject().get("access_token").getAsString();
         refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

         System.out.println("access_token : " + access_Token);
         System.out.println("refresh_token : " + refresh_Token);

         br.close();
         bw.close();
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      return access_Token;
   }
   
    @Override
    public HashMap<String, Object> getUserInfo(String access_Token) {

         HashMap<String, Object> userInfo = new HashMap<>();
         String reqURL = "https://kapi.kakao.com/v2/user/me";
         try {
             URL url = new URL(reqURL);
             HttpURLConnection conn = (HttpURLConnection) url.openConnection();
             conn.setRequestMethod("GET");

             conn.setRequestProperty("Authorization", "Bearer " + access_Token);

             int responseCode = conn.getResponseCode();
             System.out.println("responseCode : " + responseCode);

             BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

             String line = "";
             String result = "";

             while ((line = br.readLine()) != null) {
                 result += line;
             }
             System.out.println("response body : " + result);

             JsonParser parser = new JsonParser();
             JsonElement element = parser.parse(result);

             JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
             JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

             String profile_image="";
             String nickname = properties.getAsJsonObject().get("nickname").getAsString();
             if(properties.getAsJsonObject().get("profile_image")!=null){
                profile_image = properties.getAsJsonObject().get("profile_image").getAsString();
             }else{
                profile_image=" ";
             }
             
             String email = kakao_account.getAsJsonObject().get("email").getAsString();

            String id =element.getAsJsonObject().get("id").toString();
             
             userInfo.put("id", id);
             userInfo.put("nickname", nickname);
             userInfo.put("email", email);
             userInfo.put("profile_image", profile_image);
      
         } catch (IOException e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }

         return userInfo;
     }
    
    @Override
    public void kakaoLogout(String access_Token) {
          String reqURL = "https://kapi.kakao.com/v1/user/logout";
          try {
              URL url = new URL(reqURL);
              HttpURLConnection conn = (HttpURLConnection) url.openConnection();
              conn.setRequestMethod("POST");
              conn.setRequestProperty("Authorization", "Bearer " + access_Token);
              
              int responseCode = conn.getResponseCode();
              System.out.println("responseCode : " + responseCode);
              
              BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
              
              String result = "";
              String line = "";
              
              while ((line = br.readLine()) != null) {
                  result += line;
              }
              System.out.println(result);
          } catch (IOException e) {
              // TODO Auto-generated catch block
              e.printStackTrace();
          }
      }

   
     @Override
     public void registerAuth(MemberAuthDTO userInfo) {
      
        System.out.println("Before Encoder : " + userInfo.getPassword()); String
        endcodedPassword = bcryPasswordEncoder.encode(userInfo.getPassword());
        System.out.println("After Encoder : " + endcodedPassword);
        System.out.println("Resister User Info : " + userInfo);
        
        userInfo.setPassword(endcodedPassword); 
        mapper.memberAuth(userInfo);
   
       
     
     
     }


   @Override
   public String findId(HashMap<String, String> map) {
      return mapper.findId(map);
   }
    

}