<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오전 11:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp"%>

<%
    int idx = Integer.parseInt(request.getParameter("idx"));
    String pwd = request.getParameter("pwd");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "SELECT pwd FROM t_board WHERE idx = ? ";

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            String rpwd = rs.getString("pwd");

            if(pwd.equals(rpwd)) {
                sql = "UPDATE t_board SET deleted_yn = 'Y' WHERE idx = ? ";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, idx);
                pstmt.executeUpdate();
                response.sendRedirect("boardList.jsp");
            }
            else {
                out.print("비밀번호가 틀렸습니다.");
            }
        }
    }
    catch (SQLException e) {
        out.print(e.getMessage());
    }
    finally {
        if(rs != null) { rs.close(); }
        if(pstmt != null) { pstmt.close(); }
        if(conn != null) { conn.close(); }
    }


%>
