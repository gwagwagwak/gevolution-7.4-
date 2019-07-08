
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=deviece-width", initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<style>
	#topMenu ul li { /*  list-style: none; */ 
	font-family : "Helvetica Nene";
	/* color: white; 
	background-color: #2d2d2d; 
	float: left; 
	line-height: 30px; 
	vertical-align: middle; 
	text-align: center;  */
	}

</style>




<title>Insert title here</title>
</head>
<body>
	<%
	PrintWriter script = response.getWriter();
	
	String id = null;
	String nickname = null;
	
	//로그인을 이미 한 상태면 변수 id에 session으로 값을 받아온 id값을 넣어준다.
	if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
		MemberDAO mdao = new MemberDAO();
		nickname = mdao.getNickuseid(id);
	}
	
	%>


	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">gevolution</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<%-- <li><a href="bbsAction.do?id=${id}&pageNumber=1">게시판</a></li> --%>
				<li><a href="bbsAction.do">게시판</a></li>
				<li><a href="reviewListAction.do?game_name='7개의 대죄'">게임순위</a></li>
			</ul>
			
			<%
				//로그인이 되있지 않다면 로그인, 회원가입 드롭다운 메뉴를 생성
				if(id == null){
			%>
			<ul class="nav navbar-nav navbar-right" id="topMenu" >
				<li class="dropdown" id="topMenu">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>	<!-- active :현재 선택됨  -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
				else{	//로그인이 된 경우
			%>
			
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><%=nickname %></a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="mypage.jsp">마이페이지</a></li>	<!-- active :현재 선택됨  -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>gevolution</h1>
				<p>게임순위</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">게임 랭킹</a></p>
			
			</div>		
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="img/camogli.jpg">
				</div>
				<div class="item">
					<img src="img/camping.jpg">
				</div>
				<div class="item">
					<img src="img/escalators.jpg">
				</div>
			</div>
			<a class="left carousel-control" href=#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href=#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		
		</div>
	</div>
	


	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>


</body>
</html>