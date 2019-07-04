<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
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
<jsp:setProperty name="member" property="email"/>
 --%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 
<meta name="viewport" content="width=deviece-width", initial-scale="1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
 -->
<title>Insert title here</title>
</head>
<body>
	<%
		session.invalidate();	//페이지에 접속한 회원이 session을 뺏기게 만들어서 로그아웃을 시켜준다.
	%>
	<script>
		location.href="main.jsp";
	</script>
	
	
</body>
</html>