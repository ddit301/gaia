<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.loginDiv{	
	border : 1px solid black;
	width : 500px;
	height : 500px;
	position : absolute;
	top : 50%;
	left : 50%;
	margin-top : -250px;
	margin-left : -250px;
	padding : 50px;
}
</style>
<jsp:include page="/includee/preScript.jsp" />
<title>test3 login</title>
</head>
<body>
<%
	Cookie[] cookies = request.getCookies();
	String savedId = "";
	String checked = "";
	Cookie savedIdCookie = null;
	if(cookies != null){
		for(Cookie tmp : cookies){
			String value = URLDecoder.decode(tmp.getValue(),"utf-8");
			if("savedId".equals(tmp.getName())){
				savedId = URLDecoder.decode(tmp.getValue(),"utf-8");
				checked = "".equals(savedId)? "" : "checked";
				break;
			}
		}
	}
	pageContext.setAttribute("savedId", savedId);
	pageContext.setAttribute("checked", checked);
%>
<c:if test="${not empty message}">
	<script type="text/javascript">
		alert('${message}');
	</script>
	<c:remove var="message"/>
</c:if>


<div class="loginDiv">
	<h4>로그인</h4>
	<form method="post" action="loginCheck.do">
	  <div class="mb-3">
	    <label for="user_id" class="form-label">username</label>
	    <input type="text" class="form-control" name="user_id" id="user_id" value="${savedId }" placeholder="아이디를 입력하세요.">
	  </div>
	  <div class="mb-3">
	    <label for="user_pass" class="form-label">Password</label>
	    <input type="password" class="form-control" name="user_pass" id="user_pass" placeholder="패스워드를 입력하세요.">
	  </div>
	  <div class="mb-3 form-check">
	    <input type="checkbox" name="saveId" value="saveId" class="form-check-input" id="exampleCheck1" ${checked }>
	    <label class="form-check-label" for="exampleCheck1">Remember me</label>
	  </div>
	  <button type="submit" class="btn btn-primary">로그인</button>
	  <a href="#">아이디/패스워드 찾기</a>
	</form>
</div>
<jsp:include page="/includee/postScript.jsp"/>	
<script type="text/javascript">
var idInput = document.querySelector('#user_id');
var pwInput = document.querySelector('#user_pass');
var korean = function() {
  var pattern = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
  this.value = this.value.replace(pattern, '');
};
idInput.addEventListener('keyup', korean);
pwInput.addEventListener('keyup', korean);
</script>
</body>
</html>