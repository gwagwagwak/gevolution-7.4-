package frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import handle.HandleImpl;
import handle.HandlebbsAction;

/**
 * Servlet implementation class Boardfrontcontroller
 */
@WebServlet("*.do")
public class gevolutionfrontcontroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public gevolutionfrontcontroller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		doHandle(request, response);
	}

	
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String ru1 = request.getRequestURI();
		String cp1 = request.getContextPath();
		String c1 = ru1.substring(cp1.length());	// /.do출력
		
		String viewpage = null; //처리해서 보내는 페이지					
		
		HandleImpl scmd1 = null;	//인터페이스 객체
		
		//인터페이스 객체  = null;
		/*
		if(c1.equals("/bbsAction.do")) {
			scmd1 = new HandlebbsAction();
		} else if(c1.equals("")) {
			
		}*/
		
		switch(c1) {
		case "/bbsAction.do":
			scmd1 = new HandlebbsAction();
			try {
				
				scmd1.handle(request, response);
				System.out.print("bbsAction 접근을 성공적으로 햇다.");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			viewpage = "bbs.jsp";
			System.out.print("viewpage접근 성공");
			break;
			
		case "/.do":
			scmd1 = new HandlebbsAction();
			try {
				scmd1.handle(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			viewpage = "bbs.jsp";
			break;
		}
		
		
		RequestDispatcher rd1 = request.getRequestDispatcher(viewpage);
		rd1.forward(request, response);
		
	}
	
	
	

}
