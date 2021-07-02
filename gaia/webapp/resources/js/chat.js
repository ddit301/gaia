/**
 * @author Eisen
 * @since Jun 17, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * Jun 17, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */


////////////////////////////////////////////////////
//
// chat.jsp
//
////////////////////////////////////////////////////

$(function(){
	// 특정 채팅방에 속하는 대화내용 불러오기
	$('body').on('click', '.chatRoom', function(){
		let room_no = $(this).data('chatroom_no');
		let memberList = $(this).find(".log-img-center,chat-img");
		loadChatList_chatRoom(room_no);
	})
	// 추가 채팅 멤버 초대 모달 띄우는 버튼
	$('body').on('click', '.newChat', function(){
		$('#memSearchResultChat').empty();
		$('#inviteMemberChat').modal('show');
	});
	
	// 추가 프로젝트 멤버 초대할때 검색 하는 버튼
	$('body').on('click', '#memSearchBtnChat', function(){
		let keyword = $(this).parent().children('input').val();
		searchMemberChat(keyword);
	});
	
	// 회원 초대 하려고 클릭 하는 이벤트
	$('body').on('click', '.searchedMemberChat', function(){
		let selectedMemberLi = $(this);
		let selectedMemNo = $(this).data('mem_no');
		let selectedMemName = $(this).find('.memnm').text();
		let selectedMemId = $(this).find('.memid').text();
		inviteMemberChat(selectedMemNo, selectedMemberLi);
	})
})

