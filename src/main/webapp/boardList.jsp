<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오전 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시판 목록 페이지</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="dbconn.jsp"%>
<%@ include file="Header.jsp"%>
<% request.setCharacterEncoding("utf-8"); %>
<div class="container">
    <div class="row">
        <div class="col-sm">
            <table class="table table-hover table-striped">
                <thead class="text-center">
                <tr>
                    <th>글번호</th>
                    <th>글제목</th>
                    <th>글쓴이</th>
                    <th>등록날짜</th>
                    <th>조회수</th>
                </tr>
                </thead>
                <tbody class="text-center">
                <%
                    String sql = "SELECT idx, title, user_id, create_dt, hit_cnt, update_dt FROM t_board WHERE deleted_yn='N' " +
                            "ORDER BY idx DESC ";

                    Statement stmt = null;
                    ResultSet rs = null;

                    try{
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        while(rs.next()) {
                            String idx = rs.getString("idx");
                            String title = rs.getString("title");
                            String userId = rs.getString("user_id");
                            String hitCnt = rs.getString("hit_cnt");
                            String createDt = rs.getString("create_dt");
                            String updateDt = rs.getString("update_dt");

                %>
                <tr>
                    <td><%=idx%></td>
                    <td><a href="boardDetail.jsp?idx=<%=idx%>" class="nav-link"><%=title%></a></td>
                    <td><%=userId%></td>
                    <td><%=createDt%></td>
                    <td><%=hitCnt%></td>
                </tr>
                <%
                        }
                    }
                    catch (SQLException e) {
                        out.print(e.getMessage());
                    }
                    finally{
                        if(rs != null) { rs.close(); }
                        if(stmt != null) { stmt.close(); }
                        if(conn != null) { conn.close(); }
                    }
                %>
                </tbody>
            </table>
            <div class="m-4 d-flex justify-content-end">
                <a href="boardWrite.jsp" class="btn btn-primary">글쓰기</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp"%>
</body>
</html>
