<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
						<a href="#"><i class="fa fa-long-arrow-right"></i></a>
					</div>
					</div>
				</div>
			</div>	
	</section>	
	<!-- Services Section End -->

<%@include file="../includes/footer.jsp"%>