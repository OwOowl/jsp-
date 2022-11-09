<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오후 2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%@ include file="dbconn.jsp"%>
<%
    request.setCharacterEncoding("utf-8");

    String title = request.getParameter("title");
    String userId = request.getParameter("userId");
    String contents = request.getParameter("contents");
    String userPwd = request.getParameter("pwd");


    PreparedStatement pstmt = null;
    String sql = "INSERT INTO t_board (title, contents, user_id, pwd, create_dt) VALUES (? ,? ,? ,? ,now()) ";

    try {
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, contents);
        pstmt.setString(3, userId);
        pstmt.setString(4, userPwd);
        pstmt.executeUpdate();
    }
    catch (SQLException e) {
        out.println("SQLException : " + e.getMessage());
    }
    finally {
        if(pstmt != null) { pstmt.close(); }
        if(conn != null) { conn.close(); }
    }
    response.sendRedirect("boardList.jsp");
%>
