<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 목록</title>
<style type="text/css">
    body {
        font-family: 'Inter', sans-serif; /* Inter 폰트 적용 (TailwindCSS 기본) */
        background-color: #f3f4f6; /* Tailwind gray-100 */
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh; /* 전체 화면 높이 */
        margin: 0;
        padding: 20px;
    }
    .container {
        background-color: #ffffff;
        padding: 2.5rem; /* p-10 */
        border-radius: 0.75rem; /* rounded-xl */
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* shadow-lg */
        width: 100%;
        max-width: 900px; /* max-w-3xl */
        text-align: center;
    }
    h1 {
        font-size: 2.25rem; /* text-4xl */
        font-weight: 700; /* font-bold */
        color: #1f2937; /* Tailwind gray-900 */
        margin-bottom: 1.5rem; /* mb-6 */
    }
    h3 {
        font-size: 1.25rem; /* text-xl */
        color: #4b5563; /* Tailwind gray-600 */
        margin-bottom: 1rem; /* mb-4 */
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 1.5rem; /* mt-6 */
        border-radius: 0.5rem; /* rounded-lg */
        overflow: hidden; /* 테이블 모서리 둥글게 */
    }
    th, td {
        padding: 0.75rem 1rem; /* py-3 px-4 */
        border: 1px solid #e5e7eb; /* border-gray-200 */
        text-align: left;
    }
    th {
        background-color: #e0f2f7; /* skyblue와 비슷한 색상 */
        font-weight: 600; /* font-semibold */
        color: #1f2937;
        text-align: center; /* 헤더 텍스트 가운데 정렬 */
    }
    td {
        background-color: #f9fafb; /* Tailwind gray-50 */
        color: #374151; /* Tailwind gray-700 */
        text-align: center; /* 바디 텍스트 가운데 정렬 */
    }
    tr:nth-child(even) td {
        background-color: #ffffff; /* 짝수 행 배경색 */
    }
    .button-group {
        margin-top: 2rem; /* mt-8 */
        display: flex;
        justify-content: center;
        gap: 1rem; /* space-x-4 */
    }
    .button {
        display: inline-block;
        padding: 0.75rem 1.5rem; /* py-3 px-6 */
        background-color: #3b82f6; /* Tailwind blue-500 */
        color: white;
        text-decoration: none;
        border-radius: 0.5rem; /* rounded-lg */
        font-weight: 600; /* font-semibold */
        transition: background-color 0.2s ease-in-out;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* shadow-md */
    }
    .button:hover {
        background-color: #2563eb; /* Tailwind blue-600 */
    }
    .logout-link {
        color: #ef4444; /* Tailwind red-500 */
        text-decoration: none;
        font-weight: 500;
        margin-top: 1rem; /* mt-4 */
        display: block;
    }
    .logout-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="container">
        <h1>사용자 목록</h1>
        
        <%-- 세션에 "user" 객체가 있다면 환영 메시지 표시 --%>
        <c:if test="${not empty sessionScope.user}">
            <h3>${sessionScope.user.name}님, 환영합니다!</h3>
            <a href="logout.do" class="logout-link">로그아웃</a>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>역할</th>
                    <%-- 필요하다면 여기에 "상세보기" 또는 "수정/삭제" 컬럼 추가 가능 --%>
                </tr>
            </thead>
            <tbody>
                <%-- Controller에서 Model에 추가한 "userList" 데이터를 JSTL로 반복 출력 --%>
                <c:choose>
                    <c:when test="${not empty userList}">
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.name}</td>
                                <td>${user.role}</td>
                                <%-- 상세보기 링크 (필요하다면 활성화) --%>
                                <%-- <td><a href="getUser.do?id=${user.id}">상세보기</a></td> --%>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3">등록된 사용자가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <div class="button-group">
            <a href="getBoardList.do" class="button">게시판 목록으로</a>
            <%-- 관리자만 회원가입 링크를 볼 수 있도록 조건 추가 (선택 사항) --%>
            <c:if test="${sessionScope.user.role == '관리자'}">
                <a href="insertUser.do" class="button">새 사용자 등록</a>
            </c:if>
        </div>
    </div>
</body>
</html>
