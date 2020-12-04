<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    Object principal = auth.getPrincipal();
 
    String id = "";
    if(principal != null) {
        id = auth.getName();
    }
%>
<%@include file="../includes/header.jsp"%>

   <section class="services spad">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="section-title">
                  <h2>거래내역 확인</h2>
                  <span>Deal Information</span>
               </div>
            </div>
         </div>
      </div>

      <!-- Car Section Begin -->
      <div class="container">
         <div class="row">            
            <div class="col-lg-12">
               <div class="car__filter__option"
                  style="height: 74px; background-color: white;">
                  <div class="row">
                     <div class="col-lg-4 col-md-6">
                        <div class="car__filter__option__item car__filter__option__item--left">
                           <select class="selectDeal">
                              <option id="whole" value="whole">전체</option>
                              <option id="progress" value="progress">진행중</option>
                              <option id="complete" value="complete">거래완료</option>
                              <option id="deposit" value="deposit">입금완료</option>
                              <option id="shipping" value="shipping">배송중</option>
                              <option id="cancel" value="cancel">거래취소</option>
                           </select>&emsp;
                           <a href="/myPage/main" class="btn btn-info">마이페이지 메인</a>                        
                        </div>                                       
                     </div>                     
                     <div class="col-lg-8 col-md-6" style="top:-150px; left:500px;">
                        
                           <div id="myChart" >
                              <input type="hidden" id="completeCnt" value="${completeCnt }">
                              <input type="hidden" id="progressCnt" value="${progressCnt }">
                           </div>
                        
                     </div>                      
                  </div>
               </div>
               <div class="row" id="dealList">
                  
               </div>                           
            </div>
         </div>         
      </div>
   </section>
   <!-- Car Section End -->

   <!-- modal창 정보 -->   
      <div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
         aria-labelledby="detailModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">                     
                  <h4 class="modal-title" id="detailModalLabel">거래 상세보기</h4>
               </div>
               <div class="modal-body" id="detail">
               
               </div>            
               <div class="modal-footer">
               <form action="/REST/insertReview" method="post" id="reviewBtn" style="border: 1;">
                  <span id="star1" onclick="star1Click()">★</span>
                  <span id="star2" onclick="star2Click()">★</span>
                  <span id="star3" onclick="star3Click()">★</span>
                  <span id="star4" onclick="star4Click()">★</span>
                  <span id="star5" onclick="star5Click()">★</span>
                  <input type="text" name="score" id="starScore" value="5" readonly="readonly" style="width: 10px;">점
                  <br>
                  <textarea name="contents" style="border: solid;border-width: thin;width: 250px;"></textarea>
                  <input type="hidden" name="id" id="reviewId" value="<%=id%>">
                  <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                  <input type="submit" class="btn btn-primary" value="리뷰쓰기">
               </form>
               
               <form action="/deal/send" id="deliveryBtn" class="delivery" style="border: 1;">
                  <input type="hidden" id="sendDealNo" name="dealNo">
                  <input type="text" id="deliveryNo" style="border: solid;border-width: thin;width: 250px;">
                  <input type="submit" class="btn btn-primary" value="송장 번호 입력">
               </form>
               <form action="/deal/send" id="deliveryModBtn" class="delivery" style="border: 1;">
                  <input type="hidden" id="modDealNo" name="dealNo">
                  <input type="text" id="deliveryModNo" style="border: solid;border-width: thin;width: 250px;">
                  <input type="submit" class="btn btn-primary" value="송장 번호 수정">
               </form>
               <button type="button" class="btn btn-primary delivery" id="depositBtn" onclick="deposit()">입금 완료</button>
               <button type="button" class="btn btn-primary delivery" id="deliveryInfoBtn" onclick="deliveryInfo()">송장 번호 조회</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                  
               </div>
            </div>               
         </div>            
        </div>                 
   <!-- /.modal -->
   
   <!-- modal창 정보 -->
      <div class="modal fade" id="commentModal" tabindex="-1" role="dialog2"
         aria-labelledby="commentModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">                     
                  <h4 class="modal-title" id="commentModalLabel"><i class="fa fa-comments fa-fw"></i> Comments</h4>
               </div>
               <div class="modal-body">                     
                    <ul class="reply">
                       
                    </ul>               
               </div>
               <div class="modal-footer">                       
                      <input class="form-control" name='reply' placeholder="댓글을 입력하세요.">                     
                      <button class="btn btn-danger content" id="insert">댓글남기기</button>                
                  <button type="button" class="btn btn-secondary replyClose" data-dismiss="modal">Close</button>                     
               </div>
            </div>               
         </div>            
       </div>         
   <!-- /.modal -->         


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">         
      
      var statusCheck = "";
      var page = 1;
      var endCheck = false;
      $(document).ready(function(){      
         //리스트 출력
         statusCheck = "whole";
         dealList();   
         infiniteScroll();
       //진행중, 거래완료, 입금완료, 배송중, 거래취소 검색
       $(".selectDeal").on("change", function(){
         if($(".selectDeal option:selected").val() == 'whole'){
            statusCheck = "whole";
            init();
            dealList();   
            infiniteScroll();
         } else if($(".selectDeal option:selected").val() == 'complete'){
            statusCheck = "complete";
            init();
            statusList(page, "완료");   
            infiniteScroll(page, "완료");
         } else if($(".selectDeal option:selected").val() == 'progress'){
            statusCheck = "progress";
            init();
            statusList(page, "진행중");   
            infiniteScroll(page, "진행중");
         } else if($(".selectDeal option:selected").val() == 'deposit'){
            statusCheck = "deposit";
            init();
            statusList(page, "입금완료");   
            infiniteScroll(page, "입금완료");
         } else if($(".selectDeal option:selected").val() == 'shipping'){
            statusCheck = "shipping";
            init();
            statusList(page, "배송중");   
            infiniteScroll(page, "배송중");
         } else if($(".selectDeal option:selected").val() == 'cancel'){
            statusCheck = "cancel";
            init();
            statusList(page, "거래취소");   
            infiniteScroll(page, "거래취소");
         }
       });         
    }); 
            
      //무한 스크롤 페이징 셋팅            
      function infiniteScroll(){         
         $(window).scroll(function(){
            var $window = $(this);
            var scrollTop = $window.scrollTop(); //스크롤 top이 위치하는 높이
            var windowHeight = $window.height();  // 화면 높이
            var documentHeight = $(document).height();   //문서 전체 높이         
            
            if(scrollTop + windowHeight + 30 > documentHeight){                           
               if(statusCheck == "progress"){
                  statusList(page, "진행중");
                 }else if(statusCheck == "complete"){
                    statusList(page, "완료");
                 }else if(statusCheck == "whole"){
                    dealList();
                 }else if(statusCheck == "deposit"){
                    statusList(page, "입금완료");
                 }else if(statusCheck == "shipping"){
                    statusList(page, "배송중");
                 }else if(statusCheck == 'cancel'){
                    statusList(page, "거래취소");
                 }     
               ++page;               
            }
         });         
      }
      
      //초기화
      function init(){
         endCheck = false;
         $('#dealList').html("");
      }
      
      //전체 리스트 가져오기
      var dealList = function(){
         if(endCheck == true){
            return
         }         
          console.log("페이지번호 : " + page);
         $.ajax({
            url : "/myPage/dealListAjax/" + page,
            dataType : "json",            
            type : "GET",
            success : function(result){            
            var length = result.list.length;
            console.log("리스트 길이 : " + length);            
            if(length < 9){
               endCheck = true;
            }
            if(length < 1){
                  str = '<div style="padding:200px 350px"><h2>진행중인 거래가 없습니다.</h2><div>';
                  $('#dealList').append(str);
            }
            result.list.forEach(function(element){                              
               showList(element);               
            });
         }         
      });         
   }
      
     //진행중 & 거래완료 리스트 가져오기
     var statusList = function(page, status){        
        if(endCheck == true){
           return
        }
        var param = new Object();         
         param.status = status;
         param.page = page || 1;         
         console.log(status);
          console.log("페이지번호 : " + page);
         $.ajax({
            url : "/myPage/selectDeal/" + page + "/" + status,
            dataType : "json",            
            type : "GET",   
            data : param,
            success : function(result){               
            var length = result.list.length;
            console.log("리스트 길이 : " + length);                  
            if(length < 9){
               endCheck = true;
            }   
            if(length < 1){
                  str = '<div style="padding:200px 350px"><h2>진행중인 거래가 없습니다.</h2><div>';
                  $('#dealList').append(str);
            }
            result.list.forEach(function(element){   
               showList(element);               
            });
         }         
      });         
     }
      
      
   //화면에 뿌려질 태그
   var showList = function(element){      
      var str = "";      
         str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';                  
         str += '<div class="car__item__pic__slider">';
         if(element.picture != null){
              str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
           } else {
            str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';     
           }
         str += '<div class="car__item__text"><div class="car__item__text__inner">';
         str += '<div class="label-date">' + element.buyId +'</div>';
         str += '<div class="label-date">' + element.sellId +'</div>';
         str += '<div class="label-date">'+ formatDate(element.regDate) +'</div>';
         str += '<div><input id="modalNo" name="modalNo" type="hidden" value="' + element.dealNo +'">';
         str += '<a class="detailModal" href="#" data-toggle="modal" data-target="#detailModal" data-backdrop="static" style="font-size: 25px;">' + element.itemName +'</a>';
         str += '&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;';
         str += '<a class="commentModal" href="#" data-toggle="modal" data-target="#commentModal" data-backdrop="static" style="font-size:40px;">';         
         str += '<i class="fa fa-comments"></i></a><span class="badge badge-danger replyCnt" id = "replyCnt">'+element.replyCnt+'</span></div>';  
         str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
         str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';
         if(element.status === "진행중"){
            str += '<div class="car__item__price"><span class="car-option">'+ element.status+'</span>';
         } else {
            str += '<div class="car__item__price"><span class="car-option sale">'+ element.status+'</span>';
         }                                       
         str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';   
            
               $('#dealList').append(str);   
            
          }
   
   
   //댓글 insert & list & delete         
   var dealNo =0;
   $('#dealList').on("click", '.commentModal', function(){
      dealNo = $(this).prev().prev().val();      
      replyList(dealNo);      
   });      
   
   $('#insert').on('click', function(){      
      replyInsert(dealNo);      
   });       
   
   $('.reply').on('click', '.replyDelete', function(){
      var replyNo = $(this).prev().val();
      replyDelete(replyNo);
   });
   
   var dealNo;
   
    //Deal 상세보기 모달
   $('#dealList').on("click", '.detailModal', function(){
      dealNo = $(this).prev().val();               
      detailDeal(dealNo);
   });   
   
    
   //댓글 insert Ajax
   function replyInsert(dealNo){      
      var reply = $('.content').prev().val();
      var id = "<%=id%>";
      var header = "${_csrf.headerName}";
       var token = "${_csrf.token}";
      var param = new Object();         
      param.dealNo = dealNo;
      param.reply = reply;
      param.id = id;
      
      $.ajax({
         url : "/myPage/replyInsert",         
         data : JSON.stringify(param),
         type : "POST",      
         contentType : "application/json; charset=utf-8",
         beforeSend : function(xhr)
           {  
           xhr.setRequestHeader(header, token);
           },
         success : function(result){   
            replyList(dealNo);
            $('input[name="reply"]').val("");
         }, error : function(err){
            alert("실패");
         }
      });
   }   
   
   
   //댓글 List Ajax
   function replyList(dealNo){         
      $.ajax({
         url : "/myPage/replyList/" + dealNo,
         dataType : "json",
         data : dealNo,
         type : "GET",
         success : function(result){            
           $('.reply').html("");   
           var length = result.length;           
           
           if(length === 0){
              str = '<li><div align="center"><b>등록된 댓글이 없습니다.</b></div></li>';
              $('.reply').append(str);
           } else {
           result.forEach(function(element){           
              var str = "";           
              str  = '<li class="left clearfix">';
              str +=    '<div>';
              str +=       '<div class="header">';             
              str +=          '<strong class="primary-font">'+element.id+'</strong>&emsp;';
              str +=            '<input type="hidden" value="'+element.replyNo+'">';
              str +=            '<a href="#" class="replyDelete"><i class="fa fa-close"></i></a>';
              str +=          '<small class="pull-right text-muted">'+element.replyDate+'</small>';
              str +=        '</div>';
              str +=            '<p>'+element.reply+'</p>';
              str +=    '</div>';
              str += '</li>';
              
                 $('.reply').append(str);   
              });
             }
          }
         });   
      }
   
   //댓글 삭제 Ajax
   function replyDelete(replyNo){      
      var header = "${_csrf.headerName}";
       var token = "${_csrf.token}";
       if(confirm("댓글을 삭제하시겠습니까?")) {         
        
      $.ajax({
         url : "/myPage/replyDelete/" + replyNo,         
         data : replyNo,
         type : "POST",
         beforeSend : function(xhr)
           {  
           xhr.setRequestHeader(header, token);
           },
         success : function(result){   
            replyList(dealNo);            
         }, error : function(err){
            alert("실패");
         }
      });
          } else {
               return false;
           }
      }   
   
   
   //Deal 상세보기
   function detailDeal(dealNo)   {
      var str = "";
      $('#sendDealNo').val(dealNo);
      $('#modDealNo').val(dealNo);
      console.log("dealNo : " + dealNo);
      $.ajax({
         url : "/myPage/dealDetail/" + dealNo,
         dataType : "json",
         data : dealNo,
         cache:'false',
         type : "GET",
         success : function(result){
           var str = "";   
           var status = result.status; 
           $('#detail').html("");          
           str += '<div class="car__details__pic">';
           str += '   <img src="/resources/img/upload_cyg/'+result.picture+'">';
           str += '</div>';
           str += '<div><h2>진행상황 : '+result.status+'</h2></div><br>'
           str += '<div class="car__details__sidebar__model">';
           str +=    '<ul>';
           str +=       '<li>상품명 :<span>' + result.itemName + '</span></li>';
           str +=       '<li>판매자 :<span>' + result.sellId + '</span></li>';
           str +=       '<li>구매자 :<span>' + result.buyId + '</span></li>';
           str +=    '</ul>';
           str += '</div>';
           str += '<div class="car__details__sidebar__model">';
           str +=    '<ul>';
           str +=       '<li>거래방식 :<span>' + result.type + '</span></li>';
           str +=       '<li>거래지역 :<span>' + result.region + '</span></li>';
           str +=       '<li>상품상태 :<span>' + result.itemCondition + '</span></li>';
           str +=    '</ul>';
           str += '</div>';
           str += '<div class="car__details__sidebar__model">';
           str +=    '<ul>';
           str +=       '<li>키워드 :<span>' + result.keyword1 +'</span></li>';
           str +=       '<li><span>' + result.keyword2 + '</span></li>';
           str +=       '<li><span>' + result.keyword3 +'</span></li>';
           str +=    '</ul>';
           str += '</div>';
           str += '<div class="car__details__sidebar__model">';
           str +=    '<ul>';
           str +=       '<li>대분류 :<span>' + result.bigClassifier + '</span></li>';
           str +=       '<li>중분류 :<span>' + result.mediumClassifier + '</span></li>';
           str +=    '</ul>';
           str += '</div>';
           str += '<div class="car__details__sidebar__payment">';
           str +=    '<ul>';
           str +=       '<li>가격 :<span><fmt:formatNumber type="number" maxFractionDigits="3" value=""/>'+ commas(result.price) +'원</span></li>';
           str +=    '</ul>';           
           str += '<input type="hidden" value="'+result.dealNo+'">';
           if(status == '진행중' || status == '입금완료' || status == '배송중'){             
            str += '<a href="#" class="primary-btn">판매자와 대화하기</a>';
              str += '<a href="#" class="primary-btn" id="deleteDeal">거래취소</a></div>';
           }
             $('#detail').append(str);
                   
                   console.log("login id : " + "<%=id%>");
                   console.log("sellId : " + result.sellId);
                   console.log("buyId : " + result.buyId);
                   console.log("status : " + result.status);
                   
                   if (result.sellId == "<%=id%>") {
                      if (result.status == '진행중') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '입금완료') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').show();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '배송중') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').show();
                        $('#deliveryModBtn').show();
                     } else if (result.status == '완료') {
                        $('#reviewBtn').show();
                        $('#reviewId').val(result.buyId)
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '거래취소') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide(); 
                     }
                  } else if (result.buyId == "<%=id%>") {
                     if (result.status == '진행중') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').show();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '입금완료') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '배송중') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').show();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '완료') {
                        $('#reviewBtn').show();
                        $('#reviewId').val(result.sellId)
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide();
                     } else if (result.status == '거래취소') {
                        $('#reviewBtn').hide();
                        $('#depositBtn').hide();
                        $('#deliveryBtn').hide();
                        $('#deliveryInfoBtn').hide();
                        $('#deliveryModBtn').hide(); 
                     }
                        
                  }
                   
         }
      });
   }
   
   //거래취소
   $('#detail').on('click', '#deleteDeal', function(){
       var dealNo = $(this).prev().prev().val();
       var header = "${_csrf.headerName}";
       var token = "${_csrf.token}";
       
       $.ajax({
          url : "/myPage/deleteDeal/" + dealNo,
          data : dealNo,
          type : "POST",
          beforeSend : function(xhr)
            {   
            xhr.setRequestHeader(header, token);
            },
            success : function(result){
               if(confirm("정말로 거래를 취소하시겠습니까??")){
                  alert("거래가 취소되었습니다.");
                  location.href = "/myPage/dealList";
               } else {
                  return false;
               }
            }
       });
   });
   
   
   //차트생성
   google.charts.load('current', {'packages':['corechart']}); 
        google.charts.setOnLoadCallback(drawChart);
        function drawChart() {
           var completeCnt = $('#completeCnt').val(); 
           var progressCnt = $('#progressCnt').val();
           var data = new google.visualization.DataTable();
            data.addColumn('string','status');
            data.addColumn('number','건수');
 
            data.addRows([ 
                ['진행중', parseInt(progressCnt)],
                ['거래완료', parseInt(completeCnt)]               
            ]);
            var options = {                    
                  'width':250, 
                  'height':250,                  
                  tooltip:{textStyle : {fontSize:15}, showColorCode : true},                  
                  'fontSize' : 12,
                  'min' : 0,
                  'max' : 40,                 
                  legend: { position: "none" },
                    animation: { 
                       startup: true,
                        duration: 2000,
                        easing: 'linear' }                   
                  };
            var chart = new google.visualization.ColumnChart(document.getElementById('myChart'));
            chart.draw(data,options);
        }
   
       
    
   //날짜 포맷팅
   function formatDate(dateVal){
         var date = new Date(dateVal);
      var year = date.getFullYear();              
          var month = (1 + date.getMonth());          
              month = month >= 10 ? month : '0' + month;  
        var day = date.getDate();                  
              day = day >= 10 ? day : '0' + day;      
       return  year + '-' + month + '-' + day;       
   }
    
   //숫자 콤마 찍기
   function commas(num) {
       return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }
      
   
   
 

