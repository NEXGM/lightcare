<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #f3f4f6;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }
    .container {
        background-color: #ffffff;
        padding: 2.5rem;
        border-radius: 0.75rem;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 600px;
        text-align: center;
    }
    h1 {
        font-size: 2.25rem;
        font-weight: 700;
        color: #1f2937;
        margin-bottom: 1.5rem;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1.5rem;
        border-radius: 0.5rem;
        overflow: hidden;
    }
    th, td {
        padding: 0.75rem 1rem;
        border: 1px solid #e5e7eb;
        text-align: left;
    }
    th {
        background-color: #e0f2f7;
        font-weight: 600;
        color: #1f2937;
    }
    td {
        background-color: #f9fafb;
        color: #374151;
    }
    .button-group {
        margin-top: 2rem;
        display: flex;
        justify-content: center;
        gap: 1rem;
    }
    .button {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        background-color: #3b82f6;
        color: white;
        text-decoration: none;
        border-radius: 0.5rem;
        font-weight: 600;
        transition: background-color 0.2s ease-in-out;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border: none;
        cursor: pointer;
    }
    .button.red {
        background-color: #ef4444;
    }
    .button:hover {
        background-color: #2563eb;
    }
    .button.red:hover {
        background-color: #dc2626;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>회원 정보</h1>
        
        <c:choose>
            <c:when test="${not empty user}">
                <table>
                    <tr>
                        <th>아이디</th>
                        <td>${user.id}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${user.name}</td>
                    </tr>
                    <tr>
                        <th>역할</th>
                        <td>${user.role}</td>
                    </tr>
                </table>

                <div class="button-group">
                    <%-- 현재 로그인한 사용자와 조회된 사용자가 같거나, 로그인한 사용자가 관리자일 경우 수정/삭제 버튼 표시 --%>
                    <c:if test="${sessionScope.user.id == user.id || sessionScope.user.role == '관리자'}">
                        <a href="updateUser.do?id=${user.id}" class="button">정보 수정</a>
                        <a href="deleteUser.do?id=${user.id}" class="button red" 
                           onclick="return confirm('정말 이 계정을 탈퇴시키겠습니까?');">회원 탈퇴</a>
                    </c:if>
                    <a href="getUserList.do" class="button">목록으로</a>
                </div>
            </c:when>
            <c:otherwise>
                <p>사용자 정보를 찾을 수 없습니다.</p>
                <div class="button-group">
                    <a href="getUserList.do" class="button">사용자 목록으로</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
