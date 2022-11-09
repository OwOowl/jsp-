<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2022-11-04
  Time: 오전 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>

    <!-- CSS only -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <script>
        $(document).ready(function() {
            $(`#btn-cal1`).on('click', function() {
                let num1 = $(`#num1`).val();
                let num2 = $(`#num2`).val();
                // num1 = Number(num1);
                // num2 = Number(num2);
                let result = sum(num1, num2);

                $(`#result`).val(result);
            });

            $(`#btn-cal2`).on('click', function () {
                let num1 = $(`#num1`).val();
                let num2 = $(`#num2`).val();

                $.ajax({
                    url: "debugTest_process2.jsp",
                    type: "post",
                    data: {num1: num1, num2: num2},
                    success: function(data) {
                        data = JSON.parse(data);
                        alert('두 수의 합은 : ' + data.result);
                    },
                    error: function() {
                        alert('통신 실패');
                    }
                });

                alert('ajax 부분 실행 후 동작하는 alert창');
            });
        });

            function sum(sum1, sum2) {
                result = 0 ;

                num1 = Number(num1);
                num2 = Number(num2);
                result = num1 + num2;

                return result;
            }

    </script>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-6 mx-auto">
            <form method="get">
                <div class="my-3">
                    <label for="num1" class="form-label">첫 번째 숫자 : </label>
                    <input type="text" class="form-control" id="num1" name="number1" value="">
                </div>
                <div class="my-3">
                    <label for="num2" class="form-label">두 번째 숫자 : </label>
                    <input type="text" class="form-control" id="num2" name="number2" value="">
                </div>
                <div class="d-grid gap-3 my-3">
                    <button class="btn btn-primary" type="submit" id="btn-cal1">일반 계산</button>
                    <button class="btn btn-success" type="button" id="btn-cal2">ajax를 사용한 계산</button>
                </div>
                <hr>
                <div class="my-3">
                    <label for="result" class="form-label">계산 결과 : </label>
                    <input type="text" class="form-control" id="result" name="result" value="">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
