
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%request.setCharacterEncoding("UTF-8"); %>
<%-- 
<jsp:useBean id="member" class="member.MemberVO" scope="page"/>
<jsp:setProperty name="member" property="id"/>	<!--property의 id는 login.jsp에서 input의 name에서 받아온 id의 값을 member객체의  id안에 저장하게 된다. (이름이 같으니깐) -->
<jsp:setProperty name="member" property="pw"/>
<jsp:setProperty name="member" property="name"/>
<jsp:setProperty name="member" property="nickname"/>
<jsp:setProperty name="member" property="gender"/>
<jsp:setProperty name="member" property="age"/>
<jsp:setProperty name="member" property="phone"/>
<jsp:setProperty name="member" property="email"/> --%>
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
	<%
	
	MemberDAO md = new MemberDAO();
	PrintWriter script = response.getWriter();
	
	String id = null;
	//로그인을 이미 한 상태면 변수 id에 session으로 값을 받아온 id값을 넣어준다.
	if(session.getAttribute("id") != null){
		id = (String)session.getAttribute("id");
	}
	
	//로그인이 안된경우
	if(id == null){
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	int b_id=0;
	//
	if(request.getParameter("b_id") != null){
		b_id = Integer.parseInt(request.getParameter("b_id"));
	} 
	
	//가져온 글이 없는 경우 bbs페이지로 이동
	if(b_id ==0){
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}
	
	BoardVO board = new BoardDAO().getBoard(b_id);
	if(!md.getNickuseid(id).equals(board.getNickname())){
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	System.out.println(board.getContent());
	
	
	
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
			
		
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="mypage.jsp">마이페이지</a></li>	<!-- active :현재 선택됨  -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
	
		</div>
	</nav>
	
	<div class="container">
		<div class="row">
		
		<form method="post" action="updateAction.jsp?b_id=<%=b_id%>">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글 수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>닉네임</strong></div>
						</td> 
						<td><input type="text" class="form-control" value=<%=md.getNickuseid(id)%> name="nickname" maxlength="50" readonly></td>
					</tr>
					 <tr>
						<td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>타입</strong></div>
						</td> 
						<td><input type="text" class="form-control" value="게시판" name="b_type" maxlength="50" readonly></td>
					</tr>
					<tr>
						<td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>제목</strong></div>
						</td> 
						<td bgcolor="#f7f7f7"><input type="text" class="form-control" value="<%=board.getTitle()%>" placeholder="글 제목" name="title" maxlength="50"></td>
					</tr>
					<tr>
						<td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>내용</strong></div>
						</td> 
						<td bgcolor="#f7f7f7"><textarea class="form-control"   name="content" maxlength="2000"  style="height:350px"><%=board.getContent()%></textarea></td>
					</tr>
				</tbody>	
			</table>
			<input type="submit"  class="btn btn-primary pull-right" value="수정">
		</form>
		
		
			
		</div>
	
	
	</div>
	


	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>


</body>
</html>