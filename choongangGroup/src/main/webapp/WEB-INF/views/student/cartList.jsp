<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bottSTrap CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<!-- bootStrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
	integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- CSS -->
<link rel="stylesheet" href="/css/styles2.css">
<link rel="stylesheet" href="/css/stylesLec.css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function allChk() {
		var chk = $("#allCheck").prop("checked");
		if (chk) {
			$(".chBox").prop("checked", true);
		} else {
			$(".chBox").prop("checked", false);
		}
		$(".chBox").click(function() {
			$("#allCheck").prop("checked", false);
		});
	}

	/* var confirm_val = confirm("정말 삭제하시겠습니까?");
	
	if(confirm_val) {
	 var checkArr = new Array();
	 
	 $("input[class='chBox']:checked").each(function(){
	  checkArr.push($(this).attr("data-cartNum"));
	 });
	  
	 $.ajax({
	  url : "/student/deleteCart",
	  type : "post",
	  data : { chbox : checkArr },
	  success : function(){
	   location.href = "/student/cartList";
	  }
	 });
	}  */
	function selectDelete_btn() {
		var cartNum = $("#cartNum").val();
/* 		var chk = $("#allCheck").prop("checked"); */
		console.log("cartNum" + cartNum);

		var data = {
			cartNum : cartNum,
		};

		$.ajax({
			url : "/student/deleteCart",
			type : "post",
			data : data,
			success : function(result) {
				alert("삭제 성공");
				location.href = "/student/cartList";
			},
			error : function() {
				alert("삭제 실패인데 성공?");
				location.href = "/student/cartList";
			}
		});
	}
</script>


<style type="text/css">
#container_box table td {
	width: 100px;
}

section#container {
	padding: 20px 0;
	border-top: 2px solid #eee;
	border-bottom: 2px solid #eee;
}

section#container::after {
	content: "";
	display: block;
	clear: both;
}

aside {
	float: left;
	width: 200px;
}

div#container_box {
	float: right;
	width: calc(100% - 200px - 20px);
}

aside {
	float: left;
	width
	200px;
}

aside ul li {
	text-align: center;
	margin-bottom: 10px;
}

aside ul li a {
	display: block;
	width: 100%;
	padding: 10px 0;
}

aside ul li a:hover {
	background: #eee;
}

.inputArea {
	border: 1px;
	margin: 10px 0;
}

select {
	width: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='bookInfo'] {
	display: block;
}

input {
	width: 150px;
}

textarea#bookInfo {
	width: 400px;
	height: 180px;
}

div.books p.buyStock input {
	font-size: 22px;
	width: 50px;
	padding: 5px;
	margin: 0;
	border: 1px solid #eee;
}

.allCheck {
	float: left;
	width: 200px;
}

.allCheck input {
	width: 16px;
	height: 16px;
}

.allCheck label {
	margin-left: 10px;
}

.delBtn {
	float: right;
	width: 300px;
	text-align: right;
}

.delBtn button {
	font-size: 18px;
	padding: 5px 10px;
	border: 1px solid #eee;
	background: #eee;
}

.checkBox {
	float: left;
	width: 30px;
}

.checkBox input {
	width: 16px;
	height: 16px;
}

.listResult {
	padding: 20px;
	background: #eee;
}

.listResult .sum {
	float: left;
	width: 45%;
	font-size: 22px;
}

.listResult .orderOpne {
	float: right;
	width: 45%;
	text-align: right;
}

.listResult .orderOpne button {
	font-size: 18px;
	padding: 5px 10px;
	border: 1px solid #999;
	background: #fff;
}

