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
    <title>글 수정 페이지</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
    <script>
        $(document).ready(function() {
            $(`#btn-back`).on('click', function() {
                history.back();
            });

            $(`#btn-update`).on('click', function() {
                $(`#frm`).attr("action", "boardUpdate_process.jsp");
                $(`#frm`).attr("method", "post");
            });

            $(`#btn-delete`).on('click', function() {
                $(`#frm`).attr("action", "boardDelete_process.jsp");
                $(`#frm`).attr("method", "get");
                     // 자바스크립트를 이용한 비밀번호 확인
                let datas = {idx: $(`#idx`).val(), pwd: $(`#pwd`).val()};
                // $.ajax({
                //     url: "boardPwdChk.jsp",
                //     type: "post",
                //     data: datas,
                //     success: function(data) {
                //         data = JSON.parse(data);
                //
                //         if(data.result == 'success') {
                //             const frm = $(`#frm`);
                //             frm.submit();
                //
                //             else {
                //                 alert('비밀번호가 틀렸습니다.');
                //             }
                //         }
                //     },
                //     error: function() {
                //         alert('통신 오류');
                //     }
                // });
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
    String pwd = request.getParameter("pwd");

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try{
        String sql = "SELECT idx, title, user_id, hit_cnt, create_dt, update_dt, contents FROM t_board WHERE idx = ? ";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idx);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            title = rs.getString("title");
            userId = rs.getString("user_id");
            hitCnt = rs.getInt("hit_cnt");
            contents = rs.getString("contents");
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
    <form action="" method="" id="frm">
        <div class="mx-auto row">
<%--    글번호--%>
            <div class="my-3 col-sm-1">
                <label for="idx" class="form-label">글번호</label>
                <input type="text" class="form-control text-center" id="idx" name="idx" value="<%=idx%>" disabled>
            </div>
<%--    글제목--%>
            <div class="my-3 col-sm-11">
                <label for="title" class="form-label">글제목</label>
                <input type="text" class="form-control" id="title" name="title" value="<%=title%>">
            </div>
<%--    작성자--%>
            <div class="my-3 ms-auto col-sm-2 ">
                <label for="user-id" class="form-label">작성자</label>
                <input type="text" class="form-control text-center" id="user-id" name="userId" value="<%=userId%>" disabled>
            </div>
<%--    비밀번호--%>
            <div class="my-3 col-sm-1">
                <label for="pwd" class="form-label">pwd</label>
                <input type="password" class="form-control" id="pwd" name="pwd" value="">
            </div>
<%--    작성날짜--%>
            <div class="my-3 col-sm-8">
                <label for="create-dt" class="form-label">등록 날짜</label>
                <input type="text" class="form-control" id="create-dt" name="createDt" value="<%=createDt%>" disabled>
            </div>
<%--    조회수--%>
            <div class="my-3 col-sm-1">
                <label for="hit-cnt" class="form-label">조회수</label>
                <input type="text" class="form-control text-center" id="hit-cnt" name="hitCnt" value="<%=hitCnt%>" disabled>
            </div>
<%--    내용--%>
            <div class="my-3">
                <label for="contents" class="form-label m">내용</label>
                <textarea class="form-control" rows="10" id="contents" name="contents"><%=contents%></textarea>
            </div>
<%--    버튼 --%>
            <div class="col-sm d-flex justify-content-start my-3">
                <button class="btn btn-secondary" type="button" id="btn-back">뒤로</button>
            </div>
            <div class="col-sm d-flex justify-content-end my-3">
                <button class="btn btn-warning me-3" id="btn-update">글 수정</button>
                <button class="btn btn-danger"  id="btn-delete">글 삭제</button>
                <input type="hidden" name="idx" value="<%=idx%>">
            </div>
        </div>
    </form>
</main>

<%@ include file="footer.jsp"%>
</body>
</html>
