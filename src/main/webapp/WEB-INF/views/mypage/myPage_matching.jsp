<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>

   <section class="services spad">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="section-title">
                  <h2>견적서 확인</h2>
                  <span>Estimate Information</span>
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
                     <div class="col-lg-6 col-md-6">                        
                        <a href="#" class="btn btn-danger" id="deleteAll">전체삭제</a>
                        <a href="/myPage/wishList" class="btn btn-info">관심리스트</a>	
                        <a href="/myPage/main" class="btn btn-info">마이페이지 메인</a>	
                     </div>
                      <div class="col-lg-6 col-md-6">										
							<div class="pull-right">
								
							</div>
						</div>					
					</div>                
               </div>
            <div class="row" id="list">
           
            </div>          
		   </div>
		</div>
		<div class='pagination__option' id="pagenation">
		</div>        
     </div>         	
   </section>
   <!-- Car Section End -->
   
   	<!-- modal창 정보 -->	
	<!--  큰창:<div class="modal-dialog"> 작은창 :<div class="modal-dialog modal-sm">  -->		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">							
						<h4 class="modal-title" id="myModalLabel">견적서 상세보기</h4>
					</div>
					<div class="modal-body">
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default"
							data-dismiss="modal">Close</button>							
					</div>
				</div>					
			</div>				
		  </div>			
	<!-- /.modal -->
			
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">   


$(document).ready(function(){ 
	sellList(pageNum);
});


//전체 리스트 가져오기
var sellList = function(page){
	var param = new Object();		
	param.page = page || 1;
	$.ajax({
      url : "/restMyPage/sellListAjax/" + page,
      dataType : "json",
      data : param,
      type : "GET",      
      success : function(result){            
      var length = result.list.length;            
      var sellCnt= result.sellCnt;
      
      $('#list').html("");
      if(length < 1){
            str = '<div style="padding:200px 350px"><h2>받은 견적서가 없습니다.</h2><div>';
            $('#list').append(str);
      }       
      result.list.forEach(function(element){   	 
    	  showList(element, sellCnt);        
      });
    }         
  });         
}

var showList = function(element, sellCnt){      
    var str = "";      
       str =  '<div class="col-lg-4 col-md-4"><div class="car__item">';                  
       str += '<div class="car__item__pic__slider">';
       if(element.picture != null){
            str += '<img style="height: 330px;" src="/resources/img/upload_cyg/'+element.picture+'"></div>';
         } else {
          str += '<img style="height: 330px;" src="/resources/img/upload_cyg/noImage.jpg"></div>';     
         }
       str += '<div class="car__item__text"><div class="car__item__text__inner">';      
       str += '<div class="label-date">' + element.id +'</div>';
       str += '<div class="label-date">'+ formatDate(element.regDate) +'</div>';
       str += '<div><input id="modalNo" name="modalNo" type="hidden" value="' + element.sellNo +'">';
       str += '<a class="targetModal" href="#" data-toggle="modal" data-target="#detailModal" data-backdrop="static" style="font-size: 25px;">' + element.itemName +'</a>';
       str += '&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;';
       str += '<button class="btn btn-danger deleteBtn" value="'+ element.sellNo +'">삭제</button>';
       str += '<ul><li><span>'+ element.keyword1 +'</span></li><li><span>'+ element.keyword2 +'</span></li>';
       str += '<li><span>'+ element.keyword3 +'</span></li></ul></div>';                                
       str += '<h6 style="font-size: 18px;">'+ commas(element.price) +'원</h6></div></div></div></div>';   
          
             $('#list').append(str);   
             showPage(sellCnt);
     }



var pageNum = 1;
function showPage(sellCnt){      
     var endNum = Math.ceil(pageNum / 10.0) * 10;  
     var startNum = endNum - 9;       
     var prev = startNum != 1;
     var next = false;   
    
     if(endNum * 10 >= sellCnt){
       endNum = Math.ceil(sellCnt/10.0);
     }	      
     if(endNum * 10 < sellCnt){
       next = true;
     }		  
     var str = "<ul class='pagination pull-left'>";	      
     
     if(prev){
       str+= "<li class='paginate_button previous'><a href='"+(startNum -1)+"'>Prev</a></li>";
     }         
     
     for(var i = startNum ; i <= endNum; i++){ 	    	  
       var active = pageNum == i? "active":"";        
       str+= "<li class='paginate_button'><a class='"+active+"' href='"+i+"'>"+i+"</a></li>";
     }
     
     if(next){
       str+= "<li class='paginate_button next'><a href='"+(endNum + 1)+"'>Next</a></li>";
     }     
     str += "</ul>";      
     $("#pagenation").html(str);
   }
   
$('#pagenation').on("click","li a", function(e){
    e.preventDefault();    
    var targetPageNum = $(this).attr("href");    
    pageNum = targetPageNum;    
    sellList(pageNum);
  });     
        
        
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
 <%@include file="../includes/footer.jsp"%>   