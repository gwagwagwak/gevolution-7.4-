package board;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dbconn.DBconn;

public class BoardDAO {
	private Connection con;
	/*PreparedStatement pstmt = null;*/
	ResultSet rs = null;
	
	
	//DB 연결
	public BoardDAO() throws ClassNotFoundException, SQLException {
		con = new DBconn().getConnection();
	}
	
	
	
	public int writeBoard(String title, String nickname, String content, String b_type) {
		
		String sql = "insert into board values(board_sequence1.NEXTVAL, ?, ?, ?, to_char(SYSDATE, 'yy-mm-dd hh24:mi'), 0, '', ?, '')";
		try {
		/*	ResultSet rs = null;
			PreparedStatement pstmt = null;*/
			PreparedStatement pstmt = con.prepareStatement(sql);

			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, nickname);
			pstmt.setString(4, b_type);
			return pstmt.executeUpdate();	//정상 완료되면 1을 반환
			}
		 catch(SQLException e) {
			e.printStackTrace();
		}
		return -1; //db오류 
	}
	
	//다음에 작성될 글번호 생성 함수
		public int getNext() {
			
			String sql = "select b_id from board order by b_id desc";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = null;
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //첫번째 게시물인 경우 1을 반환
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return -1; //db오류 
		}
		

		//다음 페이지 번호 구하기
		public boolean nextPage(int pageNumber) {
			
			String sql = "select * from board where b_id < ?" ;
			try {
				
				PreparedStatement pstmt =  con.prepareStatement(sql);
				
				pstmt.setInt(1, getNext() - (pageNumber -1)*10);
				rs = pstmt.executeQuery();
				
				//결과가 하나라도 존재한다면 다음페이지로 넘어갈 수 있음을 보여줌
				if(rs.next()) {
					return true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return false; 
		}
		
		
		/*
		//다음에 작성될 글번호 생성 함수
			public int getNext() {
				
				String sql = "select count(*) as totalCount from board";
				try {
					PreparedStatement pstmt = con.prepareStatement(sql);
					ResultSet rs = null;
					PreparedStatement pstmt = null;
					rs = pstmt.executeQuery();
					if(rs.next()) {
						return rs.getInt(1) + 1;
					}
					return 1; //첫번째 게시물인 경우 1을 반환
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return -1; //db오류 
			}
		*/
			
			//게시물 가져오기(mysql)
			/* public ArrayList<BoardVO> listBoard(int begin, int end){
			       
			        ArrayList<BoardVO> list = new ArrayList<BoardVO>();
			       
			        Connection con = null;
			        PreparedStatement ps = null;
			        ResultSet rs = null;
			       
			        //String sql = "select * from board order by num desc";
			        String sql = "select rn, num,name,email,pwd,subject,content,regdate,hit,parent,sort,tab " +
			                "  from (select " +
			                "  Rownum as rn, num,name,email,pwd,subject,content,regdate,hit,parent,sort,tab " +
			                "  from(    " +
			                "        select num,name,email,pwd,subject,content,regdate,hit,parent,sort,tab  " +
			                "        from board " +
			                "        order by parent desc,sort desc " +  //기본값 오름 차순
			                "        )" +
			                "    )" +
			                "where RN >=? and RN <=?";
			        System.out.println(sql);
			       
			        try {
			           
			            con = getCon();
			            ps = con.prepareStatement(sql);
			            ps.setInt(1, begin);
			            ps.setInt(2, end);
			           
			            rs = ps.executeQuery();
			           
			            while(rs.next()) {
			               
			                BoardDTO dto = new BoardDTO();
			               
			                dto.setNum(rs.getInt("num"));
			                dto.setName(rs.getString("name"));
			                dto.setEmail(rs.getString("email"));
			                dto.setPwd(rs.getString("pwd"));
			                dto.setSubject(rs.getString("subject"));
			                dto.setContent(rs.getString("content"));
			                dto.setRegdate(rs.getDate("regdate"));
			                dto.setHit(rs.getInt("hit"));
			                dto.setParent(rs.getInt("parent"));
			                dto.setSort(rs.getInt("sort"));
			                dto.setTab(rs.getInt("tab"));
			               
			                list.add(dto);
			            }
			           
			        } catch (Exception e) {
			            e.printStackTrace();
			        }finally {
			            dbClose(con, ps, rs);
			        }
			       
			       
			        return list;
			       
			       
			    }*/
	
/*			 
	//게시판 한페이지에 출력할 열개 페이지 가져오기 
	public ArrayList<BoardVO> getList(int pageNumber){
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		
		
		String sql = "select * from(select * from board where b_id < ? order by b_id DESC) where rownum<=10";
		//String sql = "select * from(select * from board where b_id < ? order by b_id DESC) where rownum<=10";
		String sql = "select * from(select * from board order by b_id DESC) where rownum<=10 and rownum >=2";
		//String sql = "select * from board where b_id < ? AND ROWNUM <= 10 order by b_id DESC";
		ArrayList<BoardVO> blist = new ArrayList<>();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();		//에러.....
			
			System.out.println("db에러 발생1");
			System.out.println(pageNumber);
			System.out.println(getNext() - (pageNumber -1)*10);
			
			while(rs.next()) {
				BoardVO b1 = new BoardVO();
				System.out.println("b_id :"+rs.getInt(1));
				System.out.println("b_id :"+rs.getString(2));
				
				
				
				b1.setB_id(rs.getInt(1));
				//System.out.println("db에러 발생2");
				
				b1.setTitle(rs.getString(2));		//에러...
				//System.out.println("db에러 발생2");
				b1.setContent(rs.getString(3));
				//System.out.println("db에러 발생2");
				b1.setNickname(rs.getString(4));
				//System.out.println("db에러 발생2");
				b1.setDay(rs.getString(5));
				b1.setHits(rs.getInt(6));
				b1.setComment(rs.getString(7));
				b1.setB_type(rs.getString(8));
				b1.setGame_name(rs.getString(9));
				
				blist.add(b1);
				//System.out.println("db에러 발생3");
			}
		//	System.out.println("db에러 발생4");
		} catch (SQLException e) {
			e.printStackTrace();
			//System.out.println("db에러 발생5");
		}
		return blist; 
	}*/

	
		
		
			//게시판 한페이지에 출력할 열개 페이지 가져오기 
	public ArrayList<BoardVO> getList(int begin, int end){

		String sql = "select * from(select ROW_NUMBER() over(order by b_id desc)as rn, board.* from board) where rn >= ? and rn <=?;";
	
		ArrayList<BoardVO> blist = new ArrayList<>();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, begin);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();		
			
			while(rs.next()) {
				BoardVO b1 = new BoardVO();
			
				b1.setB_id(rs.getInt(2));
				//System.out.println("db에러 발생2");
				b1.setTitle(rs.getString(3));		//에러...
				//System.out.println("db에러 발생2");
				b1.setContent(rs.getString(4));
				//System.out.println("db에러 발생2");
				b1.setNickname(rs.getString(5));
				//System.out.println("db에러 발생2");
				b1.setDay(rs.getString(6));
				b1.setHits(rs.getInt(7));
				b1.setComment(rs.getString(8));
				b1.setB_type(rs.getString(9));
				b1.setGame_name(rs.getString(10));
				
				blist.add(b1);
			}
			System.out.println("리스트 생성 완료");
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return blist; 
	}
	
	

	//게시판 총 갯수 구해오기
		public int getTotal() {
			String sql = "select count(*) as totalCount from board";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1);}
			}catch(Exception e) {
				e.printStackTrace();}
			return -1;	//db오류
		}
		
		
	
	//게시판 내용 하나 불러오기(view.jsp)
	public BoardVO getBoard(int b_id) {

		String sql = "select * from board where b_id=?" ;
		try {
			PreparedStatement pstmt =  con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			rs = pstmt.executeQuery();
			//결과가 하나라도 존재한다면 다음페이지로 넘어갈 수 있음을 보여줌
			if(rs.next()) {
				BoardVO b1 = new BoardVO();
				//System.out.println("db에러 발생1");
				b1.setB_id(rs.getInt(1));
				//System.out.println("db에러 발생2");
				b1.setTitle(rs.getString(2));		//에러...
				//System.out.println("db에러 발생3");
				b1.setContent(rs.getString(3));
				//System.out.println("db에러 발생4");
				b1.setNickname(rs.getString(4));
				//System.out.println("db에러 발생5");
				b1.setDay(rs.getString(5));
				b1.setHits(rs.getInt(6));
				b1.setComment(rs.getString(7));
				b1.setB_type(rs.getString(8));
				b1.setGame_name(rs.getString(9));
				
				System.out.println("getBoard()완료");
				return b1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null; 
		
	}
	
	public int update(int b_id, String title, String content) {
		String sql = "update board set title =?, content=? where b_id=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, b_id);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//DB오류
		
	}
	
	
	public int delete(int b_id) {
		String sql = "delete from board where b_id=?";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//DB오류
	}
	
	
	
	
	

	
	/*
		
		//페이징 처리(1,2,3,4,5...)
		public int paging(int pageNumber) {
			
			return pageNumber;
			
		}*/
	
	

	/*
	public void pstmtClose() throws SQLException {
		PreparedStatement pstmt = null;
		if(pstmt != null) {
			pstmt.close();
		}
	}
	*/
	/*
	public void getAllInfoClose() throws SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		if(rs != null) {
			rs.close();
		}
		if(pstmt != null) {
			
			pstmt.close();
		}
		if(con != null) {
			con.close();
		}
	}
	*/
	
	//현재 시간 가져오기
	/*public String getDate() {
		sql = "select now()";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ""; //db오류 전송
	}*/
	
	/*
	//모든 회원 정보 가져오기
	public ArrayList<TelInfoVO> getAllInfo() throws SQLException{
		ArrayList<TelInfoVO> tiarray = new ArrayList<TelInfoVO>();
		String sql = "SELECT * FROM TelTable5 ORDER BY id";
		
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int id = rs.getInt("id");
			String name = rs.getString("name");
			String tel = rs.getString("tel");
			Date d = rs.getDate("d");
			
			TelInfoVO tiv = new TelInfoVO(id, name, tel, d);
			
			tiarray.add(tiv);
		}
		
		return tiarray;
	}*/
	
	
	
	
	
	/*
	//새로운 전화번호 및 수정대상 사원이름은 jsp로부터 온다.
	public boolean update_nametel(String tel2, String name2) throws SQLException {
		//수정은 이름조건에 대하여 전화번호만 수정, 그리고 DB테이블로 저장된다.
		String sql ="update TelTable5 set tel=? where name=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, tel2);
		pstmt.setString(2, name2);
		pstmt.executeUpdate();
		
		return true;
	}*/
	
	/*
	//정보 수정
	public boolean update_all(int id1, String name1, String tel1, String d, String sname) throws SQLException {
		String sql ="update TelTable5 set id=?, name=?, tel=?, d=TO_DATE(?,'YYYY-MM-DD') where name=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id1);
		pstmt.setString(2, name1);
		pstmt.setString(3, tel1);
		pstmt.setString(4, d);
		pstmt.setString(5, sname);
		
		pstmt.executeUpdate();
		
		return true;
	}*/
	
	
	/*
	//사원 한명 정보 가져오기
	public TelInfoVO getInfo(String name1) throws SQLException {
		TelInfoVO tv = null;
		String sql = "select * from teltable5 where name = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name1);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			int id = rs.getInt(1);
			String name = rs.getString(2);
			String tel = rs.getString(3);
			Date d = rs.getDate(4);
			tv = new TelInfoVO(id,name,tel,d);
		}else {
			tv = null;
		}
		return tv;
	}*/
	
	/*
	//게시판 글쓰기
	public boolean insert_nametel(int id, String name, String tel, String d) throws SQLException {
		String sql = "INSERT into TelTable5 values(?,?,?,?)";
			
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, tel);
		
		int year = Integer.parseInt(d.substring(0, 4)) - 1900;
		int month = Integer.parseInt(d.substring(4, 6)) -1;
		int day = Integer.parseInt(d.substring(6, 8));
		Date date = new Date(year, month, day);
		pstmt.setDate(4, date);
		
		pstmt.executeUpdate();
		
		return true;
	}*/	
	
	
	
	/*	
	//게시물 삭제
	public boolean delete_nametel(String name) throws SQLException {
		String sql = "DELETE TelTable5 WHERE name = ?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.executeUpdate();
		return true;
	}*/
	
	
	
	
}