// 첫 페이지 로딩 시 sidebar 데이터 가져오기 
const loadMemberInfo_chat = function() {
	let need = "chatRoomList";
	$.ajax({
		url: getContextPath() + "/restapi/chat/chats",
		type: 'get',
		data: { "need": need },
		success: function(res) {
			scrollUp()
			console.log(res)
			// 채팅 날짜 순으로 정렬 하기 (가장최근이 가장 위로)
			if(!CheckNullUndefined(res.roomList)){
				res.roomList.sort(function(a, b){
				  let dateA = a.chatList[0].date.toLowerCase();
				  let dateB = b.chatList[0].date.toLowerCase();
				  if (dateA > dateB) 
				  {
				    return -1;
				  }    
				  else if (dateA < dateB)
				  {
				    return 1;
				  }   
				  return 0;
				});
			}else{
				alert("error")
			}
			
			// null checking
			if(!CheckNullUndefined(res.roomList[0])){
				$(".chat .chat_hidden").prop("hidden", false);
				// 가장 최근의 채팅방의 채팅 내역 보여주기
				loadChatList_chatRoom(res.roomList[0].chatroom_no);
				
				// side-bar 채팅방리스트 출력하기
				sideBarChatRoomListInfo(res);
			}else{
				$(".chat .chat_hidden").prop("hidden", true);
			}
		}
		,async: false
		,error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

// side-bar 출력 함수
const sideBarChatRoomListInfo = function(res, room_no) {
	let mem_count = "";
	let selectedChatRoom;
	let roomList = res.roomList;
	// 채팅 날짜 순으로 정렬 하기 (가장최근이 가장 위로)
	sortByDate(res.roomList);
	console.log(res.roomList);
	
	// 특정 채팅방을 선택했다면 side-bar 채팅방의 최상단으로 출력해주기.
	if(!CheckNullUndefined(room_no)){
		roomList = res.roomList.filter(function(room) { 
				if(room.chatroom_no == room_no){
					console.log(room);
					selectedChatRoom = room;
				}
				return room.chatroom_no !== room_no
			})
		roomList.unshift(selectedChatRoom);
	}
	
	$.each(roomList, function(i, v) {
		let mem = "";
		let chatRoom = $("#side-barChatRoomTemplate").children(".chatRoom").clone();
		// 각각의 채팅방에 채팅방 번호 주기.
		chatRoom.attr("data-chatRoom_no", v.chatroom_no);
		
		// 이름 뒤에 외 몇명 붙여주기.
		$.each(v.memberList, function(j, participant) {
			if(participant.mem_id!=res.mem_id){
				if (j < 2) {mem += participant.mem_id + ", ";}
				if (j > 1) {mem_count = "님 외 " + (j - 1) + "명";} else {mem_count = "";}
			}
		})
		// profileImg 설정 및 효과(3명 이상일 시 퍼지는 효과)
		setSideBarChatRoomProfiles(res, v.memberList, chatRoom);
		
		// 가장 최근 채팅 찍어주기.
		chatRoom.find(".chatList-card-body .side-bar-content").children("span").text(v.chatList[0].content);
		
		// 가장 최근에 연락 이후 경과된 시간 
		let timeAgo = moment(v.chatList[0].date, moment.HTML5_FMT.DATETIME_LOCAL_SECONDS).fromNow();
		
		// 이름과 날짜 찍어주기.		
		members = mem.slice(0, mem.lastIndexOf(", "));
		members += mem_count;
		chatRoom.find(".chatList-card-body .log-card-actor").children("a").text(members);
		chatRoom.find(".chatList-card-body .time").children("span").text(timeAgo);
		chatRoom.appendTo("#chatRoomList");
	})
}

////////////////////////////////////////////////////
//
// 채팅 입출력 출력 관련 
//
////////////////////////////////////////////////////

// 채팅방 채팅 내용 가져와 뿌려주기
const loadChatList_chatRoom = function(room_no) {
	let need = "chatContent";
	let mem_no = getCookie('mem_no');
	$.ajax({
		url: getContextPath() + "/restapi/chat/chats",
		method : 'get',
		data : {
			"need" : need,
			"chatroom_no" : room_no 
		}, 
		success : function(res) {
			console.log(res);
			let day;
			$("#this-is-chatRoom").empty();
			
			// 최근 채팅이 아래로 정렬
			sortByDateChat(res.chatRoom.chatList)
			
			$("#this-is-chatRoom").attr("data-room_no",room_no);
			
			// 상단의 데이터 찍어주기 chat-top
			$(".chat_img").find(".profile_img").attr("src", "");
			setSideBarChatRoomProfiles(res, res.memberList, $(".chat_img"));
			setChatTopMemberList(res.memberList, $(".membersId"), res.mem_id);
						
			$.each(res.chatRoom.chatList, function(i, chat){
				if(!CheckNullUndefined(chat.content)){
					// 순위 변경 
					let chatform = $("#chatTemplate").children(".chat-box").clone();
					let time = moment.utc(chat.date).format("hh:mm a");
					// 날 바뀌면 june 14, 2021 찍어주기 
					if (!!day && day!=moment.utc(chat.date).format("MMMM DD, YYYY")){
						dayAlert($("#chatTemplate").children(".chat-day-alarm").clone(), day);
					}
					// 각 채팅에 날짜데이터 넣어두기.
					day = moment.utc(chat.date).format("MMMM DD, YYYY");
					chatform.find(".chat-date").attr("data-date", day);
					
					// 본인이 작성한 chat일 경우 우측에 출력되게끔 수정.
					if(chat.mem_no == mem_no){
						chatToRight(chatform);
					}

					chatform.find(".chat-date").children("span").text(time);
					chatform.find(".chat-mid-top").children("span").text(chat.content);
					chatform.appendTo("#this-is-chatRoom");
					showBottom($("#this-is-chatRoom"))
				}
			})
		},
		async : false
		,error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}
//채팅 내용 입력 시 화면에 출력 
const inputChat = function(){
	event.preventDefault();
	let currentTime = new Date();
	let chatform = $("#chatTemplate").children(".chat-box").clone();
	let chatText = $("#chatInput").val();
	let date = moment(currentTime).format("hh:mm a");
	let today = moment(currentTime).format("MMMM DD, YYYY");
	let thatDay = $(".chat-room").find(".chat-box:last").children(".chat-date").data("date");
	let room_no = $("#this-is-chatRoom").data("room_no");
	// db에 제대로 들어가면 출력.
	if(inputChatUpload(chatText, room_no)){
		// 내가쓴 글이니 우측으로 정렬.
		chatToRight(chatform);
		
		// 날 바뀌면 june 14, 2021 찍어주기 
		if (today!=thatDay){ dayAlert($("#chatTemplate").children(".chat-day-alarm").clone(), today); }
		
		// chatform에 내용 채워넣기.
		chatform.find(".chat-date").children("span").text(date);
		chatform.find(".chat-date").attr("data-date", today);
		chatform.find(".chat-mid-top").children("span").text(chatText);
		
		chatform.appendTo("#this-is-chatRoom");
		$("#chatInput").val("");
		// 스크롤 가장 하단으로 변경 
		showBottom($("#this-is-chatRoom"))
	}
}

// 채팅 내용 입력 시 ElasticSearch db에 저장 
const inputChatUpload = function(content, room_no){
	let need = "elastic";
	let result = 0;
	$.ajax({
		url : getContextPath()+"/restapi/chat/chats"
		, method : 'post'
		, data : { 
					"need" : need,
					"content" : content,
					"chatroom_no" : room_no
				 }
		, success : function(res) {
			result = 1;
		}
		, async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
	return result;
}

////////////////////////////////////////////////////
//
// Header 관련 messenger 
//
////////////////////////////////////////////////////

// messenger 불러와서 찍어주기
const headerMessengerList = function(){
	let need = "oracle";
	// 확인 버튼 눌렀을때 가입정보 insert 해준다.
    $.ajax({
		url : getContextPath() + '/restapi/chat/chats',
		method : 'post',
		data : {
			"need" : need,
		},
		success : function(res) {
			console.log(res);
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json',
	})
}

////////////////////////////////////////////////////
//
// 회원 초대 관련 
//
////////////////////////////////////////////////////

// 초대할 회원 검색하는 function
const searchMemberChat = function(keyword){
	let need = "searchMemberList";
	$.ajax({
		url: getContextPath() + "/restapi/chat/chats",
		method : 'get',
		data : {
			"need" : need,
			'keyword' : keyword
		},
		success : function(res) {
			console.log(res)
			let members = res.memberList;
			let searchResultUl = $('#memSearchResultChat');
			searchResultUl.empty();
			$.each(members, function(i,member){
				let memberBox = $('#setting-member-template-chat').find('.searchedMemberChat').clone();
				memberBox.attr('data-mem_no', member.mem_no);
				memberBox.find('.memid').text(member.mem_id);
				memberBox.find('.memnick').text(member.mem_nick);
				memberBox.find('.memnm').text(member.mem_nm);
				memberBox.find('.memcity').text(member.mem_working_city);
				memberBox.find('img').attr('src', getProfilePath(member.mem_pic_file_name));
				searchResultUl.append(memberBox);
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}

// 멤버 초대하는 function
const inviteMemberChat = function(selectedMemNo, selectedMemberLi){
	let need = "oracle";
	// 확인 버튼 눌렀을때 가입정보 insert 해준다.
    $.ajax({
		url : getContextPath() + '/restapi/chat/chats',
		method : 'post',
		data : {
			"need" : need,
			"mem_no2" : selectedMemNo
		},
		success : function(res) {
			console.log(res);
			if(res.result != 0){
				selectedMemberLi.remove();
				$("#chatRoomList").empty();
				// 채팅 추가 시 다시 side-bar 채팅방 목록 찍어주는 로직
				sideBarChatRoomListInfo(res, res.result);
				
				// 해당 방의 채팅 내역 보여주기.
				loadChatList_chatRoom(res.result);
				swal.success({text: "done!"});
			}
				$('#inviteMemberChat').modal('hide');
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json',
	})
}


////////////////////////////////////////////////////
//
// 필요에 의해 만든 function들. 
//
////////////////////////////////////////////////////


// 채팅 date 별로 채팅방 side-bar 순위변경 함수.
const sortByDate = function(List){
	List.sort(function(a, b){
	  let dateA = a.chatList[0].date.toLowerCase();
	  let dateB = b.chatList[0].date.toLowerCase();
	  if (dateA > dateB) 
	  {
	    return -1;
	  }    
	  else if (dateA < dateB)
	  {
	    return 1;
	  }   
	  return 0;
	});
}
// 채팅 date 별로 채팅방 side-bar 순위변경 함수.
const sortByDateChat = function(List){
	List.sort(function(a, b){
	  let dateA = a.date.toLowerCase();
	  let dateB = b.date.toLowerCase();
	  if (dateA < dateB) 
	  {
	    return -1;
	  }    
	  else if (dateA > dateB)
	  {
	    return 1;
	  }   
	  return 0;
	});
}
// 본인이 친 채팅이면 오른쪽 아니면 왼쪽에 출력 함수.
const chat_left_right = function(res){
	let mem_no = getCookie('mem_no');
	$.each(res.chatList, function(i, chat){
		let chatform = $("#chatTemplate").children(".chat-card").clone();
		let date = moment(chat.date).format("hh:mm a")
		if(chat.mem_no == mem_no){
			chatform.removeClass("left").addClass("right");
		}
		chatform.find(".chat-date").children("span").text(date);
		chatform.find(".card-body").children("span").text(chat.content);
		chatform.appendTo("#this-is-chatRoom");
	})
}
// 채팅방 중 가장 하단 출력하기
const showBottom = function(d){
	d.scrollTop(d.prop("scrollHeight"));
}
// 내가 쓴 글이면 오른쪽으 로바꾸기 
const chatToRight = function(chatform){
	chatform.removeClass("left").addClass("right");
	chatform.append(chatform.find(".chat-card"));
	chatform.find(".chat-date").addClass("toRight");
}
// 날짜 바뀌면 채팅창에 찍어주기 
const dayAlert = function(dayAlert, today){
	dayAlert.children("span").text(today);
	dayAlert.appendTo("#this-is-chatRoom");
}
const addSideBarChatRoom = function(){
	
}
// 프로필 사진 찍어주는 function
const setSideBarChatRoomProfiles=function(res, memberList, chatRoom){
	// profileImg 설정 및 효과(3명 이상일 시 퍼지는 효과)
	$.each(memberList, function(j, member) {
		if(member.mem_id!=res.mem_id&&CheckNullUndefined(chatRoom.find(".profile_img.img-center").attr("src"))){
			// 본인이 아닌 사진.(1:1)
			chatRoom.find(".profile_img.img-center").attr("src", getProfilePath(member.mem_pic_file_name));
		}
		if (memberList.length < 4) {
			chatRoom.find(".profile_img.img-right").attr("hidden", "true");
			chatRoom.find(".profile_img.img-left").attr("hidden", "true");
		}else{
			if(member.mem_id!=res.mem_id && j < 3){
				chatRoom.find(".profile_img").removeAttr("hidden");
				chatRoom.find(".profile_img.img-left").attr("src", getProfilePath(memberList[j].mem_pic_file_name));
				chatRoom.find(".profile_img.img-right").attr("src", getProfilePath(memberList[j+1].mem_pic_file_name));
			}
		}
	})
}
// 채팅방 참여자 출력
const setChatTopMemberList = function(memberList, membersId, self){
	let membersStr = "";
	$.each(memberList, function(i, member){
		if(member.mem_id!=self){
			membersStr += member.mem_id + ", "
		}
	})
	membersStr = membersStr.slice(0, membersStr.lastIndexOf(","));
	membersId.text(membersStr);
}
