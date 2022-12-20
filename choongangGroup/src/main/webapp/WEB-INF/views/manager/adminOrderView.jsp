<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bottSTrap CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">		
<!-- bootStrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- CSS -->
<link rel="stylesheet" href="/css/styles2.css">
<link rel="stylesheet" href="/css/stylesLec.css">
<style type="text/css">
button {
  webkit-appearance: none;
  moz-appearance: none;
  appearance: none;
  
  background: var(--button-bg-color);
  color: var(--button-color);
  
  
  font-family: 'Noto Sans KR', sans-serif;
  font-size: 1rem;
  color: gray;
  
  border: none;
  border-radius: 4px;
  
  display: inline-block;
  width: auto;
  
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  
  cursor: pointer;
  
  transition: 0.5s;
}

button.state1_btn {
  background-color: #cfffe5;
  button-hover-bg-color: #218838;
}

button:active,
button:hover,
button:focus {
  background: var(--button-hover-bg-color);
  outline: 0;
}
button:disabled {
  opacity: 0.5;
}

	body { font-family:'맑은 고딕', verdana; padding:0; margin:0; }
	ul { padding:0; margin:0; list-style:none;  }
 
	div#root { width:90%; margin:0 auto; }
	
 
 	section#container { padding:20px 0; border-top:2px solid #eee; border-bottom:2px solid #eee; }
	section#container::after { content:""; display:block; clear:both; }
	aside { float:left; width:200px; }
	div#container_box { float:right; width:calc(100% - 200px - 20px); }
	
	aside ul li { text-align:center; margin-bottom:10px; }
	aside ul li a { display:block; width:100%; padding:10px 0;}
	aside ul li a:hover { background:#eee; }
	.orderInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;} 
	.orderInfo span { font-size:20px; font-weight:bold; display:inline-block; width:90px; }
	
	.orderView li { margin-bottom:20px; padding-bottom:20px; border-bottom:1px solid #999; }
	.orderView li::after { content:""; display:block; clear:both; }
	
	.thumb { float:left; width:200px; }
	.thumb img { width:200px; height:200px; }
	.bookInfo { float:right; width:calc(100% - 220px); line-height:2; }
	.bookInfo span { font-size:20px; font-weight:bold; display:inline-block; width:100px; margin-right:10px; }
	
	.stateChange { text-align:right; }
	.delivery1_btn,
	.delivery2_btn { font-size:16px; background:#fff; border:1px solid #999; margin-left:10px; }
</style>
<script type="text/javascript">
	function chk(){
		$(document).ready(function(){
		var state = $('#state').val();
		var orderId = $('#orderId').val();
		var state1_btn = $('#state1_btn').val();
		var data = {
				state : state,
				state1_btn : state1_btn,
				orderId : orderId
		};
		
		
		if(state != "준비 완료"){
		$.ajax({
			url : "/manager/adminOrderView",
			type : "post",
			data : data,
			success : function() {
				alert("준비가 완료되었습니다.");
				location.reload();
				/* location.href = "redirect:/admin/adminOrderView"; */
			},
			error : function() {
				alert("준비가 실패하였습니다.");
					}
				});
		} else{
			alert("준비완료된 건입니다.");
		}
		});	
	}
</script>
<script type="text/javascript">

	$(document).ready(function(){
		var state = $("#state").val();
		/* const target = document.getElementById('#state1_btn');
		const tar = document.getElementById('#state2_btn');  */
		if(state == '주문취소'){
			$("#state1_btn").attr('disabled', 'disabled');
		}
		else {
				$("#state1_btn").attr('disabled',false);
		}
	});
		
</script>
<script type="text/javascript">

	$(document).ready(function(){
		var state = $("#state").val();
		/* const target = document.getElementById('#state1_btn');
		const tar = document.getElementById('#state2_btn');  */
		if(state == '수령 완료'){
			$("#state1_btn").attr('disabled', 'disabled');
		}
		else {
				$("#state1_btn").attr('disabled',false);
		}
	});
		
</script>
</head>
<body class="" id="body-pd" onload="printClock()">
    <!-- header -->
    <!-- <nav class="navbar navbar-expand-lg navbar-dark bd-navbar bg-light sticky-top position-fixed fixed-top w-100" style="position : absolute">
        <a class="navbar-brand">
            <button class="btn ms-2" type="button">
                <img class="img-fluid" src="/images/logo2.png" alt="logo2" style="height: 40px;">
            </button>
        </a>
    </nav> -->
    <nav class="navbar navbar-expand-lg navbar-dark bd-navbar bg-light sticky-top position-fixed fixed-top w-100" style="position : absolute">
        <header class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between">
          <a href="/" class="navbar-brand">
            <img class="img-fluid" src="/images/logo2.png" alt="logo2" style="height: 40px;"><use xlink:href="#bootstrap"></use></svg>
          </a>
    
          <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
  			<jsp:include page="navHeader.jsp"></jsp:include>
          </ul>
        </header>
    </nav>
    <!-- /header -->
    <!-- side nav bar -->
    <div class="l-navbar" id="navbar">
        <nav class="navv">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                    <a href="/manager/main" class="nav__logo">교재관리</a>
                </div>
                <div class="nav__list">
                    <div href="${pageContext.request.contextPath}/manager/bookList" class="nav__link collapses">
						<!-- <ion-icon name="folder-outline" class="nav__icon"></ion-icon> -->
						<!-- <i class="bi bi-gear-fill nav__icon" name="folder-outline"></i> -->
						<i class="bi bi-book nav__icon" name="folder-outline"></i>
						<span class="nav_name">교재관리</span>

						<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

						<ul class="collapse__menu" style="width: 200px;">
							<a href="/manager/bookList" class="collapse__sublink">교재 목록</i></a></br>
							<a href="/manager/bookInsert" class="collapse__sublink">교재 입력</i></a></br>
                            <a href="/manager/adminOrderList" class="collapse__sublink">주문 관리</i></a></br>
						</ul>
					</div>
                </div>
                <a href="/logout" class="nav__link">
                    <ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
                    <span class="nav_name">Log out</span>
                </a>
            </div>
        </nav>
    </div>
    <!-- /side nav bar -->

	<!-- main content -->
	<div class="container-fluid w-100" style=" background-color: rgb(214, 225, 237)">
		<div class="row">
		
			<!-- card header -->
			<jsp:include page="contentHeader.jsp"></jsp:include>
					<!-- card header -->
                    <div class="col-9 rounded-top text-white overflow-auto pt-2 fw-bold" style="background-color: rgb(39, 40, 70); height: 40px; margin-left: 150px;"> 
                        <i class="bi bi-bookmark-fill me-2"></i>교재 관리<i class="bi bi-chevron-right"></i>주문 현황<i class="bi bi-chevron-right"></i>${orderList.orderId }
                    </div>
				
					<!-- card content -->  
<!-- 			<main class="col-9 h-100 w-50" style="margin-left: 400px;">
				<div class="row m-5">
					<div class="row mb-2 pe-0 ps-2" >
 -->						<div class="col-9 rounded-bottom overflow-auto bg-light p-3" style="min-height: 400px; margin-left: 150px;"> 
						
								<h1>
								<div class="d-flex justify-content-end">
									<a href="/manager/bookList"><i class="bi bi-book" style="color: black; margin-right: 20px;"></i></a>
									<a href="/manager/bookInsert"><i class="bi bi-pencil" style="color: black; margin-right: 20px;"></i></a>
									<a href="/manager/adminOrderList"><i class="bi bi-receipt" style="color: black; margin-right: 20px;"></i></a>
								</div>
								</h1>
							<h2 style="text-align: center;">주문 현황</h2>
								<div class="orderInfo">
							  <c:forEach items="${orderView}" var="orderView" varStatus="status">
							  
							  <c:if test="${status.first}">
							   <p><span>주문자</span>${orderView.userId}</p>
							   <p><span>수령인</span>${orderView.orderName}</p>
							   <p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.amount}" /> 원</p>
							   
														<div class="StateChange">
															<form action="/manager/adminOrderView" role="form" method="post" id="stateForm" name="stateForm" class="stateForm">
															
																<input type="hidden" name="bookId" id="bookId" value="${orderView.bookId}" />
																<input type="hidden" name="orderId" id="orderId" value="${orderView.orderId}" />
																<input type="hidden" name="state" id="state" class="state" value="${orderView.state}" />
																<input type="hidden" name="amount" id="amount" class="amount" value="${orderView.amount}" />
																<input type="hidden" name="cartStock" id="cartStock" class="cartStock" value="${orderView.cartStock}" />
																<input type="hidden" name="bookStock" id="bookStock" class="bookStock" value="${orderView.bookStock}" />
																 <p><span>준비상태</span>${orderView.state}
							<!-- 									<button type="submit" name="state1_btn" id="state1_btn" class="state1_btn" onclick="chk()" value="준비완료">준비 완료</button> -->
																<button style="margin-left: 10px;" type="button" name="state1_btn" id="state1_btn" class="btn btn-primary btn-sm font09" value="준비 완료" onclick="chk()">준비 완료</button>
																</p>
																<!-- <script type="text/javascript">
																function chk(){
																	var isDisabled = false;
																	
																	$('#state1_btn').click(function () {
							
																	    if (isDisabled) {  //<-( 1 ) 수행가능여부 검사
																	      alert("이미 작업이 수행중입니다.");
																	      return false;
																	    } else {
																	      isDisabled = true; //<-( 2 ) 실행 불가능하도록 flag 변경
																	      doSomthing();
																	      isDisable = false;    //(3)수행가능하도록 열어준다. settimeout을통해 X초 뒤에 풀어주는것도 방법이다.
																	    }
																	});
																</script> -->
																<p><span>결제상태</span>${orderView.billState}
																<button style="margin-left: 10px;" type="submit"  name="state1_btn" id="state1_btn"  class="btn btn-primary btn-sm font09" value="수령 완료" style="">수령 완료</button>
																</p>
															</form>
														</div>
							  </c:if>
							  
							 </c:forEach>
							</div>
							
							<ul class="orderView">
							 <c:forEach items="${orderView}" var="orderView" varStatus="status"> 
							 <li>
							  <div class="thumb">
							   <img src="${orderView.bookThumbImg}" style="width: 200px; height: 150px; object-fit: contain;" />
							  </div>
							  <div class="bookInfo">
							   <p>
							    <span>상품명</span>${orderView.bookName}<br />
							    <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.bookPrice}" /> 원<br />
							    <span>구입 수량</span>${orderView.cartStock} 개<br />
							    <span>재고 수량</span>${orderView.bookStock} 개<br />
							    <span>준비상태</span>${orderView.state}<br />
							    <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.bookPrice * orderView.cartStock}" /> 원
							   </p>
							  </div>
							 </li>     
							 </c:forEach>
							</ul>
							 </div>
						</div>
					</div>
					
					<!-- footer -->
				</div>
			</main>
					<footer class="col-12 mt-5" style="height: 60px; font-size: 12px;">
						@2022 ChoongAng University. All Rights Reserved.
					</footer> 
		</div>
	</div>
	
	<!-- NavBar 관련 IONICONS -->
	<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
	<!-- JS -->
	<script src="/js/main.js"></script>
</body>
</html>
