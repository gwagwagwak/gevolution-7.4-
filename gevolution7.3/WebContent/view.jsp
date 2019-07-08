
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>


<%
	request.setCharacterEncoding("UTF-8");
%>

<%-- <jsp:useBean id="member" class="member.MemberVO" scope="page"/>
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
<meta name="viewport" content="width=deviece-width" , initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
<title>Insert title here</title>
</head>
<body>
	<%
		PrintWriter script = response.getWriter();
		
		MemberDAO mdao = new MemberDAO();
		
		BoardVO board = new BoardVO();
		BoardDAO bdao = new BoardDAO();
		

		String id = null;
		int b_id = 0;	//게시판 아이디

		//로그인을 이미 한 상태면 변수 id에 session으로 값을 받아온 id값을 넣어준다.
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
			System.out.println("아이디 출력 : " +id);
		}
		
		if (request.getParameter("b_id") != null) {
			b_id = Integer.parseInt(request.getParameter("b_id"));
			System.out.println("보드 아이디 : " + b_id);
			System.out.println("회원 아이디 : " + id);
		}

		//가져온 글이 없는 경우 bbs페이지로 이동
		if (b_id == 0) {
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbsAction.do'");
			script.println("</script>");
		}
		
		if(request.getAttribute("board")== null){
			script.println("<script>");
			script.println("alert('board를 받아오지 못했습니다.')");
			script.println("location.href='bbsAction.do'");
			script.println("</script>");
		}else{
			//blist =(ArrayList<BoardVO>)request.getAttribute("blist");	//리스트 생성
			board = (BoardVO)request.getAttribute("board");
			System.out.println("board객체 불러오기 성공");	
		}
		
		//board = bdao.getBoard(b_id);
		//board.getBoard(b_id);

		System.out.println("보드내용: " + board.getTitle());
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
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbsAction.do">게시판</a></li>
				<li><a href="reviewListAction.do">게임순위</a></li>
			</ul>

			<%
				//로그인이 되있지 않다면 로그인, 회원가입 드롭다운 메뉴를 생성
				if (id == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<!-- active :현재 선택됨  -->
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else { //로그인이 된 경우
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="mypage.jsp">마이페이지</a></li>
						<!-- active :현재 선택됨  -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<div class="container">
		<div class="row">


			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<%-- <td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>작성자</strong></div>
						</td> 
						<td><input type="text" class="form-control" value=<%=md.getNickuseid(id)%> name="nickname" maxlength="50" readonly></td> --%>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%=board.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
					<tr>
						<!-- <td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>타입</strong></div>
						</td> 
						<td><input type="text" class="form-control" value="게시판" name="b_type" maxlength="50" readonly></td> -->
						<td>작성자</td>
						<td colspan="2"><%=board.getNickname()%></td>

					</tr>
					<tr>
						<!-- <td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>제목</strong></div>
						</td> 
						<td bgcolor="#f7f7f7"><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50"></td> -->
						<td>작성일자</td>
						<td colspan="2"><%=board.getDay()%></td>
					</tr>
					<tr>
						<!-- <td width="80" bgcolor="#f7f7f7">
							<div align="right"><strong>내용</strong></div>
						</td> 
						<td bgcolor="#f7f7f7"><textarea class="form-control" placeholder="글 내용" name="content" maxlength="2000" style="height:350px"></textarea></td> -->
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=board.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>")%></td>
					</tr>
				</tbody>
				<%-- <%=board.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> --%>
			</table>
			<a href="bbsAction.do" class="btn btn-primary">목록</a>
			<%
				if (id != null && mdao.getNickuseid(id).equals(board.getNickname())) {
			%>
			<a href="update.jsp?b_id=<%=b_id%>" class="btn btn-primary">수정</a> <a
				onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction.do?b_id=<%=b_id%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
</body>
</html>