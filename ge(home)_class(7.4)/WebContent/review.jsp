
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<link
	href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<!-- <link href="css/business-casual.css" rel="stylesheet"> -->
<title>게시판 메인</title>

<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
		

</style>

</head>
<body>
	<%
	PrintWriter script = response.getWriter();
	
	String id = null;//회원 아이디

	String game_name = null;//게임 네임
	
	//로그인을 이미 한 상태면 변수 id에 session으로 값을 받아온 id값을 넣어준다.
	if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
	}

	int pageNumber = 1;	//기본 페이지 번호 
	//다음 페이지 번호가 존재하면 페이지 번호를 적용해준다.
	
	//파라미터에 값이 넘어왔다면 페이지 넘버를 바꾼다.
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
	}
	
	//게임이름이 있다면
	if(session.getAttribute("game_name") != null){
		game_name = (String)session.getAttribute("game_name");
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
				<li ><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
				<li><a href="rank.jsp">게임순위</a></li>
			</ul>
			
			<%
				//로그인이 되있지 않다면 로그인, 회원가입 드롭다운 메뉴를 생성
				if(id == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
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
	
	<%-- <div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>				
					<tr>
						<th style="background-color: #eeeeee; text-align:center;">번호</th>
						<th style="background-color: #eeeeee; text-align:center;">제목</th>
						<th style="background-color: #eeeeee; text-align:center;">작성자</th>
						<th style="background-color: #eeeeee; text-align:center;">작성일</th>
						<th style="background-color: #eeeeee; text-align:center;">조회</th>
					</tr>
				</thead>
				<tbody>
				<%
					BoardDAO bdao = new BoardDAO();
					ArrayList<BoardVO> blist = bdao.getList(pageNumber);
					for(int i=0; i<blist.size(); i++){
				%>
					<tr>
						<td><%=blist.get(i).getB_id() %></td>
						<td><a href="view.jsp?b_id=<%=blist.get(i).getB_id()%>"> <%=blist.get(i).getTitle() %></a></td>
						<td><%=blist.get(i).getNickname() %></td>
						<td><%=blist.get(i).getDay()%></td>
						<td><%=blist.get(i).getHits()%></td>
					</tr>
				<%
				}
				%>
				</tbody>	
			</table>
			<%
				if(pageNumber != 1){
					%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber -1%>" class="btn btn-success btn-arraw-left">이전</a>
					<%
				}if (bdao.nextPage(pageNumber +1)){
					%>
					<a href="bbs.jsp?pageNumber=<%=pageNumber +1%>" class="btn btn-success btn-arraw-left">다음</a>
					<%
				}
			%>
			<a href="review.jsp?id=<%=id%>&game_name=<%=game_name%>" class="btn btn-primary pull-right">해당 게임 리뷰 작성</a> 
		</div>
	 --%>
	
	
	<!-- <button class="btn btn-default" data-target="#layerpop" data-toggle="modal">모달출력버튼</button><br/>
	
		<div class="modal fade" id="layerpop" >
		  <div class="modal-dialog">
		    <div class="modal-content">
		      header
		      <div class="modal-header">
		        닫기(x) 버튼
		        <button type="button" class="close" data-dismiss="modal">×</button>
		        header title
		        <h4 class="modal-title">Header</h4>
		      </div>
		      body
		      <div class="modal-body">
		            Body
		      </div>
		      Footer
		      <div class="modal-footer">
		        Footer
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>
		 -->
		 
		 <div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">My World 회원 가입</h4>
					<button type="button" class="close" data-dismiss="modal">×</button>

				</div>

				<div class="modal-body">
					<form action="member/joinOk.jsp" method="post" class="form-horizontal">

						<div class="form-group">
							<label for="inputId3" class="col-sm-3 control-label">* ID</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="inputId3" name="id">
							</div>

						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-3 control-label">*
								비밀번호</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" id="inputPassword3"
									name="pw" placeholder="8자 이상으로 입력하세요.">
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-3 control-label">*
								비밀번호 확인</label>
							<div class="col-sm-6">
								<input type="password" class="form-control"
									id="inputPassword3-confirm" placeholder="위와 동일한 비밀번호를 입력하세요.">
							</div>
						</div>

						<div class="form-group">
							<label for="inputName3" class="col-sm-3 control-label">*
								이름</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="inputName3"
									name="name">
							</div>
						</div>

						<div class="form-group">
							<label for="inputaddr3" class="col-sm-3 control-label">*
								주소</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="inputaddr3"
									name="address">
							</div>
						</div>



						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">*
								이메일</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" id="inputEmail3"
									name="email" placeholder="example@myworld.com">
							</div>
						</div>



						<div class="modal-footer">
							<input type="submit" class="btn btn-default" value="완료"
								onclick="return confirm('회원 가입을 완료하시겠습니까?')">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	
	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>


</body>
</html>