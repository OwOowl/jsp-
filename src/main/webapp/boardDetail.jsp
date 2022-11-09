<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오전 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>상세 페이지</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
    <script>
        $(document).ready(function (){
            $(`#btn-list`).on('click', function() {
                history.back();
            });

        });
    </script>
</head>
<body>
<%@ include file="dbconn.jsp"%>

<%
    request.setCharacterEncoding("utf-8");
    String title = "";
    String userId = "";
    String contents = "";
    String createDt = "";
    String updateDt = "";
    int hitCnt = 0;
    int idx = Integer.parseInt(request.getParameter("idx"));

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String sql = "update t_board set hit_cnt = hit_cnt + 1 where idx = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, idx);
    pstmt.executeUpdate();


    sql = "SELECT title, user_id, contents, hit_cnt, create_dt, update_dt FROM t_board WHERE idx = ? ";

    try{
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();

        while(rs.next()) {
            title = rs.getString("title");
            userId = rs.getString("user_id");
            contents = rs.getString("contents");
            hitCnt = rs.getInt("hit_cnt");
            createDt = rs.getString("create_dt");
            updateDt = rs.getString("update_dt");
            if(updateDt != null) {
                createDt= createDt + " / 수정날짜 : " + updateDt;
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

<%@ include file="Header.jsp"%>

<main class="container">
    <div class="mx-auto row">
<%--        글번호--%>
        <div class="my-3 col-sm-1">
            <label for="idx" class="form-label">글번호</label>
            <input type="text" class="form-control text-center" id="idx" name="idx" readonly value="<%=idx%>">
        </div>
<%--    제목--%>
        <div class="my-3 col-sm-11">
            <label for="title" class="form-label">글제목</label>
            <input type="text" class="form-control"  id="title" name="title" readonly value="<%=title%>">
        </div>
<%--    작성자--%>
        <div class="my-3 ms-auto col-sm-2 ">
            <label for="user-id" class="form-label">작성자</label>
            <input type="text" class="form-control text-center" id="user-id" name="userId" readonly value="<%=userId%>">
        </div>
<%--    등록 날짜--%>
        <div class="my-3 col-sm-9">
            <label for="create-dt" class="form-label">등록날짜</label>
            <input type="text" class="form-control" id="create-dt" name="createDt" readonly value="<%=createDt%>">
        </div>
<%--    조회수--%>
        <div class="my-3 col-sm-1">
            <label for="hit-cnt" class="form-label">조회수</label>
            <input type="text" class="form-control text-center" id="hit-cnt" name="hitCnt" readonly value="<%=hitCnt%>">
        </div>
<%--    내용--%>
        <div class="my-3">
            <label for="contents" class="form-label">내용</label>
            <textarea class="form-control" rows="10" id="contents" name="contents" readonly rows="3"><%=contents%></textarea>
        </div>
<%--    버튼--%>
        <div class="col-sm d-flex justify-content-start my-3">
            <button class="btn btn-secondary" type="button" id="btn-list">목록으로</button>
        </div>
        <div class="col-sm d-flex justify-content-end my-3">
            <a href="boardUpdate.jsp?idx=<%=idx%>" class="btn btn-warning" id="btn-update">수정</a>
        </div>
    </div>
</main>

<%@ include file="footer.jsp"%>
</body>
</html>