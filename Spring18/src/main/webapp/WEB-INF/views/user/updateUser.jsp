<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
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
        max-width: 500px;
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
    }
    td {
        padding: 0.75rem 0;
        text-align: left;
    }
    input[type="text"], input[type="password"] {
        width: calc(100% - 1.5rem);
        padding: 0.75rem;
        border: 1px solid #d1d5db;
        border-radius: 0.5rem;
        font-size: 1rem;
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
    }
    select {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #d1d5db;
        border-radius: 0.5rem;
        font-size: 1rem;
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05);
        background-color: white;
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
    .button:hover {
        background-color: #2563eb;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>회원 정보 수정</h1>
        
        <c:choose>
            <c:when test="${not empty user}">
                <form action="updateUser.do" method="post">
                    <table>
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" name="id" value="${user.id}" readonly></td> <%-- 아이디는 수정 불가 --%>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="password" value="${user.password}" required></td>
                        </tr>
                        <tr>
                            <td>이름</td>
                            <td><input type="text" name="name" value="${user.name}" required></td>
                        </tr>
                        <tr>
                            <td>역할</td>
                            <td>
                                <select name="role">
                                    <option value="사용자" <c:if test="${user.role eq '사용자'}">selected</c:if>>사용자</option>
                                    <option value="관리자" <c:if test="${user.role eq '관리자'}">selected</c:if>>관리자</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <div class="button-group">
                                    <input type="submit" value="수정하기" class="button">
                                    <a href="getUser.do?id=${user.id}" class="button">취소</a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </c:when>
            <c:otherwise>
                <p>수정할 사용자 정보를 찾을 수 없습니다.</p>
                <div class="button-group">
                    <a href="getUserList.do" class="button">사용자 목록으로</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
