<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>




	<!-- Services Section Begin -->
	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>마이 페이지</h2>
						<span>My Page</span>
					</div>
				</div>
			</div>		
			<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12">
		<div class="testimonial__item">
			<div class="testimonial__item__author">
				<div class="testimonial__item__author__pic">
					<div class="imgPreview">	
					  <img id="regImg" class="rounded-circle" src="/resources/img/upload_cyg/s_${member.picture }" style="width: 140px; height: 140px;">								
				 	</div>
				</div>
				<div class="testimonial__item__author__text">
					<div class="rating">
						<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
							class="fa fa-star"></i> <i class="fa fa-star"></i> <i
							class="fa fa-star"></i>
					</div>
				
					<h5>						
						${member.id } 고객님&emsp; <span class=".detail">	                       								
						<a href="detailMember?id=${member.id }">정보 수정</a></span>							
					</h5>															
					<span>${member.email }</span>					
				</div>
			</div>			
		</div>
	</div>
	</div>
	<br><br><br>		
			<div class="row">
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-1.png" alt="">
						<h5>거래내역 확인</h5>
						<a href="/myPage/dealList"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-2.png" alt="">
						<h5>구매등록 확인</h5>
						<a href="/myPage/buyList"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-3.png" alt="">
						<h5>견적서 확인</h5>
						<a href="/myPage/sellList"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>				
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-4.png" alt="">
						<h5>견적서 관심리스트</h5>
						<a href="/myPage/wishList"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
					
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-1.png" alt="">
						<h5>나의 평점 및 리뷰</h5>
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="services__item">
						<img src="/resources/img/services/services-2.png" alt="">
						<h5>알림 설정</h5>
						<a href="" onclick="setAlarm()"><i class="fa fa-long-arrow-right"></i></a>
					</div>
					</div>
				</div>
			</div>	
	</section>
	
	<div id="alarmModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알람 설정</h5>
        <button type="button" onclick="closeModal()" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="custom-control custom-switch" style="margin-left: 20px;">
   	 	<input type="checkbox" class="custom-control-input" id="customSwitch1" onclick="clickCheckbox()">
    	<label class="custom-control-label" for="customSwitch1">on/off</label>
		</div>
		<br>
		<input id="startTime" type="time" style="margin-left: 20px;"> ~ 
		<input id="endTime" type="time" >
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="alarmChange()">저장</button>
        <button type="button" class="btn btn-secondary" onclick="closeModal()" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
  <sec:authentication property="principal.username" var="id" />
</div>
</div>   	
	<!-- Services Section End -->

<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">


	function clickCheckbox() {
		if($("#customSwitch1").is(":checked")) {
			$("#customSwitch1").prop('checked', true);
			$('#startTime').attr('disabled',false);
			$('#endTime').attr('disabled',false);
	    } else {
	    	$('#startTime').attr('disabled',true);
			$('#endTime').attr('disabled',true);
		}
	}

	function setAlarm() {
		event.preventDefault();
		
		$('#alarmModal').show();
	}
	
	function closeModal() {
		$('#alarmModal').hide();
	}
	
	function alarmChange() {
		var header = "${_csrf.headerName}";
		var token = "${_csrf.token}";
		var id = '<c:out value="${id}"/>';
		var startTime = $('#startTime').val();
		var endTime = $('#endTime').val();
		var customSwitch = $("#customSwitch1").is(":checked");
		
		var data = {
				"id":id,
				"isAlarm":customSwitch,
				"alarmStartTime":startTime,
				"alarmEndTime":endTime
				};
		
		console.log("startTime : " + startTime + ", endTime : " + endTime + ", customSwitch : " + customSwitch);
		
		$.ajax({
			url : "/REST/setAlarm",
			contentType: "application/json; charset-utf-8",
			data : JSON.stringify(data),
			type : "POST",
			beforeSend : function(xhr)
            {   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader(header, token);
            },
			success : function(result){
				if (result == 'success') {
					alert("변경되었습니다.");
				}
			}				
		});
		
		$('#alarmModal').hide();
	}
</script>