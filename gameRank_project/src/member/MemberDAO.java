package member;

import dbconn.DBconn;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*import com.sun.java.util.jar.pack.Package.Class.Member;*/

public class MemberDAO {
	private Connection con;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//DB 연결
	public MemberDAO() throws ClassNotFoundException, SQLException {
		con = new DBconn().getConnection();
	}
	
	
	public void pstmtClose() throws SQLException {
		if(pstmt != null) {
			pstmt.close();
		}
	}
	
	public void getAllInfoClose() throws SQLException {
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
	
	
	//로그인 메서드(id, pw)
	public int login(String userID, String userPassword) {
		String sql = "SELECT pw FROM member where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	//rs에 결과값이 있다면 next()가 ㅅ겯
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				} 
				else 
					return 0; //비밀번호 불일치 
			}
			return -1;		//id가 없는 경우 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;	//DB 오류
	}
	
	
	//회원가입 메서드 ( id_no, id, pw,  
	public int join(MemberVO member) {
		String sql = "insert into member values(member_sequence1.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPw());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getNickname());
			pstmt.setString(5, member.getGender());
			pstmt.setInt(6, member.getAge());
			pstmt.setString(7, member.getPhone());
			pstmt.setString(8, member.getEmail());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; //DB오류  	
	}
	
	
	//닉네임 검색 함수
	public String getNickuseid(String id) {
		String sql = "select nickname from member where id=?";
		String nick=null;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nick = rs.getString(1);
			
			}else { //오류날 경우 빈값 반환
				return "";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return nick;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
