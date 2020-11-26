<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri ="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>

	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>관심리스트</h2>
						<span>Wish List</span>
					</div>
				</div>
			</div>
		</div>
	
	 <!-- Car Section Begin -->    
        <div class="container">
        	<div id="count" style="text-align: center; font-size: 25px;">
        		<input type="hidden" id="countVal" value="${count }">	
			</div><br><br>
            <div class="row">                
                <div class="col-lg-12">
                    <div class="car__filter__option" style="background-color: white;">                    
                        <div class="row">
                             <div class="col-lg-8 col-md-6">
                                <button id="deleteSelect" class="btn btn-danger" >선택삭제</button>&emsp;
                                <button id="deleteAll" class="btn btn-danger">전체삭제</button>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="car__filter__option__item car__filter__option__item--right">
                                    <button class="btn btn-danger">판매자와 대화하기</button>
                                </div>
                            </div>                           
                        </div>
                    </div>                    
           			 <div class="row">
						<div class="col-lg-12 col-md-12">
							<table class="table table-hover">
								<colgroup>
									<col style="width: 10%;" />
									<col style="width: 10%;" />
									<col style="width: auto;" />
									<col style="width: 10%;" />
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
								</colgroup>
								<thead>
									<tr class="danger">
										<th><input type="checkbox" id="checkAll" style="zoom:2.0;"></th>
										<th></th>
										<th>상품명</th>
										<th>거래방식</th>
										<th>키워드1</th>
										<th>키워드2</th>
										<th>키워드3</th>										
										<th>가격</th>										
									</tr>
								</thead>
								<tbody id="list">
									
								</tbody>
							</table>
						</div>
					</div>	
                    <div class='pagination__option' id="pagenation">
					
				</div>
			<!--  end Pagination -->  
                </div>
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
						<h4 class="modal-title" id="myModalLabel">상세보기</h4>
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
		wishList(pageNum);
	});


	//위시리스트 선택삭제, 전체선택 삭제 
	
	$('#deleteSelect').on('click', function(){		
			checkArr();				
	});
	
	function checkArr(){
		var checkArr = [];
		var header = "${_csrf.headerName}";
	    var token = "${_csrf.token}";
		$("input[name='check']:checked").each(function(i){
			checkArr.push($(this).val());
			console.log(checkArr);
		});
		
		$.ajax({
			url : '/myPage/deleteWish',
			type : 'POST',
			dataType : 'text',
			data : {checkArr : checkArr},
			beforeSend : function(xhr)
	        {  
	        xhr.setRequestHeader(header, token);
	        },
			success : function(){
				if(checkArr.length == 0){
					alert("선택된 상품이 없습니다.")
					return
				}
				location.reload();
			}
		});
	}	
	
	
	 //위시리스트 전체삭제
	 var count = $('#countVal').val();	 
	 $('#deleteAll').on('click', function(){
		 if(count == 0){
			 alert("위시리스트가 비어있습니다.")
		 }		 
		 else if(confirm("총 "+count+"개의 상품을 삭제하시겠습니까??")) {
			 location.href = "/myPage/deleteAllWish";	
         } else {
             return false;
         }	 
	 });
	 
	 
	 //체크박스 전체선택 , 전체삭제
	 $('#checkAll').on('click', function(){
		  checkAll();
	 });
	 
	 function checkAll() {
	     if ($("#checkAll").is(':checked')) {
	         $("input[type=checkbox]").prop("checked", true);
	     } else {
	         $("input[type=checkbox]").prop("checked", false);
	     }
	 }	
	 
	 
	 function wishList(page){
		var str = "";		
		var param = new Object();
		param.page = page || 1;			
		
		$.ajax({
			url : "/myPage/wishListAjax/" + page,
			dataType : "json",
			data : param,
			type : "GET",
			success : function(result){				
				var wishCnt = result.wishCnt;				
				$('#list').html("");
				
				result.list.forEach(function(element){					
				if(element == null){
					str = '<tr><td colspan="5" align="center">위시리스트가 비어있습니다.</td></tr>';
				} else {					  
					str  = '<tr style="vertical-align: middle;">';		
					str += '<td><input type="checkbox" name="check" value="'+ element.wishNo +'" style="zoom:2.0;"></td>';
					str += '<td><img src="/resources/img/upload_cyg/'+ element.picture +'" style="height: 80px; width: 80px;"></td>';
					str += '<td><h5 style="font-weight: bold;">';
					str += '<input id="modalNo" name="modalNo" type="hidden" value="'+ element.sellNo +'">';
					str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">'+ element.itemName+'</a></h5>';
					str += '<td>'+ element.sellId +'</td>';
					str += '<td>'+  element.keyword1 +'</td>';		
					str += '<td>'+  element.keyword2 +'</td>';		
					str += '<td>'+  element.keyword3 +'</td>';			
					str += '<td>'+  commas(element.price) +'</td>';				                                  
					str += '</tr>';			
				    
						$('#list').append(str);						
						showPage(wishCnt);					
				     	}
					});
						$('#count').html("");
						var count = '<b>'+wishCnt+'개의 상품이 담겨있어요!!</b>';
		        		$('#count').append(count);
					}					
				});			
			} 
	 
	//페이징 이동
	 $("#pagenation").on("click","li a", function(e){
	        e.preventDefault();      
	        
	        var targetPageNum = $(this).attr("href");	        
	        pageNum = targetPageNum;
	        
	        wishList(pageNum);
	   }); 

 	
 	//페이징 계산 및 출력 
	 var pageNum = 1;
	 
	 function showPage(wishCnt){      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9;       
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= wishCnt){
	        endNum = Math.ceil(wishCnt/10.0);
	      }	      
	      if(endNum * 10 < wishCnt){
	        next = true;
	      }		  
	      var str = "<ul class='pagination pull-left'>";	      
	      
	      if(prev){
	        str+= "<li class='paginate_button previous'><a href='"+(startNum -1)+"'>Previous</a></li>";
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
	

	//위시리스트 상세보기
	$(document).ready(function () {			
		$('#list').on("click",".targetModal" ,function(){
			var modalNo = $(this).prev().val();
			console.log(modalNo);
			var list = "";
			var str = "";
			$.ajax({
			   url : "/myPage/sellDetail/" + modalNo,
			   dataType : "json",
			   data : modalNo,
			   type : "GET",
			   success : function(result){			 
				   
				  $('.modal-body').html("");
				  
				  if(result.picture != null){
				  	str += '<div class="car__details__pic"><img id="pic" src="/resources/img/upload_cyg/'+result.picture+'"></div>';
				  } else {
					str += '<div class="car__details__pic"><img id="pic" src="/resources/img/upload_cyg/noImage.jpg"></div>';	  
				  }
				  str += '<div class="car__details__sidebar__model"><ul><li>상품명 :<span>' + result.itemName + '</span></li>';
				  str += '<li>판매자 :<span>' + result.id + '</span></li></ul></div>';			 
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>거래방식 :<span>' + result.type + '</span></li>';
				  str += '<li>거래지역 :<span>' + result.region + '</span></li>';
				  str += '<li>상품상태 :<span>' + result.itemCondition + '</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>키워드 :<span>' + result.keyword1 +'</span></li><li><span>' + result.keyword2 + '</span></li>';
				  str += '<li><span>' + result.keyword3 +'</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__model">';
				  str += '<ul><li>대분류 :<span>' + result.bigClassifier + '</span></li><li>중분류 :<span>' + result.mediumClassifier + '</span></li></ul></div>';
				  str += '<div class="car__details__sidebar__payment">';
				  str += '<ul><li>가격 :<span>' + commas(result.price) +'원</span></li></ul>';
				  str += '<a href="#" class="primary-btn">판매자와 대화하기</a></div>';				  
				  
					 $('.modal-body').append(str);
			   }
			});
		});	
	});	
	 
	 //가격 콤마찍기
	 function commas(num) {
		    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	 
</script>

<%@include file="../includes/footer.jsp"%>