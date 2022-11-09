<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-04
  Time: 오전 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%
  String fileName = request.getServletPath();
  fileName = fileName.substring(1);
  String boardTitle = "";


  switch(fileName) {
    case "boardList.jsp" :
      boardTitle = "게시판 목록 페이지";
      break;

    case "boardWrite.jsp" :
      boardTitle = "글 등록 페이지";
      break;

    case "boardDetail.jsp" :
      boardTitle = "상세 글 확인 페이지";
      break;

    case "boardUpdate.jsp" :
      boardTitle = "글 수정 페이지";
      break;
  }
%>

<header class="bg-light">
  <div class="container p-5 mb-3 ">
    <h1 class="text-center fw-bold m-5"><%=boardTitle%></h1>
  </div>
</header>