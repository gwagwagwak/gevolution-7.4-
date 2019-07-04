
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=deviece-width", initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<title>Insert title here</title>
</head>
<body>


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
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li><a href="rank.jsp">게임순위</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>	<!-- active :현재 선택됨  -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<!--로그인 화면  보내는 인자 userID, userPassword-->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form action="joinAction.jsp" method="post">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
						아이디 <input type="text" class="form-control" placeholder="User ID" name="id" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="User PW" name="pw" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Name" name="name" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Nickname" name="nickname" maxlength="20" >
					</div>
					<div class="form-group" style="text-align:center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="gender" autocomplete="off" value="남자"checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="gender" autocomplete="off" value="여자">여자
							</label>
						</div>	
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Age" name="age" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Phone" name="phone" maxlength="20" >
					</div>
					<div class="form-group">
						<input type="email" class="form-control" placeholder="Email" name="email" maxlength="20" >
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>
	</div>



	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>


</body>
</html>