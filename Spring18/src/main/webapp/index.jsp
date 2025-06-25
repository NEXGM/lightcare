<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	div{
		text-align: center;
	}
	table {
		margin:100px auto;
		border:1px solid black;
		border-collapse: collapse;
		text-align:center;
	}
	td,tr{
		margin: 0; padding: 0;
		border: 1px solid black;
	}
	input {
		margin: 0;
	}

</style>
</head>
<body align="center">
	<%@include file="/WEB-INF/views/common/Header.jsp"  %>
	<h1>게시판 프로그램</h1>
	<br>
	
	<a href="login.do">로그인</a>    <!-- GET방식 -->
	<%@include file="/WEB-INF/views/common/Footer.jsp"  %>
</body>
</html>





