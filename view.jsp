<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WordPress 사용자 로그 </title>
</head>
<body>
<caption>Activity Log Viewer 테이블의 내용</caption>
<table width="100%" border="1">
	<thead>
		<tr>
			<td width=50><p align=center>uactid</p></td>
			<td width=50><p align=center>post_id</p></td>
			<td width=50><p align=center>post_title</p></td>
			<td width=50><p align=center>user_id</p></td>
                  <td width=50><p align=center>user_name</p></td>
			<td width=50><p align=center>user_role</p></td>
                  <td width=50><p align=center>user_email</p></td>
                  <td width=50><p align=center>ip_address</p></td>
                  <td width=50><p align=center>modified_date</p></td>
                  <td width=50><p align=center>object_type</p></td>
                  <td width=50><p align=center>action</p></td>
		</tr>
	</thead>
	<tbody>
	<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String jdbcDriver = "jdbc:mysql://[ip address]/wordpress";
			String dbUser = "wordpress";
			String dbPwd = "wordpress";
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
			
			pstmt = conn.prepareStatement("select * from wp_ualp_user_activity");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
	%>
		<tr>
			<td><%=rs.getInt("uactid")%></td>
			<td><%=rs.getInt("post_id")%></td>
			<td><%=rs.getString("post_title")%></td>
			<td><%=rs.getString("user_id")%></td>
			<td><%=rs.getString("user_name")%></td>
			<td><%=rs.getString("user_role")%></td>
			<td><%=rs.getString("user_email")%></td>
			<td><%=rs.getString("ip_address")%></td>
      <td><%= rs.getTimestamp("modified_date") %></td>
			<td><%=rs.getString("object_type")%></td>
			<td><%=rs.getString("action")%></td>

		</tr>
	<%
			}
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
	%>
	</tbody>
</table> 
</body>
</html>
