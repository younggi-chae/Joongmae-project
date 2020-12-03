<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %>
	
	<link rel="stylesheet" href="/resources/css/style_kgj.css" type="text/css">
	<!-- SocketJS CDN -->
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>


    <!-- Breadcrumb End -->
    <div class="breadcrumb-option set-bg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text__kgj">
                        <h2>${buy.title }</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Begin -->

    <!-- Car Details Section Begin -->
    <section class="car-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                        <div class="car__details__pic__large">
						<c:if test="${buy.id eq member.id }">
							<c:set var="head"
								value="${fn:substring(member.picture, 0, fn:length(member.picture)-4) }"></c:set>
							<c:set var="pattern"
								value="${fn:substring(member.picture, fn:length(head) +1, fn:length(member.picture)) }"></c:set>
							<c:choose>
								<c:when
									test="${pattern == 'jpg' || pattern == 'gif' || pattern == 'png' }">
									<img
										src="/resources/img/upload_cyg/${head }_small.${pattern}">
								</c:when>
								<c:otherwise>
									<img
										src="/resources/img/cars/memberPicture-2_kgj.jpg">
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
                </div>
                <div class="col-lg-6">
                <sec:authentication property="principal" var="pinfo"/>
                    <div class="car__details__sidebar">
                        <div class="car__details__sidebar__model">
                            <ul>
                                <li>아이디 <span>${buy.id }</span></li>
                                <li>구매희망가격 <span><fmt:formatNumber value="${buy.minPrice }" pattern="##,###"/> ~ <fmt:formatNumber value="${buy.maxPrice }" pattern="##,###"/></span></li>
                                <li>거래방법 <span>${buy.type }</span></li>
                                <c:choose>
                                	<c:when test="${buy.type != '택배거래' }">
                                		<li>직거래 지역 <span>${buy.region }</span></li>
                                	</c:when>
                                </c:choose>
                                <li>대분류 <span>${buy.bigClassifier }</span></li>
                                <li>중분류 <span>${buy.mediumClassifier }</span></li>
                                <li>키워드 <span>${buy.keyword1 }/${buy.keyword2 }/${buy.keyword3 }</span></li>
                            </ul>
                            <sec:authorize access="isAnonymous()">
                            	<a href="/sell/registerForm" class="primary-btn">판매등록</a>
                            </sec:authorize>
                            <sec:authorize access="isAuthenticated()">
                            <c:if test="${pinfo.username ne buy.id }">
                            	<a href="" id="sendSellView" class="primary-btn">견적서 보내기</a>
                            </c:if>
                            </sec:authorize>
                        </div>
                    </div>
                    <sec:authorize access="isAuthenticated()">
                    <c:choose>
                    	<c:when test="${pinfo.username eq buy.id }">
                    		<br>
		                    <div style="float: right;">
		                    	<form action="/buyBoard/delete" method="get">
		                    	<input type="hidden" name="buyNo" value="${buy.buyNo }">
		                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                     	<button type="submit" class="site-btn">삭제</button>
		                     	</form>
		                     </div>
		                     <div style="float: right; margin-right: 10px;">
		                     	<button type="button" class="site-btn" onclick="location.href='/buyBoard/reRegisterForm?buyNo=${buy.buyNo}'">재등록</button>
		                     </div>
	                     </c:when>
                     </c:choose>
                     </sec:authorize>
                     <div style="float: right; margin-right: 10px;">
                     <c:if test="${pageMaker.cri.bigClassifier ne null }">
                     	<form action="/buyBoard/list?pageNum=${pageMaker.cri.
		                     	pageNum}&amount=${pageMaker.cri.amount}&bigClassifier=${pageMaker.cri.bigClassifier }&mediumClassifier=${pageMaker.cri.
		                     	mediumClassifier }&keyword1=${pageMaker.cri.keyword1 }&keyword2=${pageMaker.cri.keyword2 }&keyword3=${pageMaker
		                     	.cri.keyword3 }&price=${price}&sort=${pageMaker.cri.sort}" method="post">
		                     	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                     	<button type="submit" class="site-btn">목록</button>
		                </form>
                     </c:if>
                     <c:if test="${pageMaker.cri.bigClassifier eq null }">
                     	<form action="/buyBoard/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&sort=${pageMaker.cri.sort}" method="post">
                     	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                     	<button type="submit" class="site-btn">목록</button>
		                </form>
                     </c:if>
		             </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Car Details Section End -->
    
    <!-- Modal  추가 -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
					<div class="modal-content">
						<div class="modal-header">
						<sec:authorize access="isAuthenticated()">
							<h4 class="modal-title" id="myModalLabel">${pinfo.username }님의 견적서</h4>
						</sec:authorize>
						</div>
						<div class="modal-body" id="sellBody">
							<input type="hidden" name="buyNo" value="${buy.buyNo }">
							<input type="hidden" name="buyId" value="${buy.id }">
							<sec:authorize access="isAuthenticated()">
							<input type="hidden" name="sellId" value="${pinfo.username }">
							</sec:authorize>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<table border="1" id="modalTable">
									<colgroup>								
										<col style="width: 30px;" />
										<col style="width: 50px;" />
										<col style="width: 200px;" />
										<col style="width: 60px;" />
										<col style="width: 60px;" />									
										<col style="width: 80px;" />
										<col style="width: 80px;" />
										<col style="width: 80px;" />
										<col style="width: 80px;" />
										<col style="width: 80px;" />
									</colgroup>
									<thead>
										<tr>
											<th>선택</th>
											<th>견적서번호</th>
											<th>물품명</th>
											<th>대분류</th>
											<th>중분류</th>
											<th>키워드1</th>
											<th>키워드2</th>
											<th>키워드3</th>
											<th>가격</th>
											<th>등록일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="sell" items="${sell }">
											<tr>
												<td><input type="checkbox" class="checkThis" onchange="checkFunction(this, ${sell.sellNo })">
												<td>${sell.sellNo }</td>
												<td><a href="" class="detailSell"><strong>${sell.itemName }</strong></a></td>
												<td>${sell.bigClassifier }</td>
												<td>${sell.mediumClassifier }</td>
												<td>${sell.keyword1 }</td>
												<td>${sell.keyword2 }</td>
												<td>${sell.keyword3 }</td>
												<td>${sell.price }</td>
												<td>
												<fmt:parseDate value="${sell.regDate }" var="sellRegDate" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${sellRegDate }" pattern="yyyy-MM-dd"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<button id="load">견적서 더보기</button>
						</div>
						<div class="modal-footer">
							<button type="button" id="sendSell" class="btn btn-danger">보내기</button>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>
	<!-- /.modal -->
	
	
	<!-- detailSell Modal -->
      <div class="modal fade" id="secondModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title" id="myModalLabel">상세 보기</h4>
            </div>
            <div class="modal-body" id="detailForm">
              <div class="form-group">
                <label>물품명</label> 
                <input class="form-control" name='itemName' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>물품 상태</label> 
                <input class="form-control" name='itemCondition' value='' readonly="readonly">
              </div>    
              <div class="form-group">
                <label>대분류</label> 
                <input class="form-control" name='bigClassifier' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>중분류</label> 
                <input class="form-control" name='mediumClassifier' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>키워드</label> 
                <input class="form-control" name='keyword' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>거래방식</label> 
                <input class="form-control" name='type' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>직거래 지역</label> 
                <input class="form-control" name='region' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>가격</label> 
                <input class="form-control" name='price' value='' readonly="readonly">
              </div>
              <div class="form-group">
                <label>등록일</label> 
                <input class="form-control" name='regDate' value='' readonly="readonly">
              </div>
            </div>
	  <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
      </div>          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
	

<%@ include file="../includes/footer.jsp" %>
    
    <script src="/resources/js/main_kgj.js"></script>
    <script src="/resources/js/buyBoard/detail.js"></script>

</html>