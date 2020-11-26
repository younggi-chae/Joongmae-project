$(document).ready(function(){
	
	var actionForm = $("#actionForm");
	
	//페이징 코드
	$(".paginate_button a").on("click", function(e){
		
		e.preventDefault();
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
		
	});//end 페이징 코드
	
	//검색시 1페이지 이동 코드
	$("#searchForm button").on("click", function(e){
		
		$("#searchForm").find("input[name='pageNum']").val("1");
		
	});//end 검색시 1페이지 이동코드
	
	
	//페이지 보기 컨트롤 코드
	$("#pageControl").on("change", function(){

		if($("#pageControl option:selected").val() == "3"){
			
			$("#pagecontrolForm").find("input[name='pageNum']").val("1");
			$("#pagecontrolForm").find("input[name='amount']").val("3");
			$("#pagecontrolForm").submit();
			$("#pageControl").val("3").prop("selected", true);

		}else if($("#pageControl option:selected").val() == "6"){
			
			$("#pagecontrolForm").find("input[name='pageNum']").val("1");
			$("#pagecontrolForm").find("input[name='amount']").val("6");
			$("#pagecontrolForm").submit();
			$("#pageControl").val("6").prop("selected", true);
			
		}else if($("#pageControl option:selected").val() == "9"){
			
			$("#pagecontrolForm").find("input[name='pageNum']").val("1");
			$("#pagecontrolForm").find("input[name='amount']").val("9");
			$("#pagecontrolForm").submit();
			$("#pageControl").val("9").prop("selected", true);
			
		}
		
	});//end 페이지 보기 컨트롤 코드
	
	
	//대분류 선택시 중분류 바뀌는 코드
	$("#searchForm #bigSelectBox").on("change", function(){
		
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
			"<option value='악세사리'>악세사리</option>";
			
			$('#mediumSelectBox').append(str);
			
			$('select').niceSelect('update');
		}
	     
	});//end 대분류 선택시 중분류 바뀌는 코드
	
	
});