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
		</div>
		<div class="container">	
			<div class='row'>
					<div class="col-lg-12">
						<div class="pull-right">
							<form id='searchForm' action="/myPage/buyList" method='get'>
								<select name='type'>
									<option value=""
										<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
									<option value="T"
										<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>								
								</select> 
								  <input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'/> 
								  <input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>'/>
								  <input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>'/>
								 <button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
							</form>
						</div>
					</div>					
				</div>		
		 
			<div class="row">				
				<div class="col-lg-12">					
					<div class="row">
						<div class="col-lg-12 col-md-12">
							<table class="table table-striped table-sm">
								<colgroup>
									<col style="width: 10%;" />
									<col style="width: auto;" />
									<col style="width: 10%;" />
									<col style="width: 10%;" />									
									<col style="width: 10%;" />
									<col style="width: 10%;" />
								</colgroup>
								<thead>
									<tr>
										<th>No</th>
										<th>제목</th>
										<th>거래방식</th>
										<th>키워드1</th>
										<th>키워드2</th>
										<th>키워드3</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty list }">
											<tr>
												<td colspan="5" align="center">데이터가 없습니다.</td>
											</tr>

										</c:when>
										<c:when test="${!empty list }">
											<c:forEach var="buy" items="${list }">
												<tr>
													<td>${buy.buyNo }</td>
													<td><h5 style="font-weight: bold;">
														<input id="modalNo" name="modalNo" type="hidden" value="${buy.buyNo }">                                        
														<a class="targetModal" id="targetModal" href="#" 
														data-toggle="modal" data-target="#myModal">${buy.title }</a>														
													</h5>											
													<td>${buy.type }</td>
													<td>${buy.keyword1 }</td>
													<td>${buy.keyword2 }</td>
													<td>${buy.keyword3 }</td>
												</tr>
											</c:forEach>
										</c:when>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>	
				<div class='pagination__option'>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous"><a
								href="${pageMaker.startPage -1}">Previous</a></li>
						</c:if>						
						<c:forEach var="num" begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}">							
						   <c:choose>
		                     <c:when test="${pageMaker.cri.pageNum == num }">
		                     <li class="paginate_button">
		                        <a class="active" href="${num }">${num }</a>
		                     </li>
		                     </c:when>
		                     <c:otherwise>
		                     <li class="paginate_button">
		                        <a href="${num }">${num }</a>
		                     </li>
		                     </c:otherwise>
		                  </c:choose>								
						</c:forEach>
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next"><a
								href="${pageMaker.endPage +1 }">Next</a></li>
						</c:if>
					</ul>
				</div>
				<!--  end Pagination -->
				</div>
				<form id='actionForm' action="/myPage/buyList" method='get'>
					<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
					<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
					<input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> 
					<input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
			    </form>
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
	
	
	var actionForm = $("#actionForm");

	$(".paginate_button a").on("click",	function(e) {
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']")
			.val($(this).attr("href"));
				actionForm.submit();
			});
	
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click",	function(e) {
		if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
		}
			if (!searchForm.find("input[name='keyword']").val()) {
					alert("키워드를 입력하세요");
					return false;
				}

				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				searchForm.submit();
			});
	
	

</script>
<%@include file="../includes/footer.jsp"%>