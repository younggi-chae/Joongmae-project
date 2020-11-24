<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                var indexOfDong = data.jibunAddress.indexOf('동');
                
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress.substring(0,indexOfDong + 1);
            
                if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    var indexOfDong = expJibunAddr.indexOf('동');
                    
                    document.getElementById("sample4_jibunAddress").value = expJibunAddr.substring(0,indexOfDong + 1);
                
            
            	}
            }
        }).open();
    }
</script>
<script type="text/javascript">
	function uploadImg(input) {
		if (input.files) {
			$('.about__pic').empty();
			for (var i = 0; i < input.files.length; i++) {
				var reader = new FileReader();
				
				reader.onload = function(e) {
					console.log("target.result : " + e.target.result);
					// document.getElementById("regImg").src = e.target.result;
					
					str = "<img src='" + e.target.result + "' onclick = 'imgClick()'>";
						
					// <img id="regImg" src="/resources/img/upload_image_kjj.png" alt="" onclick="imgClick()">
					
					
					$('.about__pic').append(str);
				}

				reader.readAsDataURL(input.files[i]);
			}
		}
	}
	
	function imgClick() {
		document.getElementById("fileUploadButton").click();
	}
	
	
	function bigClassifierSelect() {
		$('#mediumClassifier').empty();
		
		var str = "<option value='test'>test</option><option value='하의'>하의</option><option value='악세사리'>악세사리</option><option value='냉장고'>냉장고</option><option value='에어컨'>에어컨</option><option value='세탁기'>세탁기</option>";
		
		$('#mediumClassifier').append(str);

		$('select').niceSelect('update');
	}
	
// 	function bigClassifierSelect(input) {
// 		if (input.value == "의류") {
// 			var str = "<option value=" + '상의' + ">상의</option><option value=" + '하의' + ">하의</option><option value=" + '악세사리' + ">악세사리</option>";
// 			document.getElementById("mediumClassifier").innerHTML = str;
// 		} else if (input.value == "가전") {
// 			var str =  "<option value=" + '냉장고' + ">냉장고</option><option value=" + '에어컨' + ">에어컨</option><option value=" + '세탁기' + ">세탁기</option>";
// 			document.getElementById("mediumClassifier").innerHTML = str;
// 		}
// 	}
</script>

<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="/resources/css/style_kjj.css" type="text/css">

    <!-- Breadcrumb End -->
    <div class="breadcrumb-option set-bg" data-setbg="/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>판매 등록</h2>
<!--                         <div class="breadcrumb__links"> -->
<!--                             <a href="./index.html"><i class="fa fa-home"></i> Home</a> -->
<!--                             <span>Contact Us</span> -->
<!--                         </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Begin -->

    <!-- Contact Section Begin -->
    <section class="contact spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 col-md-6">
                    <div class="about__pic">
						<img id="regImg" src='/resources/img/upload_image_kjj.png' alt="" onclick="imgClick()">
					</div>
                </div>
            <div class="col-lg-5 col-md-6">
               <div class="hero__tab__form">
                  <form action="register" enctype="multipart/form-data" method="post">
                     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                     <div class="select-list">
                        <div class="register-row">
                           <p style="font-size: 20px">제품명</p>
                           <input type="text" name="ItemName" placeholder="필수 입력 사항" style="width: 94%">
                        </div>
                        <div class="select-list-item">
                           <p style="font-size: 20px">가격</p>
                           <input type="text" name="Price" placeholder="필수 입력 사항" style="width: 94%">
                        </div>
                        <div class="select-list-item">
                           <p style="font-size: 20px">제품 상태</p>
                           <select name="ItemCondition">
                              <option value="상">상</option>
                              <option value="중">중</option>
                              <option value="하">하</option>
                           </select>
                        </div>
                        <div class="register-row">
									<p style="font-size: 20px; margin-bottom: 15px;">거래 방법</p>
									<div>
									<input type="radio" name="Type" value="택배거래" checked="checked" style="float: left; width:10%; height: 23px;">
									<p style="float: left;">택배거래</p>
									<input type="radio" name="Type" value="직거래" style="float: left; width:10%; height: 23px; margin-left: 20px;">
									<p style="float: left;">직거래</p>
									<input type="radio" name="Type" value="택배거래/직거래" style="float: left; width:10%; height: 23px; margin-left: 20px;">
									<p style="float: left;">택배거래/직거래</p>
									</div>
								</div>
                        <div class="register-row">
                           <p style="font-size: 20px">거래 지역</p>
									<input type="text" name="Region" id="sample4_jibunAddress" placeholder="필수 입력 사항" style="float: left;"> 
									<input type="button" onclick="sample4_execDaumPostcode()" value="지역 찾기" style="float: left;">
                        </div>
                        <div class="select-list-item">
                           <p style="font-size: 20px">대분류</p>
                           <select id="Big_Classifier" name="BigClassifier" onchange="bigClassifierSelect()">
                              <option value="의류">의류</option>
                              <option value="가전">가전</option>
                           </select>
                        </div>
                        <div class="select-list-item">
                           <p style="font-size: 20px">중분류</p>
                           <select name="MediumClassifier" id="mediumClassifier">
                              <option value="상의">상의</option>
                              <option value="하의">하의</option>
                              <option value="악세사리">악세사리</option>
                              <option value="냉장고">냉장고</option>
                              <option value="에어컨">에어컨</option>
                              <option value="세탁기">세탁기</option>
                           </select>
                        </div>
                        <div class="register-row">
                           <p>키워드1</p>
                           <input type="text" name="Keyword1" style="width: 94%">
                        </div>
                        <div class="register-row">
                           <p>키워드2</p>
                           <input type="text" name="Keyword2" style="width: 94%">
                        </div>
                        <div class="register-row">
                           <p>키워드3</p>
                           <input type="text" name="Keyword3" style="width: 94%">
                        </div>
                        <input type="file" multiple="multiple" id="fileUploadButton" name="fileName" size=40 onchange="uploadImg(this)" style="display: none;">
                     </div>
                     <button type="submit" class="site-btn">판매 등록</button>
                  </form>
               </div>
            </div>
         </div>
        </div>
    </section>
    <!-- Contact Section End -->
<%@include file="../includes/footer.jsp"%>
    
</html>