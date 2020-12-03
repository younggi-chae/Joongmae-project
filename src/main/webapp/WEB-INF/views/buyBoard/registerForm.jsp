<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
	function setDisplay(){
		if($('#type input:radio[value=택배거래]').is(':checked')){
			$('#region').hide();
		}else{
			$('#region').show();
		}
	}
</script>
<script type="text/javascript">
	function setCategory(){
		
		$('#mediumSelectBox').empty();
	    
		if($("#bigSelectBox option:selected").val() == "의류"){
			
			var str = "<option value='상의'>상의</option>" +
					"<option value='하의'>하의</option>" +
					"<option value='악세사리'>악세사리</option>";
      
			$('#mediumSelectBox').append(str);
			
			$('select').niceSelect('update');
			
		}else if($("#bigSelectBox option:selected").val() == "가전"){
			
			var str = "<option value='냉장고'>냉장고</option>" +
			"<option value='에어컨'>에어컨</option>" +
			"<option value='세탁기'>세탁기</option>";
			
			$('#mediumSelectBox').append(str);
			
			$('select').niceSelect('update');
		}
		
	}
</script>

<script type="text/javascript">

	function inputComma(obj) {
		var number = obj.value;
		var integer = obj.value;
		var point = number.indexOf(".");
		var decimal = "";
		var checked = "";

		//소수점 기호(.) 사용 방지
		if (point != -1) {
			alert("소수점 기호(.)를 사용할 수 없습니다.");
			obj.value = "";
			return false;
		}

		// 정수형의 콤마를 제거
		integer = integer.replace(/\,/g, "");
		checked = inputNumberisFinit(integer);

		if (checked == "N") {
			alert("문자는 입력하실 수 없습니다.");
			obj.value = "";
			return false;
		}

		//정수형을 한번더 점검한다.
		integer = inputNumberWithComma(inputNumberRemoveComma(integer));
		obj.value = integer;
	}

	//천단위 이상의 숫자에 콤마(,)를 삽입하는 함수
	function inputNumberWithComma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
	}

	//콤마(,)가 들어간 값에 콤마를 제거하는 함수
	function inputNumberRemoveComma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, "");
	}

	//문자 여부를 확인하고 문자가 존재하면 N, 존재하지 않으면 Y를 리턴한다.
	function inputNumberisFinit(str) {
		if (isFinite(str) == false) {
			return "N";
		} else {
			return "Y";
		}
	}
</script>

	<%@ include file="../includes/header.jsp" %>
	
	<link rel="stylesheet" href="/resources/css/style_kgj.css" type="text/css">

    <!-- Breadcrumb End -->
    <div class="breadcrumb-option set-bg" data-setbg="/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>구매 등록</h2>
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
            <div class="col-lg-3 col-md-6"></div>
            <div class="col-lg-6 col-md-6">
               <div class="hero__tab__form">
                  <form action="/buyBoard/register" method="post">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                     <div class="select-list">
                        <div class="register-row">
                           <p>제목</p>
                           <input type="text" name="title">
                        </div>
                        <div class="select-list-item">
                           <p>최소가격</p>
                           <input type="text" onkeyup="inputComma(this);" name="minPrice">
                        </div>
                        <div class="select-list-item">
                           <p>최대가격</p>
                           <input type="text" onkeyup="inputComma(this);" name="maxPrice">
                        </div>
                        <div class="register-row" id="type">
                           <p>거래 방법</p>
                           <div>
                           <input type="radio" name="type" value="택배거래" onchange="setDisplay()" checked="checked" style="float: left; width:10%; height: 23px;">
                           <p style="float: left;">택배거래</p>
                           <input type="radio" name="type" value="직거래" onchange="setDisplay()" style="float: left; width:10%; height: 23px; margin-left: 20px;">
                           <p style="float: left;">직거래</p>
                           <input type="radio" name="type" value="직거래/택배거래" onchange="setDisplay()" style="float: left; width:10%; height: 23px; margin-left: 20px;">
                           <p style="float: left;">직거래/택배거래</p>
                           </div>
                        </div>
                        <div class="register-row" id="region" style="display: none;">
                           <p>거래 지역</p>
                           <input type="text" name="region" id="sample4_jibunAddress" placeholder="필수 입력 사항" style="float: left;"> 
						   <input type="button" onclick="sample4_execDaumPostcode()" value="지역 찾기" style="float: left;">
                        </div>
                        <div class="select-list-item">
                           <p>대분류</p>
                           <select id="bigSelectBox" name="bigClassifier" onchange="setCategory()">
                                    <option value="의류" selected="selected">의류</option>
                                    <option value="가전">가전</option>
                           </select>
                        </div>
                        <div class="select-list-item">
                           <p>중분류</p>
                           <select id="mediumSelectBox" name="mediumClassifier">
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
                           <input type="text" name="keyword1">
                        </div>
                        <div class="register-row">
                           <p>키워드2</p>
                           <input type="text" name="keyword2">
                        </div>
                        <div class="register-row">
                           <p>키워드3</p>
                           <input type="text" name="keyword3">
                        </div>
                     </div>
                     <div class="col-lg-5" style="float: left;margin-left: 50px;">
                     	<button type="submit" class="site-btn">구매 등록</button>
                     </div>
                     <div class="col-lg-5" style="float: left;">
                     	<button type="button" class="site-btn" onclick="location.href='/main'">등록 취소</button>
                     </div>
                  </form>
               </div>
            </div>
            <div class="col-lg-3 col-md-6"></div>
         </div>
        </div>
    </section>
    <!-- Contact Section End -->
    
   
    <%@ include file="../includes/footer.jsp" %>
    
    <script src="/resources/js/main_kgj.js"></script>

</html>