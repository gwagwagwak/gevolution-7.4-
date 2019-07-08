
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="board.BoardVO"%>



<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
 


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="css/custom.css" />
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
		String id = null;
		int pageNumber = 1; //기본 페이지 번호
		ArrayList<BoardVO> blist = null;
		
		//다음 페이지 번호가 존재하면 페이지 번호를 적용해준다.

		//로그인을 이미 한 상태면 변수 id에 session으로 값을 받아온 id값을 넣어준다.
		if(session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
			System.out.println("로그인 돼있음");
		}

		//파라미터에 값이 넘어왔다면 페이지 넘버를 바꾼다.
		/* if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} */
	
		//페이지 번호 받기
		 	if (request.getAttribute("pageNumber") != null) {
		 		
 			
		 	/* String spg = (String)request.getAttribute("pageNumber");
 			
			
		 	System.out.println((String)request.getAttribute("pageNumber"));

			pageNumber = Integer.parseInt((String)request.getAttribute("pageNumber")); 
			 */
			 

			 	 String spg = request.getAttribute("pageNumber").toString();
	 			
				
			 	/* System.out.println((String)request.getAttribute("pageNumber")); */

				pageNumber = Integer.parseInt(spg); 
				System.out.println("tostring펭지ㅣ 변환:성공"+pageNumber);
				
				
		} 
		
		blist = new ArrayList<>();
		BoardDAO bdao = new BoardDAO();
		
		if(request.getAttribute("blist")== null){
			script.println("<script>");
			script.println("alert('blist를 받아오지 못했습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}else{
			blist =(ArrayList<BoardVO>)request.getAttribute("blist");	//리스트 생성
			System.out.println("bbs리스트 블러오기 성공, pagenumber : " +pageNumber);	
		}
		
		//페이징 처리 변수들
		
		 int rowSize = 10;				//게시물 숫자 
		 int from = (pageNumber * rowSize) - (rowSize-1); //(1*10)-(10-1)=10-9=1 //from
		 int to=(pageNumber * rowSize); //(1*10) = 10 //to
		
		 int total = bdao.getTotal(); //총 게시물 수
		 int allPage = (int) Math.ceil(total/(double)rowSize); //총 페이지수
		 //int totalPage = total/rowSize + (total%rowSize==0?0:1);
		 int block = 10; //한페이지에 보여줄  범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] >>
		 System.out.println("전체 페이지수 : "+allPage);
		 System.out.println("현제 페이지 : "+ pageNumber);
		 
		 	int fromPage = ((pageNumber-1)/block*block)+1;  //보여줄 페이지의 시작
		    int toPage = ((pageNumber-1)/block*block)+block; //보여줄 페이지의 끝
		    if(toPage> allPage){ // 예) 20>17
		        toPage = allPage;
		    }
		    System.out.println("페이지시작 : "+fromPage+ " / 페이지 끝 :"+toPage); 
	%>


	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class
					="icon-bar"></span>
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회</th>
					</tr>
				</thead>
				<tbody>
					<%-- <%
						BoardDAO bdao = new BoardDAO();

						ArrayList<BoardVO> blist = bdao.getList(pageNumber);
						--%>
				<%		
					for (int i = 0; i < blist.size(); i++) {
						%>
						<tr>
							<%-- <td><%=blist.get(i).getB_id() %></td> --%>
							<td><%=bdao.getTotal()-i -(pageNumber - 1)*10%></td>
							<!-- 고쳐야함 -->
							<td><a href="viewAction.do?b_id=<%=blist.get(i).getB_id()%>">
								<%=blist.get(i).getTitle()%></a></td>
							<td><%=blist.get(i).getNickname()%></td>
							<td><%=blist.get(i).getDay()%></td>
							<td><%=blist.get(i).getHits()%></td>
						</tr>
						
					<%
						}
					%> 
				</tbody>
			</table>
		
		
					
			<%
				if (pageNumber != 1) {
			%>
			<a href="bbsAction.do?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
				if (bdao.nextPage(pageNumber + 1)) {
					if(bdao.getTotal() > 10){
			%>
			<a href="bbsAction.do?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">다음</a>
			<%
					}
				}
			%> 	
			<a href="write.jsp" class="btn btn-primary pull-right">글 작성</a>
		</div>
		
		
		<!-- <table width="600"> -->
		<div class="container">
				<div class="row">
					<table class="table table-striped"
						style="text-align: center; /* border: 1px solid #dddddd */">
		
					<tr>
   						 <td align="center">
        <%
            if(pageNumber>block){ //처음, 이전 링크
        %>
                [<a href="bbsAction.do?pageNumber=1">◀◀</a>]
                [<a href="bbsAction.do?pageNumber=<%=fromPage-1%>">◀</a>]    
        <%     
            }else{
        %>             
                [<span style="color:gray">◀◀</span>]   
                [<span style="color:gray">◀</span>]
        <%
            }
        %>
        <%
            for(int i=fromPage; i<= toPage; i++){
                if(i==pageNumber){
        %>         
                    [<%=i%>]
       
        <%     
                }else{
        %>
                    [<a style="color:blue" href="bbsAction.do?pageNumber=<%=i%>" ><%=i%></a>]
        <%
                }
            }
        %>
        <%
            if(toPage<allPage){ //다음, 이후 링크
        %>
                [<a href="bbsAction.do?pageNumber=<%=toPage+1%>">▶</a>]
                [<a href="bbsAction.do?pageNumber=<%=allPage%>">▶▶</a>]     
        <%     
            }else{
        %>                 
                [<span style="color:gray">▶</span>]
                [<span style="color:gray">▶▶</span>]
        <%
            }
        %>
       
    </td>
</tr>
</table>
</div>
</div>


	</div>



	<script src="js/jquery-3.4.1.js"></script>
	<script src="bootstrap/js/bootstrap.js"></script>
	
			<!-- 페이징 처리 부분-->
		<%-- 	<c:if test="${count > 0}">
				<c:set var="pageCount" --%>
					<%-- value="${count / pageSize + ( count % pageSize == 0 ? 0 : 1)}" /> --%>
		<%-- 			value="${pageCount}" />
				<c:set var="startPage" value="${pageGroupSize*(numPageGroup-1)+1}" />
				<c:set var="endPage" value="${startPage + pageGroupSize-1}" />

				<c:if test="${endPage > pageCount}">
					<c:set var="endPage" value="${pageCount}" />
				</c:if>

				<c:if test="${numPageGroup > 1}">
					<a href="bbsAction.do?pageNumber=${(numPageGroup-2)*pageGroupSize+1 }">[이전]</a>
				</c:if>


				<c:forEach var="i" begin="${startPage}" end="${endPage}">
					<a href="bbsAction.do?pageNumber=${i}">[ <font color="#000000" > 
						<c:if test="${currentPage == i}">
							<font color="#bbbbbb" >
						</c:if> ${i} </font>]
					</a>
				</c:forEach>
				


				<c:if test="${numPageGroup < pageGroupCount}">
					<a href="bbsAction.do?pageNumber=${numPageGroup*pageGroupSize+1}">[다음]</a>
				</c:if>
			</c:if> --%>

</body>
</html>