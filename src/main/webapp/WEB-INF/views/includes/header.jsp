<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

    <meta charset="UTF-8">
    <meta name="description" content="HVAC Template">
    <meta name="keywords" content="HVAC, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>PROJECT</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&display=swap" rel="stylesheet">

    <!-- css Styles -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/style_jsh.css" type="text/css">


<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/fonts_jsh/font-awesome-4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/fonts_jsh/Linearicons-Free-v1.0.0/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/animate/animate.css">
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/css-hamburgers/hamburgers.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/animsition/css/animsition.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/select2/select2.min.css">
	<link rel="stylesheet" type="text/css" href="/resources/vendor_jsh/daterangepicker/daterangepicker.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/util_jsh.css">
	<link rel="stylesheet" type="text/css" href="/resources/css/main_jsh.css">

</head>
<body>


    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__widget">

        
        <c:if test="${sessionScope.id!=null}">
         <a href="logoutAction.sh" class="primary-btn">로그아웃</a>
         
     
         	
         
         
         
        </c:if>
           <c:if test="${sessionScope.id==null}">
           
            <a href="http://192.168.0.156:8080/Architecture-kosta202/controller_jsh/loginFormAction.sh" class="primary-btn">로그인/회원가입</a>
               </c:if>
            
        </div>
        <div class="offcanvas__logo">
        
    
            <a href="mainAction.sh"><img src="/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
   </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">

        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="header__logo">
                        <a href="controller_jsh/mainAction.sh"><img src="/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-10">
                    <div class="header__nav">
                        <nav class="header__menu">
                            <ul>
                                <li class="active"><a href="http://192.168.0.156:8080/Architecture-kosta202/controller_jsh/mainAction.sh">Home</a></li>
                                <li><a href="/buyBoard/list">구매 게시판</a></li>
                                <li><a href="/buyBoard/registerForm">구매 등록</a></li>
                                
                                
                                <li><a href=
                                 <c:if test="${sessionScope.id !=null}">
                                "http://192.168.0.156:8080/Architecture-kosta202/kjj/registerFormAction.kjj"
                                </c:if>
                              
                                 <c:if test="${sessionScope.id ==null}">
                                "#"
                                 </c:if>
                                >판매 등록</a></li>
                                
                                <c:if test="${sessionScope.id !=null}">
                                <li><a href="http://192.168.0.156:8080/Architecture-kosta202/Mypage/mypageMainAction.cyg">마이페이지</a></li>
                                </c:if>
                                
                                <c:if test="${sessionScope.id ==null}">
                                <li><a href="#">마이페이지</a></li>
                                </c:if>
                                
                            </ul>
                                
                        
                        </nav>
                        <div class="header__nav__widget">

    <c:if test="${sessionScope.id!=null}">
         <a href="logoutAction.sh" class="primary-btn" >로그아웃</a>
         
         <!--  
         		<c:if test="${member.picture != null }">
         		<div class="avatar-sm rounded-circle">
						<c:set var="head" value="${fn:substring(member.picture, 
												0, fn:length(member.picture)-4) }"></c:set>
						<c:set var="pattern" value="${fn:substring(member.picture, 
						fn:length(head) +1, fn:length(member.picture)) }"></c:set>
					
						<c:choose>
							<c:when test="${pattern == 'jpg' || pattern == 'gif' }">
							  <img src="/Architecture-kosta202/upload/${head}_small.${pattern}">      
							</c:when>
							<c:otherwise>
								<c:out value="NO IMAGE"></c:out>
							</c:otherwise> 
						</c:choose>
					</div>
					</c:if>-->
         
         
         
        </c:if>
           <c:if test="${sessionScope.id==null}">
           
            <a href="http://192.168.0.156:8080/Architecture-kosta202/controller_jsh/loginFormAction.sh" class="primary-btn">로그인/회원가입</a>
               </c:if>



        
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="canvas__open">
                <span class="fa fa-bars"></span>
            </div>
        </div>
    </header>
    <!-- Header Section End -->
</html>