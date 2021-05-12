<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <nav class="container d-flex flex-column flex-md-row justify-content-between">
    <a class="py-2" href="${cPath }" aria-label="Product">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="d-block mx-auto" role="img" viewBox="0 0 24 24"><title>Product</title><circle cx="12" cy="12" r="10"/><path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"/></svg>
    </a>
    <a class="py-2 d-none d-md-inline-block" href="${cPath }/member/memberList.do">회원관리</a>
    <a class="py-2 d-none d-md-inline-block" href="${cPath }/prod/prodList.do">상품관리</a>
    <a class="py-2 d-none d-md-inline-block" href="${cPath }/member/memberList.do">거래처관리</a>
    <a class="py-2 d-none d-md-inline-block" href="${cPath }/board/boardList.do">자유게시판</a>
    <a class="py-2 d-none d-md-inline-block" href="${cPath }/member/memberList.do">알바관리</a>
	<c:if test="${not empty menu }">
	    <a class="py-2 d-none d-md-inline-block" href="<c:url value="${menu.menuURL}"/>">${menu.menuText}</a>
	</c:if>
	<a class="py-2 d-none d-md-inline-block" href="?lang=ko">한글</a>
	<a class="py-2 d-none d-md-inline-block" href="?lang=en">English</a>
  </nav>