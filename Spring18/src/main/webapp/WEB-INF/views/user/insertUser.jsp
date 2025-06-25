<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://cdn.tailwindcss.com"></script>
<style>
    body {
        font-family: 'Inter', sans-serif;
        background-color: #f3f4f6; /* Tailwind gray-100 */
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
        padding: 2.5rem; /* p-10 */
        border-radius: 0.75rem; /* rounded-xl */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* shadow-lg */
        width: 100%;
        max-width: 500px; /* max-w-lg */
        text-align: center;
    }
    h1 {
        font-size: 2.25rem; /* text-4xl */
        font-weight: 700; /* font-bold */
        color: #1f2937; /* Tailwind gray-900 */
        margin-bottom: 1.5rem; /* mb-6 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1.5rem;
    }
    td {
        padding: 0.75rem 0; /* py-3 */
        text-align: left;
    }
    input[type="text"], input[type="password"] {
        width: calc(100% - 1.5rem); /* Full width minus padding */
        padding: 0.75rem; /* p-3 */
        border: 1px solid #d1d5db; /* border-gray-300 */
        border-radius: 0.5rem; /* rounded-lg */
        font-size: 1rem; /* text-base */
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.05); /* shadow-sm */
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
        background-color: #3b82f6; /* Tailwind blue-500 */
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
        background-color: #2563eb; /* Tailwind blue-600 */
    }
    .link-text {
        display: block;
        margin-top: 1rem;
        color: #6b7280; /* Tailwind gray-500 */
        text-decoration: none;
        font-weight: 500;
    }
    .link-text:hover {
        text-decoration: underline;
        color: #4b5563; /* Tailwind gray-600 */
    }
</style>
</head>
<body>
    <div class="container">
        <h1>회원가입</h1>
        
        <form action="insertUser.do" method="post">
            <table>
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="id" required placeholder="아이디를 입력하세요"></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="password" required placeholder="비밀번호를 입력하세요"></td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="name" required placeholder="이름을 입력하세요"></td>
                </tr>
                <tr>
                    <td>역할</td>
                    <td>
                        <select name="role">
                            <option value="사용자">사용자</option>
                            <option value="관리자">관리자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="text-center">
                        <div class="button-group">
                            <input type="submit" value="가입하기" class="button">
                            <a href="login.do" class="button">로그인</a>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
        <a href="login.do" class="link-text">이미 계정이 있으신가요? 로그인</a>
    </div>
</body>
</html>
