
// 페이지 열릴때 멤버 관련된 url 이란 판단이 되면, memberMovePageHistory 발동.
$(function(){
	if(memberPageParam){
		memberMovePage(memberPageParam);
	}
})
// char or chat/1
const memberMovePageHistory = function(pageParam){
	var url = getContextPath() +'/'+mem_id+'/' +pageParam;
	history.pushState('member-'+pageParam, null, url);
	memberMovePage(pageParam);
}

const memberMovePage = function(pageParam){
	let path = getContextPath()+"/view/member/";
	let index;
	// member 페이지에서는 horizontal로만 보여줍니다.
	new quixSettings({
	    layout: "horizontal" // vertical or horizontal
	});
	// sideBar와 햄버거 메뉴를 숨깁니다 - project에 종속되기 떄문.
	$('.nk-sidebar').prop('hidden','true');
	$('.nav-control').prop('hidden','true');
	
	if(!pageParam){
		pageParam = 'overview';	
	}
	// setting으로 요청이 들어오면 profile로 변경시키기.(setting/profile -> setting으로만 표시 )
	if(pageParam=="setting"){
		pageParam = 'profile';	
	}
	// profile.jsp에서 'setting/account'로 pageParam을 넘김.
	if(pageParam.includes("setting/")){
		index = pageParam.indexOf("/");
		pageParam = pageParam.slice(index+1);
	}
	// url에서 'chat/...'으로 pageParam을 넘김.
	if(pageParam.includes("chat/")){
		index = pageParam.indexOf("/");
		pageParam = pageParam.substring(0,index);		
	}
	$.ajax({
		url : path+pageParam ,
		type : 'get',
		data : {'mem_id' : mem_id
			},
		success : function(res) {
			$('.content-body').html(res);
		},
		error : function(xhr) {
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert('등록되지 않는 버튼 : ' + pageParam);				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'html'
	})
}
////////////////////////////////////////////////////
//
// overview.jsp
//
////////////////////////////////////////////////////

// 페이지 로딩 시 retrieveMemberProjectIssue(mem_no) 요청 
const loadMemberInfo_overview = function(){
	let need = "MemberProjectIssue";
	$.ajax({
		url : getContextPath()+"/restapi/member/members" ,
		type : 'get',
		data : {"need" : need},
		success : function(res) {
			let memberInfo = res.search;
			let projectList="";
			let length;
			let proj_manager ="";
			let profile_img =$("#profile_img").attr("src", getProfilePath(memberInfo.mem_pic_file_name));
			$.each(memberInfo.projectList, function(i, v){
				let url = v.url;
				proj_manager = v.projectManager.mem_id;
				projectList += "<li>"
							+'		<a class="projectBtn projectName" data-manager_id="'+v.projectManager.mem_id+'" data-project_title="'+v.proj_title+'" href="'+getContextPath()+"/"+ v.url+'">'+ v.proj_title
							+"		</a>"
							+"	</li>";
				
				$.each(v.issueList, function(j, iss){
					let issue = $("#issueTemplate").children(".issue").clone();
					let timeUploaded = iss.historyList[0].issue_his_date;
					let timeAgo = moment(timeUploaded, "YYYYMMDD").fromNow();
					let proj_manager_link = "<a href="+getContextPath()+"/"+proj_manager+">"+proj_manager+"</a>"; 
					let proj_link = "<a href="+getContextPath()+"/"+url+">"+"/"+v.proj_title+"</a>";
					let issue_link = "<a href="+getContextPath()+"/"+iss.url+">"+"/"+iss.issue_sid+"</a>";
					
					issue.attr("data-issue_sid", iss.issue_sid);
					issue.find(".issue-card-top").children().first().html(proj_manager_link + proj_link + issue_link);
					
					issue.find(".issue-card-top").children().last().text(iss.issue_title);
					issue.find(".issue-card-mid").find(".issue_date").text(timeAgo);
					issue.find(".issue-card-mid").find(".fixer_id").text("by "+iss.historyList[0].historyWriter.mem_nick);
					issue.find('.issue-card-bot').text(iss.historyList[0].issue_his_cont);
						
					issue.appendTo("#issues");
				})
				length = v.issueList.length
				if(length%2){
					$("#issueTemplate").children(".issue").clone().appendTo("#issues");
				}
			})
			$("#projectList").html(projectList);
			$("#mem_bio").text(memberInfo.mem_bio);
		},
		async : false
		,error : function(xhr) {
			console.log(xhr);
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}

////////////////////////////////////////////////////
//
// profile.jsp
//
////////////////////////////////////////////////////

// 페이지 로딩 시 retrieveMemberProjectIssue(mem_no) 요청 
const loadMemberInfo_profile = function(){
	$.ajax({
		url : getContextPath()+"/restapi/member/members" ,
		type : 'get',
		success : function(data) {
			res = data.search;
			msl = data.memberStatusList
			let placeholder = $(".card.mem_nick").children('input').attr('placeholder', res.mem_nick);
			let bio = $(".card.mem_bio").children('textarea').attr('placeholder', res.mem_bio);
			let workingCity = $(".card.mem_working_city").children('input').attr('placeholder', res.mem_working_city);
			let tel = $(".card.mem_tel").children('input').attr('placeholder', res.mem_tel);
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
			let memList = ""
			for(i in msl){
				if(i%4==0){memList +='<br>'}
				if(res.mem_status == msl[i].COM_CODE_NM){
					memList += '<label for="'+msl[i].COM_CODE+'""><input type="radio" id="'+msl[i].COM_CODE+'" name="mem_status" value='+msl[i].COM_CODE+' checked>&nbsp'+msl[i].COM_CODE_NM+'</label>&nbsp&nbsp';
				}else{
					memList += '<label for="'+msl[i].COM_CODE+'""><input type="radio" id="'+msl[i].COM_CODE+'" name="mem_status" value='+msl[i].COM_CODE+' >&nbsp'+msl[i].COM_CODE_NM+'</label>&nbsp&nbsp';
				}
			}
			$(".mem_status").children("div").html(memList);
		},
		async : false
		,error : function(xhr) {
			console.log(xhr);
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}

// profile_img 변경 form-data
// 프로필 사진 변경 버튼 클릭 시 imageSelect function호출 
$(function(){
	$(".content-body").on("click", ".edit-profile",function(){
		console.log("aaaaa")
		$("#upload_image").click();
	})
})
const imageSelect = $(".content-body").on("change", "#upload_image",function(){
	var formdata = $("#profile_imageForm")[0];
	var form_data = new FormData(formdata);
	// input으로 put을 줌. 
	// need로 분별하기.
	form_data.append("need", "profileImg");
	$.ajax({
		url : getContextPath()+"/restapi/member/members" ,
		type : 'post',
		data : form_data,
		processData: false,
		contentType: false,
		success : function(res) {
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
			toastr.success('Update에 성공했습니다.')
		},
		error : function(xhr) {
			console.log(xhr);
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		cache : false,
		dataType : 'json'
	})
})
// 프로필 설정 ajax
const updateProfile = function(){
	event.preventDefault();
	var profile  = $(".basic-form").serializeJSON();
	$.ajax({
		url : getContextPath()+"/restapi/member/members/",
		method : 'post',
		data : profile, 
		success : function(res) {

			window.scrollTo({top:0, left:0, behavior:'smooth'});
			toastr.success('Update에 성공했습니다.')
		},
		async : false,
		error : function(xhr) {
			console.log(xhr);
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}

////////////////////////////////////////////////////
//
// account.jsp
//
////////////////////////////////////////////////////
// 페이지로딩 ajax / no need
const loadMemberInfo_account = function(){
	let imgPath = getContextPath()+"/resources/profiles/";
	$.ajax({
		url : getContextPath()+"/restapi/member/members",
		type : 'get',
		success : function(res) {
			console.log(JSON.stringify(res.search));
			let nm = $("#mem_nm").attr('placeholder', res.search.mem_nm);
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
		},
		async : false
		,error : function(xhr) {
			if(xhr.status == 401){
				toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
				setTimeout(function(){window.location.href=getContextPath()}, 2000);
			}else{
				toastr.error("Error!! try it later!")
			}
		},
		dataType : 'json'
	})
}

//이름 변경 버튼 바인딩
const changeUserNameBtn = $(".changeAccountBtn").on("click",function(){
	event.preventDefault();
	let form_data = {"_method" : "put"};
	let pass = false;
	if($(this).val() =="mem_nm" ){
		form_data["mem_nm"] = $("#"+$(this).val()+"").val();
		confirmAlert("name", form_data);
	}else{
		let form_data = $(".password_form").serializeJSON();
		form_data["_method"] = "put";
		form_data["need"] = "mem_password";
		
		if(valid(pass) == true){
			console.log("in")
			confirmAlert("pass",form_data);
		}
	}
})
// swal 확인 js
const confirmAlert = function(ajaxEvent, form_data){
	swalWithBootstrapButtons = Swal.mixin({
		customClass: {
	    	confirmButton: 'btn btn-success',
		    cancelButton: 'btn btn-danger'
	    },
	    buttonsStyling: false
	})
	swalWithBootstrapButtons.fire({
		title: '변경하시겠습니까?',
		text: "변경하면 되돌릴 수 없습니다!",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonText: '네',
		cancelButtonText: '아니오',
		reverseButtons: false
	}).then((result) => {
		if (result.isConfirmed) {
			console.log(ajaxEvent)
			ajaxEvent : ajaxEvent=="name" ? updateName(form_data) : updatePass(form_data);
		} 
	})
}

// 이름 변경함수
const updateName = function(form_data){
	form_data["need"]="mem_nm"; 
	$.ajax({
		url : getContextPath()+"/restapi/member/members/",
		method : 'post',
		data : form_data,
		success : function(res) {
			window.scrollTo({top:0, left:0, behavior:'smooth'});
			$("#mem_nm").val("");
			$("#mem_nm").attr("placeholder", res.member.mem_nm);
			toastr.success('이름 변경에 성공했습니다.')
			swal.success();
		},
		enctype: 'multipart/form-data', 
		async : false,
		error : function(xhr) {
			if(xhr.status == 401){
				toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
				setTimeout(function(){window.location.href=getContextPath()}, 2000);
			}else{
				toastr.error("Error!! try it later!")
			}
		},
		dataType : 'json'
	})
}

// 비밀번호 변경함수
const updatePass = function(form_data){
	if(!$(".confirmNewPassword").find("span").prop("hidden") && !!$("#old_pass").val()){
		console.log(form_data);
		$.ajax({
			url : getContextPath()+"/restapi/member/members/",
			method : 'post',
			data : form_data,
			success : function(res) {
				if(res.sr =="OK"){
					window.scrollTo({top:0, left:0, behavior:'smooth'});
					toastr.success('Update에 성공했습니다.')
					swal.success();
				}else if(res.sr =="NOTEXIST"){
					swal.error({
						title : res.sr,
						text : "비밀번호를 제대로 입력하세요."
					});
				}else {
					swal.error({
						title : res.sr,
						text : "잘못된 비밀번호입니다."
					});
				}
			},
			enctype: 'multipart/form-data', 
			async : false,
			error : function(xhr) {
				if(xhr.status == 401){
					toastr.error("세션이 만료되어 로그인 페이지로 이동합니다.");
					setTimeout(function(){window.location.href=getContextPath()}, 2000);
				}else{
					toastr.error("형식에 맞게 작성해 주세요!")
				}
			},
			dataType : 'json'
		})
	}
}

const valid = function(){
	if(!$("#old_pass").val() || !$("#mem_pass").val() || !$("#confirm_pass").val()) {
		swal.warning({
			text : "빈칸을 모두 채워주세요!!"
		});
		return false;
	}else if(!$(".confirmNewPassword").val() && $(".confirmNewPassword").find("span").prop("hidden")) {
		swal.warning({
			text : "new password와 confirm new password가 다릅니다!!"
		});
		return false;
	}
	else if($(".confirmNewPassword").find("span").prop("hidden")) {
		swal.warning({
			text : "confirm new password를 확인해 주세요!!"
		});
		return false;
	}else{
		return pass = true;
	}
}

$(function(){
	$(".password_form").validate({
		  errorElement: "span"
	});
	
	$(".content-body").on("keyup", ".password", function(){
		let mem_pass = $("#mem_pass").val();
		let confirm_pass = $("#confirm_pass").val();
		if(mem_pass){
			if(mem_pass == confirm_pass){
				$(".confirmNewPassword").find("span").prop("hidden", false)
			}else{
				$(".confirmNewPassword").find("span").prop("hidden", true)
			}
		}
	})
})


////////////////////////////////////////////////////
//
// securityLog.jsp
//
////////////////////////////////////////////////////
const loadMemberInfo_log = function(){
	$.ajax({
		url : getContextPath()+"/restapi/member/members",
		data : {"need":"logList"},
		type : 'get',
		success : function(res) {
			$(".profile_img").attr("src", getProfilePath(res.search.mem_pic_file_name));
			$(".profile_img_label").attr("title", "View "+res.search.mem_id+"'s profile");
			$(".profile_img_label").siblings("input").val(res.search.mem_id);
			$.each(res.logList, function(i, v){
				let log = $("#logTemplate").children(".log").clone();
				let timeAgo = moment(v.date,moment.HTML5_FMT.DATETIME_LOCAL_SECONDS).fromNow();
				let ip = v.date+'<span class="vertical-separator"></span>'+timeAgo;
				log.find(".log-card-ip").html(ip);
				log.find(".log-card-actor").children("a").text(res.search.mem_id+" - user.login");				
				log.appendTo("#logList");
			})
		},
		async : false
		,error : function(xhr) {
			console.log(xhr);
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}
$(function(){
	$('.profile_img_label').tooltip();
	$('.content-body').on('click', '.pagination .page-link', function(){
		event.preventDefault();
		let dataBtn = $(this).data('btn');
		if(dataBtn== 'prev'){
			currentPage = parseInt(startPage) - 1;
		}else if(dataBtn == 'next'){
			currentPage = parseInt(endPage) + 1;
		}else{
			if(currentPage == $(this).text()){
				return false;
			}else{
			currentPage = $(this).text();
			}
		}
		window.scrollTo({top:0, left:0, behavior:'auto'});
		loadIssueList();
	})
})

const toOverview = function(){
	$('.profile_img_label').tooltip('hide');
	memberMovePageHistory('overview');
}

////////////////////////////////////////////////////
//
// chat.jsp
//
////////////////////////////////////////////////////

// retrieveMemberProjectIssue(mem_no) 요청
var loadMemberInfo_chat = function(){
	let need = "chatList";
	let mem ="";
	let mem_count="";
	$.ajax({
		url : getContextPath()+"/restapi/chat/chats" ,
		type : 'get',
		data : {"need" : need},
		success : function(res) {
			console.log(res)
			$.each(res.roomList, function(i, v){
				let chatRoom = $("#chatRoomTemplate").children(".chatRoom").clone();
				console.log(v.memberList[i].mem_pic_file_name);
				chatRoom.find(".profile_img.img-center").attr("src", getProfilePath(v.memberList[0].mem_pic_file_name));
				$.each(v.memberList, function(j, participant){
					if(j<2){
						mem += participant.mem_id+", ";
					}
					if(j>1){
						chatRoom.find(".profile_img.img-left").attr("src", getProfilePath(v.memberList[1].mem_pic_file_name));
						chatRoom.find(".profile_img.img-right").attr("src", getProfilePath(v.memberList[2].mem_pic_file_name));
						mem_count = "님 외 "+(j-1)+"명";
					}else{
						mem_count = "";
					}
				})
				console.log("length " + v.memberList.length)
				if(v.memberList.length < 3){
					console.log("들어오나??");
					chatRoom.find(".profile_img.img-right").remove();
					chatRoom.find(".profile_img.img-left").remove();
				}
				console.log(v.chatList[0])
				chatRoom.find(".chatList-card-body .content").children("span").text(v.chatList[0].content);
				let timeAgo = moment(v.chatList[0].date,moment.HTML5_FMT.DATETIME_LOCAL_SECONDS).fromNow();
				members = mem.slice(0, mem.lastIndexOf(", "));
				members += mem_count;
				chatRoom.find(".chatList-card-body .log-card-actor").children("a").text(members);
				chatRoom.find(".chatList-card-body .time").children("span").text(timeAgo);
				chatRoom.appendTo("#chatRoomList");
				mem="";
				let content = "";
				
//					console.log(res.chatListChatRoom.chatroom);
				chatRoom.find(".chatList-card-body .content").children("span").text();
			})
			
		
//				$(".profile_img_label").attr("title", "View "+res.search.mem_id+"'s profile");
//				$(".profile_img_label").siblings("input").val(res.search.mem_id);
//				$.each(res.logList, function(i, v){
//					let chatRoom = $("#chatRoomTemplate").children(".chatRoom").clone();
//					// elastic
////					let timeAgo = moment(v.date, "YYYYMMDD").fromNow();
////					let ip = v.date+'<span class="vertical-separator"></span>'+timeAgo;
////					log.find(".log-card-ip").html(ip);
////					log.find(".log-card-actor").children("a").text(res.search.mem_id+" - user.login");
//					chatRoom.find("")	
//					log.appendTo("#logList");
//				})
		},
		async : false
		,error : function(xhr) {
			console.log(xhr);
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}
