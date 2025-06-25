<%@page import="java.util.ArrayList"%>
<%@page import="com.spring.biz.common.BoardDTO"%>
<%@page import="com.spring.biz.board.impl.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>


<!--  JSTL과 EL로 구현해보자 -->
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
			width:1000px;
			margin:30px auto;
			border:1px solid black;
			border-collapse: collapse;
			text-align:center;
		}
		td,tr,th{
			margin: 0; padding: 0;
			border: 1px solid black;
		}
		th{background: skyblue}
		input {
			margin: 0;
		}
	</style>
</head>

<body>
	<%@ include file="../common/Header.jsp" %>
	<div>
		<h1>글 목록</h1>
		<h3>홍길동님 환영합니다...<a href="logout.do">로그아웃</a></h3>
		
		<!-- 검색기능추가 -->
		<form action="getBoardList.do" method="post">
			<table>
				<tr style="border: none;">
					<td align="right" style="border: none;">
						<select name="searchCondition">
							<!-- <option value="TITLE">제목 -->
							<!-- <option value="CONTENT">내용 -->
							
							<!-- 컨트롤러에서 생성해둔다 해시맵으로 
								 conditionMap.put("제목","TITLE");
							     conditionMap.put("내용","CONTENT"); -->
							<c:forEach var="option"  items="${conditionMap}" >   
								<option value="${option.value}"> ${option.key }
							</c:forEach>
							
						</select>
						<input type="text" name = "searchKeyword">
						<input type="submit" value="검색">
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 전체검색한 데이터를 보여줌 -->
		<table>
			<tr>
				<th>번호</th><th>제목</th><th>작성자</th><th>내용</th><th>등록일</th><th>조회수</th>
			</tr>
			
			<c:forEach  var="board"  items="${boardList }" >
				<tr>
					<td>${board.seq}</td>
					<!-- 제목을 클릭하면 seq번호를 가지고 getBoard.jsp페이지로 이동한다 -->
					<td><a href="getBoard.do?seq=${board.seq}">${board.title}</a></td>
						     <!--  위는 제목을 클릭하면 상세내역으로 seq(번호)값을 가지고 이동하게 구현 -->
					<td>${board.writer}</td>
					<td>${board.content}</td>
					<td>${board.regDate}</td>
					<td>${board.cnt }</td>
				</tr>
			</c:forEach>

		</table>
		<a href="insertBoard.do">새글등록</a>   <!-- get방식이동 -->
	</div>
		<%@ include file="../common/Footer.jsp" %>
</body>
</html>








