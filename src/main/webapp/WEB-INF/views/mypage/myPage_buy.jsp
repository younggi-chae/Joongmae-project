<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../includes/header.jsp"%>
	
	<!-- Header Section End -->
	<section class="services spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h2>구매등록 확인</h2>
						<span>Purchase Registration</span>
					</div>
				</div>
			</div>
		</div><br><br>
		<div class="container">	
			<div class='row'>
					<div class="col-lg-12">
						<button class="btn btn-danger" id="searchWhole">전체기간</button>
						<button class="btn btn-danger" id="search3month">최근 3개월</button>
						<button class="btn btn-danger" id="search6month">최근 6개월</button>&emsp;&emsp;					
						<span><b>조회기간</b> : <input type="text" name="startDate" id="startDate" /> - 
						<input type="text" name="endDate" id="endDate" />
						<button class="btn btn-success" id="searchRange">조회</button></span> 									
					</div>					
				</div><br><br>		
		 
			<div class="row">				
		 		<div class="col-lg-12">					
					<div class="row">
						<div class="col-lg-12 col-md-12">
							<table class="table table-hover">
								<colgroup>								
									<col style="width: 10%;" />
									<col style="width: auto;" />									
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
									<col style="width: 10%;" />
									<col style="width: 10%;" />
									<col style="width: 20%;" />
									<col style="width: 10%;" />
								</colgroup>
								<thead>
									<tr class="danger" style="background-color: #8FBC8F;">									
										<th>카테고리</th>
										<th>제목</th>
										<th>거래방식</th>																			
										<th>키워드1</th>
										<th>키워드2</th>
										<th>키워드3</th>
										<th>가격</th>
										<th>등록일</th>
									</tr>
								</thead>
						        <tbody id="list">
									
								</tbody>
							</table>
						</div>
					</div>
				  </div> 
				</div>	
				<div class='pagination__option' id="pagenation">
					 
				</div>				 
			 </div>    	
		</section>
	
	<!-- modal창 정보 -->	
	<!--  큰창:<div class="modal-dialog"> 작은창 :<div class="modal-dialog modal-sm">  -->		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">							
						<h4 class="modal-title" id="myModalLabel">구매 상세보기</h4>
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
	
	var monthCheck = 0;
	
	$(document).ready(function(){
		monthCheck = "all";
		buyList(pageNum, 1000);		
	});		
	
	$('#search3month').on('click', function(){
		monthCheck = "3";
		buyList(pageNum, 2);	
	});
	
	$('#search6month').on('click', function(){
		monthCheck = "6";
		buyList(pageNum, 5);		
	});
	
	$('#searchWhole').on('click', function(){
		monthCheck = "all";
		buyList(pageNum, 1000);
	});
		
	$('#searchRange').on('click', function(){		
		monthCheck = "range"
		searchRangeList();		
	});
	
	 function buyList(page, month){
		var str = "";		
		var param = new Object();
		param.page = page || 1;
		param.month = month;		
		
		$.ajax({
			url : "/myPage/buyListAjax/" + page + "/" + month,
			dataType : "json",
			data : param,
			type : "GET",
			success : function(result){				
				var buyCnt = result.buyCnt;				
				$('#list').html("");
				
				result.list.forEach(function(element){					
				if(element == null){
					str = '<tr><td colspan="5" align="center">데이터가 없습니다.</td></tr>';
				} else {
					str =  '<tr>';
					str += '<td>'+ element.bigClassifier+'</td><td><h5 style="font-weight: bold;">';
					str += '<input id="modalNo" name="modalNo" type="hidden" value="'+element.buyNo+'">';
					str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">'+element.title+'</a></h5>';
					str += '<td>'+element.type+'</td>';
					str += '<td>'+element.keyword1+'</td>';
					str += '<td>'+element.keyword2+'</td>';
					str += '<td>'+element.keyword3+'</td>';
					str += '<td>'+commas(element.minPrice)+'~'+commas(element.maxPrice)+'</td>';
					str += '<td>'+element.regDate+'</td></tr></tbody></table></div></div></div>';							  
				
						$('#list').append(str);						
						showPage(buyCnt);						
				     }
				});
			}			
		});			
	}
	 
	 $("#pagenation").on("click","li a", function(e){
	        e.preventDefault();      
	        
	        var targetPageNum = $(this).attr("href");
	        
	        console.log("targetPageNum: " + targetPageNum);
	        
	        pageNum = targetPageNum;
	        
	        if(monthCheck == "3"){
	        	buyList(pageNum, 2);
	        }else if( monthCheck == "6"){
	        	buyList(pageNum, 5);
	        }else if( monthCheck == "all"){
	        	buyList(pageNum, 1000);
	        }else if(monthCheck == "range"){
	        	searchRangeList(pageNum);
	        }
	       
	      }); 

	 
 	 function searchRangeList(page){
			var str = "";
			var startDate = $('#startDate').val();
			var endDate = $('#endDate').val();
			
			var page = page || 1 ;	
		
			$.ajax({
				url : "/myPage/dateSearchRange/" + page + "/" + startDate + "/" + endDate,
				dataType : "json",
				data : {startDate : startDate, endDate : endDate},
				type : "GET",
				success : function(result){
					$('#list').html("");
					var buyCnt = result.buyCnt;
					result.list.forEach(function(element){
						console.log(element);
						if(element == null){
							str = '<tr><td colspan="5" align="center">데이터가 없습니다.</td></tr>';
						} else {
							str =  '<tr>';
							str += '<td>'+ element.bigClassifier+'</td><td><h5 style="font-weight: bold;">';
							str += '<input id="modalNo" name="modalNo" type="hidden" value="'+element.buyNo+'">';
							str += '<a class="targetModal" id="targetModal" href="#" data-toggle="modal" data-target="#myModal">'+element.title+'</a></h5>';
							str += '<td>'+element.type+'</td>';
							str += '<td>'+element.keyword1+'</td>';
							str += '<td>'+element.keyword2+'</td>';
							str += '<td>'+element.keyword3+'</td>';
							str += '<td>'+commas(element.minPrice)+'~'+commas(element.maxPrice)+'</td>';
							str += '<td>'+element.regDate+'</td></tr></tbody></table></div></div></div>';							  
						
								$('#list').append(str);	
								console.log(page);
								showPage(buyCnt);								
						}
					});					
				}
			});
	     }
		
	 
	  var pageNum = 1;
	 
	 function showPage(buyCnt){      
	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
	      var startNum = endNum - 9;       
	      var prev = startNum != 1;
	      var next = false;
	      
	      if(endNum * 10 >= buyCnt){
	        endNum = Math.ceil(buyCnt/10.0);
	      }
	      
	      if(endNum * 10 < buyCnt){
	        next = true;
	      }
	      
	      var str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	           
	      
	      for(var i = startNum ; i <= endNum; i++){   
	    	  console.log(pageNum);
	    	  console.log(i);
	        var active = pageNum == i? "active":"";        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul>";
	      
	      console.log(str);      
	      $("#pagenation").html(str);
	    }
	     
	    
	
	   
	    
	    
	    $(function() { 
	    	  $("#startDate").datepicker({
	    		dateFormat: 'yymmdd',
	    		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	    	     dayNamesMin: ['일','월','화','수','목','금','토'],
	    		 changeMonth: true, 
	    	     changeYear: true, 
	    		 showMonthAfterYear: true,
	    	  });
	    	  $("#endDate").datepicker({
		    	dateFormat: 'yymmdd',
		    	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    	dayNamesMin: ['일','월','화','수','목','금','토'],
		    	changeMonth: true, 
		    	changeYear: true, 
		    	showMonthAfterYear: true,
	    	 });
	    });
	    
	

	function commas(num) {
	    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	

 </script>
<%@include file="../includes/footer.jsp"%>