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
			margin:50px auto;
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
	<%@ include file="../common/Header.jsp" %>
	<div>
		<a href="logout.do">로그아웃</a>
		<br>
		<form action="insertBoard.do" method="post">
			<table>
				<tr>
				    <!-- 수정가능 -->
					<td width="80px">제목</td> 
					<td><input type="text" name="title"></td>
				</tr>
				<tr>
					<td width="80px">작성자</td> 
					<td><input type="text" name="writer"></td>
				</tr>
				<tr>
					<!-- 수정가능 -->
					<td width="80px">내용</td> 
					<td><textarea  name="content" cols="40" rows="10" ></textarea></td>
				</tr>
				</tr>
				<tr>
					<td colspan="2"> <!-- 두칸으로 늘린다 -->
						<input type="submit" value="새글등록">   <!-- 버튼 -->
					</td>
				</tr>
			</table>
		
		</form>
		<a href="getBoardList.do">전체목록</a>
	</div>
	<%@ include file="../common/Footer.jsp" %>
</body>
</html>