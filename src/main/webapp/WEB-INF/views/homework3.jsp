<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homework2</title>
    <style>
        .page-title{
            text-align:center;
        }
        .container{
            width:750px;
            margin:0 auto;
        }

    </style>
</head>
<body>
<h2 class="page-title">Homework3 - Database</h2>
    <section class="container">
        <ol>
            <li><p>정국의 1월(#JanEarnings) 오프라인 영업실적 중 1건 초과되는 건들의 이름 ,날짜 ,카운트 출력</p>
                <h3>SELECT MEMBER_ID, SALES_DATE, SALES_COUNT
                FROM JANEARNINGS
                WHERE MEMBER_ID IN ('00002', '00005') AND SALES_CODE = 1 AND SALES_COUNT > 1;</h3></li>
            <li><p>정국의 1월(#JanEarnings) 오프라인 영업실적 총 건수 출력</p>
                <h3>SELECT SUM(SALES_COUNT) AS TOTAL_SALES_COUNT
                FROM JANEARNINGS
                WHERE MEMBER_ID IN ('00002', '00005') AND SALES_CODE = 1;</h3></li>
            <li><p>1월 한달 일자별로 영업 건수를 출력( 0건은 0으로 표시)</p>
                <h3>SELECT SALES_DATE, SUM(SALES_COUNT) AS SALES_COUNT
                FROM JANEARNINGS
                GROUP BY SALES_DATE ORDER BY SALES_DATE;</h3></li>
        </ol>
    </section>

<script></script>
</body>
</html>
