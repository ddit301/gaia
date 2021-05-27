<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 26 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>웹 소켓 클라이언트</h4>
<pre>
서버 : wss://echo.websocket.org
</pre>
<input type="text" id="msgArea"/>
<input type="button" id="sendBtn" value="전송">
<div id="messages">
</div>
<input type="button" id="connBtn" value="connect"/>
<input type="button" id="disconnBtn" value="disconnect"/>
<script>
// 	var server = "wss://echo.websocket.org";
	var server = "wss://localhost${cPath}/echo";
	var ws = null;
	
	$("#connBtn").on('click', function(){
		
		ws = new WebSocket(server);
		ws.onopen = function(event){
			let server = event.target.url;
			console.log(server + "와 연결 수립");
		}
		
		ws.onerror = function(event){
			console.log("에러 발생");
		}
		ws.onclose = function(event){
			let server = event.target.url;
			console.log(server + "와 연결 종료");
		}
		ws.onmessage=function(event){
			let server = event.target.url;
			let receiveMsg = event.data;
			console.log(server + "에서<" + receiveMsg + ">메시지 수신");
			let pTag = $("<p>").html("received message : " + receiveMsg);
			$("#messages").append(pTag);
		}
	});
	
	$("#disconnBtn").on('click', function(){
		if(ws == null) return;
		ws.close();
	});
	$("#sendBtn").on("click",function(){
		let message = $("#msgArea").val();
		if(!message) return;
		ws.send(message);
		let pTag = $("<p>").html("send message : " + message);
		$("#messages").append(pTag);
	});
</script>
</body>
</html>










