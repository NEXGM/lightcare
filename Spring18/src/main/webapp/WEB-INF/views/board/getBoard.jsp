<%@page import="com.spring.biz.board.impl.BoardDAO"%>
<%@page import="com.spring.biz.common.BoardDTO"%>
<%@page import="java.util.Scanner"%>
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
<% 
	BoardDTO board = (BoardDTO)request.getAttribute("board");
%>
<body>
	
	<%@ include file="../common/Header.jsp" %>
	
	<!-- 3. 상세내역을수정할수 있도록(그럴려면 form에 넣어준다) 화면에 출력해준다 -->
	<div>
		<h1>글 상세내역</h1>
		<a href="logout.do">로그아웃</a>
		<br><br>
		<form action="updateBoard.do" method="post">
			<!-- 안보이게 한다 - 수정못하도록 -->
			<input type="hidden" name="seq" value="<%=board.getSeq() %>">
			<table>
				<tr>
				    <!-- 수정가능 -->
					<td width="80px">제목</td> 
					<td><input type="text" name="title" value="<%= board.getTitle() %>"></td>
				</tr>
				<tr>
					<td width="80px">작성자</td> 
					<td><%= board.getWriter() %></td>
				</tr>
				<tr>
					<!-- 수정가능 -->
					<td width="80px">내용</td> 
					<td><textarea  name="content" cols="40" rows="10" ><%=board.getContent() %></textarea></td>
				</tr>
				<tr>
					<td width="80px">등록일</td> 
					<td><%= board.getRegDate() %></td>
				</tr>
				<tr>
					<td width="80px">조회수</td> 
					<td><%= board.getCnt() %></td>
				</tr>
				<tr>
					<td colspan="2"> <!-- 두칸으로 늘린다 -->
						<input type="submit" value="글 수정">   <!-- 버튼 -->
					</td>
				</tr>
			</table>
		</form>
		<br>
		<!-- 메뉴생성 -->
		<a href="insertBoard.jsp">글등록</a>&nbsp;&nbsp;&nbsp;     <!-- &nbsp;  공백문자 -->
		<a href="deleteBoard.do?seq=<%=board.getSeq() %>" >글삭제</a>&nbsp;&nbsp;&nbsp;
		<a href="getBoardList.do">전체목록</a>   
	</div>
	<%@ include file="../common/Footer.jsp" %>
</body>
</html>






