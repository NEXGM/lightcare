<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  

<div style="text-align: center; font-size: 15px; background: #00008b; color: #fff; 
			height: 160px; padding: 10px">
			
			<h1>My Project Management System</h1>
			<span style="float: right; margin-right: 20px">
											<!-- http://localhost:8080/프로젝트(컨텍스트)/list.do -->
				<a style="color:white;" href="<%=request.getContextPath() %>/memberList.do">회 원</a>&nbsp;
				
				<!-- 세션속에  user객체도 없고, user이름도 없다면  로그인버튼이 보여지게 하고, 로그인버튼을 클릭하며  login.do로 간다-->
				<c:if test="${empty sessionScope.user or  
							  empty sessionScope.user.id}">
							 <a style="color: white;" href="<%=request.getContextPath() %>/login.do" >로 그 인</a>
				</c:if>
				<!-- 세션속에  user객체도 있고, user이름도 있다면  로그인버튼이 보여지게 하고, 로그아웃버튼을 클릭하며  logout.do로 간다-->
				<c:if test="${!empty sessionScope.user or
							  !empty sessionScope.user.name }">							  
							  <a style="color: white;" href="<%=request.getContextPath() %>/logout.do" >로그아웃</a>
				</c:if>
			</span>

</div>