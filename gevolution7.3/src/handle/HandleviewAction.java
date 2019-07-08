package handle;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardDAO;
import board.BoardVO;
import member.MemberDAO;

public class HandleviewAction implements HandleImpl {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter script = response.getWriter();
		HttpSession session = request.getSession();

		BoardDAO bdao = null;
		BoardVO board = null;
		MemberDAO mdao = null;
		
		

		String id =null;		//회원 아이디
		int b_id = 0; 	//게시판 아이디
		
		if(session.getAttribute("id") != null){
			id = (String)session.getAttribute("id");
		}

		// 로그인 안되있다면
				if (id == null) {
					script.println("<script>");
					script.println("alert('로그인을 하세요')");
					script.println("location.href='login.jsp'");
					script.println("</script>");
				} 
				
				
		if(request.getParameter("b_id") != null){
			b_id = Integer.parseInt(request.getParameter("b_id"));
			System.out.println("보드 아이디 : " +b_id);
			System.out.println("회원 아이디 : " +id);
		}
		
		//가져온 글이 없는 경우 bbs페이지로 이동
		if(b_id ==0){
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		try {
			bdao = new BoardDAO();
			board = new BoardVO();
			board = bdao.getBoard(b_id);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(board.getB_id());
		System.out.println(board.getTitle());
		System.out.println(board.getDay());
		System.out.println(board.getNickname());
		
		request.setAttribute("board", board);

	}

}