.listResult::after {
	content: "";
	display: block;
	clear: both;
}
.container ul li{ 
	text-align: center;
}
</style>
</head>
<body id="body-pd">
	<!-- header -->
	<nav
		class="navbar navbar-expand-lg navbar-dark bd-navbar bg-light sticky-top position-fixed fixed-top w-100"
		style="position: absolute">
		<header
			class="d-flex flex-wrap align-items-center justify-content-center justify-content-md-between">
			<a href="/student/main" class="navbar-brand  ms-3"> <img
				class="img-fluid" src="/images/logo2.png" alt="logo2"
				style="height: 40px;">
			</svg>
			</a>

			<!-- <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
				<li><a href="#" class="nav-link px-2 link-secondary">Home</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">Features</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">Pricing</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">FAQs</a></li>
				<li><a href="#" class="nav-link px-2 link-dark">About</a></li>
			</ul> -->
		</header>
	</nav>

	<!-- side nav bar -->
	<%-- <div class="l-navbar" id="navbar">
		<nav class="navv">
			<div class="nav__brand">
				<ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
				<a href="#" class="nav__logo"></a>
			</div>
			<a href="/professor/calenderForm" class="nav__link active">
				<i class="bi bi-calendar-plus nav__icon" ></i>
				<span class="nav_name">캘린더</span>
			</a>
			<a href="/logout" class="nav__link">
				<ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">Log out</span>
			</a>
			

			<div href="#" class="nav__link collapses ">
				<ion-icon name="folder-outline" class="nav__icon"></ion-icon>
				<span class="nav_name">학사관리</span>
				<ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

				<ul class="collapse__menu  " style="width: 180px;">
					<a href="#" class="collapse__sublink mt-2 mb-2" style="font-size: 0.875rem;">강의시간표</a>
					<a href="/professor/lecMgMain?userid=${userid}" class="collapse__sublink mb-1 ms-0" style="font-size: 0.875rem;">강의관리</a>
					<a href="#" class="collapse__sublink ms-3" style="font-size: 0.8rem;">전자출석부</a>
					<a href="#" class="collapse__sublink ms-3 mb-2"  style="font-size: 0.8rem;">과제관리</a>
					
					<a href="#" class="collapse__sublink mb-2" style="font-size: 0.875rem;">강의계획서</a>
					<a href="/professor/lecCreateList" class="collapse__sublink mb-2" style="font-size: 0.875rem;">강의개설</a>
					<!-- <a href="#" class="collapse__sublink mb-1" style="font-size: 0.875rem;">강의정보</a>
					<a href="#" class="collapse__sublink ms-3"  style="font-size: 0.8rem;">강의계획서</a>
					<a href="#" class="collapse__sublink ms-3 mb-2"  style="font-size: 0.8rem;">강의개설</a> -->
					<a href="/professor/lecScore" class="collapse__sublink mb-2" style="font-size: 0.875rem;">성적관리</a>
					<a href="#" class="collapse__sublink mb-2" style="font-size: 0.875rem;">휴&#183;보강 신청</a>
					<a href="#" class="collapse__sublink mb-2" style="font-size: 0.875rem;">내선번호관리</a>
				</ul>
			</div>

			<div class="nav__list">
				<div href="#" class="nav__link collapses">
	                 <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
	                 <span class="nav_name">Projects</span>
	
	                 <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
	
	                 <ul class="collapse__menu">
	                     <a href="#" class="collapse__sublink">Data</a>
	                     <a href="#" class="collapse__sublink">Group</a>
	                     <a href="#" class="collapse__sublink">Members</a>
	                 </ul>
	             </div>
				<a href="#" class="nav__link">
					<ion-icon name="chatbubbles-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">결재</span>
				</a>
				<!-- <a href="#" class="nav__link">
					<ion-icon name="people-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">내선번호관리</span>
				</a> -->
				<a href="#" class="nav__link">
					<ion-icon name="settings-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">개인정보관리</span>
				</a>
				<a href="/logout" class="nav__link">
					<ion-icon name="log-out-outline" class="nav__icon"></ion-icon>
					<span class="nav_name">Log out</span>
				</a>
			</div>
		</nav>
	</div> --%>

	<!-- side nav bar -->
    <div class="l-navbar" id="navbar">
        <nav class="navv">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                   <!--  <a href="#" class="nav__logo">카테고리</a> -->
                </div>
                <div class="nav__list">
                   <div href="#" class="nav__link collapses">
                        <i class="bi bi-person-rolodex"></i>
                        <span class="nav_name">학사관리</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu" style="width: 200px;">
                            <li><a href="/student/listEmp" class="collapse__sublink">학적정보 조회</a></li>
                            <li><a href="/student/lectureListForm" class="collapse__sublink">강의목록 조회</a></li>
                            
                            <li><a href="/student/timetable" class="collapse__sublink">시간표 조회</a></li>
                           

                        </ul>
                    </div>
                    

               <a href="/student/gradeList" class="nav__link">
                       <i class="bi-mortarboard"></i>
                       <span class="nav_name">&nbsp;성적 관리</span>
                   </a>
      

               <a href="/student/evaluationList" class="nav__link">
                       <i class="bi-pencil"></i>
                       <span class="nav_name">&nbsp;강의 평가</span>
                   </a>


               <a href="/student/applyIndex" class="nav__link">
                       <i class="bi bi-box-arrow-up-right"></i>
                       <span class="nav_name">&nbsp;수강 신청</span>
                   </a>
                    <div href="/student/shopList" class="nav__link collapses">
                        <i class="bi bi-book"></i>
                        <span class="nav_name">&nbsp;교재 구매</span>

                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>

                        <ul class="collapse__menu" style="width: 200px;">
                            <li><a href="/student/shopList" class="collapse__sublink">교재 목록</a></li>
                            <li><a href="/student/cartList" class="collapse__sublink">장바구니</a></li>
                            <li><a href="/student/orderList" class="collapse__sublink">주문 목록</a></li>
                        </ul>
                    </div>
                </div>
                <a href="/logout" class="nav__link">
                    <i class="bi-power"></i>
                    <span class="nav_name">&nbsp; Log out</span>
                </a>
            </div>
        </nav>
    </div>
    <!-- /side nav bar -->

	<!-- main content -->
   <div class="container-fluid w-100" style=" background-color: rgb(214, 225, 237)">
      <div class="row">
      
         <!-- content header -->
         <div class="col-12 px-5 py-4" style=" background-color: rgb(95, 142, 241)">
            <div class="d-flex flex-row mb-2 mt-2">
               <div>
                  <span class="text-white h4">안녕하세요. <span class="fw-bold">${name}</span>님!</span>
               </div>
               <div class="border border-1 border-white rounded-pill text-white ms-2"  style="height: 25px;">
                  <div class="font09 align-items-center">&nbsp; 학생  &nbsp;</div>
               </div>
               <div><i class="text-white bi-gear-fill mx-2">  </i></div>
            </div>
            <div class="row">

            <div>
               <span class="text-white font09">${major}과&nbsp; &nbsp; ${grade}&nbsp;학년 </span>
            </div>
            </div>
            <div class="d-flex flex-low mb-2">
               <div><i class="bi bi-envelope-fill text-white"></i></div>
               <div><span class="text-white ms-2 font09">${email}</span></div>
            </div>

         </div>

				<div class="row m-5">

					<!-- card content -->
					<!-- card header -->
                    <div class="col-9 rounded-top text-white overflow-auto pt-2 fw-bold" style="background-color: rgb(39, 40, 70); height: 40px; margin-left: 150px;"> 
                        <i class="bi bi-bookmark-fill me-2"></i>교재 구매<i class="bi bi-chevron-right"></i>장바구니
                    </div>
				
					<!-- card content -->  
