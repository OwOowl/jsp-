<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-03
  Time: 오전 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>글쓰기 페이지</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <script>
        $(document).ready(function () {
            $(`#btn-write`).on(`click`, function () {
                const frm = $(`#frm`);
                if ($(`#title`).val() == '') {
                    alert('제목을 입력하세요');
                }
                else if ($(`#user-id`).val() == '') {
                    alert('아이디를 입력하세요');
                }
                else if ($(`#pwd`).val() == '') {
                    alert('비밀번호를 입력하세요');
                }
                else {
                    frm.submit();
                }
            });

            $(`#btn-list`).on(`click`, function () {
                history.back();
            });
        });
    </script>
</head>
<body>
<%@ include file="Header.jsp"%>
<% request.setCharacterEncoding("utf-8"); %>

<main class="container">
    <div class="col-sm-6 mx-auto">
        <form action="boardWrite_process.jsp" method="post" id="frm">
            <div class="row">
                <div class="my-3">
                    <label for="title" class="form-label">글제목</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
                </div>
                <div class="my-3 col-sm-6">
                    <label for="user-id" class="form-label">작성자</label>
                    <input type="text" class="form-control" id="user-id" name="userId" placeholder="작성자를 입력하세요">
                </div>
                <div class="my-3 col-sm-6">
                    <label for="pwd" class="form-label">pwd</label>
                    <input type="password" class="form-control" id="pwd" name="pwd" value="1234">
                </div>
                <div class="my-3">
                    <label for="contents" class="form-label">내용</label>
                    <textarea class="form-control" rows="10" id="contents" name="contents" placeholder="내용을 입력하세요."></textarea>
                </div>
                <%--        버튼 --%>
                <div class="col-sm d-flex justify-content-start my-3">
                    <button class="btn btn-secondary" type="button" id="btn-list">목록으로</button>
                </div>
                <div class="col-sm d-flex justify-content-end my-3">
                    <button class="btn btn-primary" type="button" id="btn-write">글쓰기</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</main>

<%@ include file="footer.jsp"%>
</body>
</html>
