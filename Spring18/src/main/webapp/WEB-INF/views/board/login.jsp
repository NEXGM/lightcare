<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<title>로그인</title>
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
<body>
	<%@include file="../common/Header.jsp"  %>
	<div>
		<h1>로그인</h1>
		<hr>
		<form action="login.do" method="post"> <!-- 이것은 Dispatcher와 연결  -->		  
			<table >
				<tr>
					<td bgcolor="lightgray">아이디</td>
					<td><input type="text" name="id" /></td>
				</tr>
				<tr>
					<td bgcolor="lightgray">비밀번호</td>
					<td><input type="password" name="password" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="로그인" /></td>
				</tr>
			</table>
		</form>
		<hr>
	</div>
	<%@include file="../common/Footer.jsp"  %>
</body>
</html>