<!-- 			<main class="col-9 h-100 w-50" style="margin-left: 400px;">
				<div class="row m-5">
					<div class="row mb-2 pe-0 ps-2" >
 -->						<div class="col-9 rounded-bottom overflow-auto bg-light p-3" style="min-height: 400px; margin-left: 150px;">
							<section id="content">
								<h1>
									<div class="d-flex justify-content-end">
										<a href="/student/shopList"><i class="bi bi-book"
											style="color: black; margin-right: 20px;"></i></a> <a
											href="/student/cartList"><i class="bi bi-cart2"
											style="color: black; margin-right: 20px;"></i></a> <a
											href="/student/orderList"><i class="bi bi-receipt"
											style="color: black; margin-right: 20px;"></i></a>
									</div>
								</h1>
								<span style="text-align: center;">
								<h2>장바구니 목록</h2>
								</span>
								<div class="d-flex justify-content-end">
									<div class="allCheck">
										<input type="checkbox" class="allCheck" name="allCheck"
											id="allCheck" onclick="allChk()" style="width: auto;" /> <label
											for="allCheck" style="width: auto;">
											<h5>전체 선택</h5>
										</label>
										<button type="button" onclick="selectDelete_btn()"
											style="border: 0px; background: none;">
											<h5>
												<i class="bi bi-trash"></i>
											</h5>
										</button>
										<div class="delBtn"></div>
									</div>
								</div>
								<div class="container">
									<ul>
										<c:set var="sum" value="0" />
										<c:forEach items="${cartList}" var="cartList">
											<p></p>
											<p></p>

											<li >
												<div class="checkBox">
													<input type="checkbox" class="chBox" name="chBox"
														id="chBox" data-cartNum="${cartList.cartNum}" />
												</div>
												<div class="bookInfo" >
													<img src="${cartList.bookThumbImg}"
														style="width: 200px; height: 150px; object-fit: contain; float: left; margin-right: 50px;" />
													<input type="hidden" value="${cartList.userId }"> 
													<input	type="hidden" value="${cartList.cartNum }" id="cartNum"
														class="cartNum" name="cartNum"> 
														<br/>
														<span>상품명 :
													</span>${cartList.bookName}<br/>
													 <span>개당 가격 : </span>
													<fmt:formatNumber pattern="###,###,###"
														value="${cartList.bookPrice}" /><br/>
													<span>구입 수량 : <%-- <input type="number" value="${cartList.cartStock}" id="cartStock" name="cartStock"> --%></span>${cartList.cartStock}
													<br/>
													<span>최종 가격 : </span>
													<fmt:formatNumber pattern="###,###,###"
														value="${cartList.bookPrice * cartList.cartStock}" /> 원<br/>
													<div class="delete">
														<div class="d-flex justify-content-end">
														<button type="button" class="delete_btn"
															style="border: 0px; background: none;"
															onclick="selectDelete_btn()"<%--  data-cartNum="${cartList.cartNum}"  --%>>
															<h5>
																<i class="bi bi-trash"></i>
															</h5>
														</button>
														</div>
													</div>

												</div>

											</li>
											<c:set var="sum"
												value="${sum + (cartList.bookPrice*cartList.cartStock)}" />
										</c:forEach>

									</ul>
									
								</div>
									<hr>
									<div class="listResult">
										<div class="sum">
											총 합계 :
											<fmt:formatNumber pattern="###,###,###">
												<c:out value="${sum}" />
											</fmt:formatNumber>
											원
										</div>
										<div class="orderOpne">
											<button type="button" class="orderOpen_btn">주문 정보 입력</button>
											<script type="text/javascript">
						
					</script>
										</div>
									</div>



									<div class="orderInfo">
										<form role="form" method="post" autocomplete="off">
											<input type="hidden" id="amount" name="amount" value="${sum}" />
											<div class="inputArea">
												<label for="orderName">수령인</label> <input type="text"
													name="orderName" id="orderName" required="required" aria-describedby="button-search"style="height: 31px;" />
											</div>

											<div class="inputArea">
												<label for="Phone">연락처</label> <input
													type="tel" name="Phone" id="Phone" required="required" aria-describedby="button-search"style="height: 31px;" />
											</div>

											<div class="inputArea">
												<!-- 						<button type="submit" class="order_btn" onclick="requestPay()">주문</button> -->
												<button type="submit" id="order_btn" class="btn btn-primary btn-sm font09">주문</button>

												<button type="button" id="cancel_btn" name="cancel_btn"
													class="btn btn-primary btn-sm font09">취소</button>
												<script type="text/javascript">
								$(".orderOpen_btn").click(function() {
									$(".orderInfo").slideDown();
									$(".orderOpen_btn").slideUp();
								});

								$("#cancel_btn").click(function() {
									$(".orderInfo").slideUp();
									$(".orderOpen_btn").slideDown();
								});
							</script>

											</div>

										</form>
									</div>
							</section>

						</div>

					</div>

					<!-- footer -->
					<footer class="col-12 mt-5" style="height: 60px; font-size: 12px;">
						@2022 ChoongAng University. All Rights Reserved. </footer>
				</div>
			</main>
		</div>
	</div>

	<!-- NavBar 관련 IONICONS -->
	<script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
	<!-- JS -->
	<script src="/js/main.js"></script>
</body>
</html>