</script>

<script type="text/javascript">
function star1Click() {
   $('#star1').html("★");
   $('#star2').html("☆");
   $('#star3').html("☆");
   $('#star4').html("☆");
   $('#star5').html("☆");
   $('#starScore').val("1");
}

function star2Click() {
   $('#star1').html("★");
   $('#star2').html("★");
   $('#star3').html("☆");
   $('#star4').html("☆");
   $('#star5').html("☆");
   $('#starScore').val("2");
}

function star3Click() {
   $('#star1').html("★");
   $('#star2').html("★");
   $('#star3').html("★");
   $('#star4').html("☆");
   $('#star5').html("☆");
   $('#starScore').val("3");
}

function star4Click() {
   $('#star1').html("★");
   $('#star2').html("★");
   $('#star3').html("★");
   $('#star4').html("★");
   $('#star5').html("☆");
   $('#starScore').val("4");
}

function star5Click() {
   $('#star1').html("★");
   $('#star2').html("★");
   $('#star3').html("★");
   $('#star4').html("★");
   $('#star5').html("★");
   $('#starScore').val("5");
}

function deposit() {
   
   $.ajax({
      url : "/deal/pay?dealNo=" + dealNo,
      dataType : "json",
      type : "GET",
      success : function(result){
         alert(result);
      }
   });
}

</script>
<%@include file="../includes/footer.jsp"%>