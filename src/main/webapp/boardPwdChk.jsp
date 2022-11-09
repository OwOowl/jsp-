<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-04
  Time: 오후 3:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.google.gson.Gson" %>
>

<%@ include file="dbconn.jsp"%>

<%-- 자바스크립트를 이용한 비밀번호 체크 --%>
<%
    int idx = Integer.parseInt(request.getParameter("idx"));
    String pwd = request.getParameter("pwd");
    int count = 0;

    PreparedStatement pstmt = null;
    ResultSet rs = null;

//    pwd가 맞으면 1, 틀리면 0을 받음
    String query = "SELECT count(pwd) as cnt FROM t_board WHERE idx = ? AND pwd = ? ";

    try {
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, idx);
        pstmt.setString(2, pwd);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            count = rs.getInt("cnt");
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

    Map<String, String> map = new HashMap<>();
    Gson gson = new Gson();

    if(count == 1) {
        map.put("result", "success");
        map.put("value", "1");
    }
    else {
        map.put("result", "error");
        map.put("value", "0");
    }

    out.print(gson.toJson(map));

    response.sendRedirect("boardList.jsp");
%>
