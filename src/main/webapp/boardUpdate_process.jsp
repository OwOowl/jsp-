<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오후 12:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");

    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    String userId = request.getParameter("userId");
    int idx = Integer.parseInt(request.getParameter("idx"));
    String pwd = request.getParameter("pwd");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try{
        String sql = "SELECT pwd FROM t_board WHERE idx=? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            String rpwd =rs.getString("pwd");

            if(pwd.equals(rpwd)) {
                sql = "UPDATE t_board SET title = ?, contents = ?, user_id = ?, update_dt = now() WHERE idx = ? ";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, title);
                pstmt.setString(2, contents);
                pstmt.setString(3, userId);
                pstmt.setInt(4, idx);
                pstmt.executeUpdate();

                response.sendRedirect("boardList.jsp");
            }
            else {
                out.println("비밀번호가 틀렸습니다.");
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