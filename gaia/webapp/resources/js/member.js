

// 페이지 열릴때 멤버 관련된 url 이란 판단이 되면, memberMovePageHistory 발동.
$(function() {
	if (memberPageParam) {
		memberMovePage(memberPageParam);
	}
})
// char or chat/1
const memberMovePageHistory = function(pageParam) {
	var url = getContextPath() + '/' + mem_id + '/' + pageParam;
	history.pushState('member-' + pageParam, null, url);
	memberMovePage(pageParam);
}

const memberMovePage = function(pageParam) {
	let path = getContextPath() + "/view/member/";
	let index;
	// member 페이지에서는 horizontal로만 보여줍니다.
	new quixSettings({
		layout: "horizontal" // vertical or horizontal
	});
	// sideBar와 햄버거 메뉴를 숨깁니다 - project에 종속되기 떄문.
	$('.nk-sidebar').prop('hidden', 'true');
	$('.nav-control').prop('hidden', 'true');

	if (!pageParam) {
		pageParam = 'overview';
	}
	// setting으로 요청이 들어오면 profile로 변경시키기.(setting/profile -> setting으로만 표시 )
	if (pageParam == "setting") {
		pageParam = 'profile';
	}
	// profile.jsp에서 'setting/account'로 pageParam을 넘김.
	if (pageParam.includes("setting/")) {
		index = pageParam.indexOf("/");
		pageParam = pageParam.slice(index + 1);
	}
	$.ajax({
		url: path + pageParam,
		type: 'get',
		data: {
			'mem_id': mem_id
		},
		success: function(res) {
			$('.content-body').html(res);
		},
		error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'html'
	})
}
////////////////////////////////////////////////////
//
// overview.jsp
//
////////////////////////////////////////////////////

// 페이지 로딩 시 retrieveMemberProjectIssue(mem_no) 요청 
const loadMemberInfo_overview = function() {
	let need = "MemberProjectIssue";
	$.ajax({
		url: getContextPath() + "/restapi/member/members",
		type: 'get',
		data: { "need": need },
		success: function(res) {
			let memberInfo = res.search;
			let length;
			let proj_manager = "";
			let profile_img = $("#profile_img").attr("src", getProfilePath(memberInfo.mem_pic_file_name));
			let cnt = 0;
			$.each(memberInfo.projectList, function(i, v) {
				let url = v.url;
				if(!!v.projectManager.mem_id){ proj_manager = v.projectManager.mem_id; }
				$.each(v.issueList, function(j, iss) {
					if(!!iss.issue_sid){
						cnt += 1;
						let issue = $("#issueTemplate").children(".issue").clone();
						let timeUploaded = iss.historyList[0].issue_his_date;
						let timeAgo = moment(timeUploaded, "YYYYMMDD").fromNow();
						let proj_manager_link = "<a href=" + getContextPath() + "/" + proj_manager + ">" + proj_manager + "</a>";
						let proj_link = "<a href=" + getContextPath() + "/" + proj_manager+"/"+v.proj_title + ">" + "/" + v.proj_title + "</a>";
						let issue_link = "<a href=" + getContextPath() + "/" + proj_manager+"/"+v.proj_title + "/issue/"+ iss.issue_sid + ">" + "/" + iss.issue_sid + "</a>";
						issue.attr("data-issue_sid", iss.issue_sid);
						issue.find(".issue-card-top").children().first().html(proj_manager_link + proj_link + issue_link);
	
						issue.find(".issue-card-top").children().last().text(iss.issue_title);
						issue.find(".issue-card-mid").find(".issue_date").text(timeAgo);
						issue.find(".issue-card-mid").find(".fixer_id").text("by " + iss.historyList[0].historyWriter.mem_nick);
						issue.find('.issue-card-bot').text(iss.historyList[0].issue_his_cont);
	
						issue.appendTo("#issues");
					}
				});
			});
			if (cnt % 2) {
				$("#issueTemplate").children(".issue").clone().appendTo("#issues");
			}
			if(cnt==0){
				for(i=0;i<4;i++){
					$("#issueTemplate").children(".issue").clone().appendTo("#issues");
				}
			}
			$("#mem_bio").text(memberInfo.mem_bio);
			$('#mem_nick').find('span').text(memberInfo.mem_nick);
			$('#mem_work_city').find('span').text(memberInfo.mem_working_city);
			$('#mem_tel').find('span').text(memberInfo.mem_tel);
		}
		, async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

////////////////////////////////////////////////////
//
// profile.jsp
//
////////////////////////////////////////////////////

// profile_img 변경 form-data
// 프로필 사진 변경 버튼 클릭 시 imageSelect function호출 
$(function() {
	$(".content-body").on("click", ".edit-profile", function() {
		$("#upload_image").click();
	})
})

// 페이지 로딩 시 retrieveMemberProjectIssue(mem_no) 요청 
const loadMemberInfo_profile = function() {
	$.ajax({
		url: getContextPath() + "/restapi/member/members",
		type: 'get',
		success: function(data) {
			res = data.search;
			msl = data.memberStatusList
			let placeholder = $(".card.mem_nick").children('input').attr('placeholder', res.mem_nick);
			let bio = $(".card.mem_bio").children('textarea').attr('placeholder', res.mem_bio);
			let workingCity = $(".card.mem_working_city").children('input').attr('placeholder', res.mem_working_city);
			let tel = $(".card.mem_tel").children('input').attr('placeholder', res.mem_tel);
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
			let memList = ""
			for (i in msl) {
				if (i % 4 == 0) { memList += '<br>' }
				if (res.mem_status == msl[i].COM_CODE_NM) {
					memList += '<label for="' + msl[i].COM_CODE + '""><input type="radio" id="' + msl[i].COM_CODE + '" name="mem_status" value=' + msl[i].COM_CODE + ' checked>&nbsp' + msl[i].COM_CODE_NM + '</label>&nbsp&nbsp';
				} else {
					memList += '<label for="' + msl[i].COM_CODE + '""><input type="radio" id="' + msl[i].COM_CODE + '" name="mem_status" value=' + msl[i].COM_CODE + ' >&nbsp' + msl[i].COM_CODE_NM + '</label>&nbsp&nbsp';
				}
			}
			$(".mem_status").children("div").html(memList);
		},
		async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},

		dataType: 'json'
	})
}


const imageSelect = $(".content-body").on("change", "#upload_image", function() {
	var formdata = $("#profile_imageForm")[0];
	var form_data = new FormData(formdata);
	// input으로 put을 줌. 
	// need로 분별하기.
	form_data.append("need", "profileImg");
	$.ajax({
		url: getContextPath() + "/restapi/member/members",
		type: 'post',
		data: form_data,
		processData: false,
		contentType: false,
		success: function(res) {
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
			toastr.success('Update에 성공했습니다.')
		}
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		cache: false,
		dataType: 'json'
	})
})
// 프로필 설정 ajax
const updateProfile = function() {
	event.preventDefault();
	var profile = $(".basic-form").serializeJSON();
	$.ajax({
		url: getContextPath() + "/restapi/member/members/",
		method: 'post',
		data: profile,
		success: function(res) {

			window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
			toastr.success('Update에 성공했습니다.')
		},
		async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

////////////////////////////////////////////////////
//
// account.jsp
//
////////////////////////////////////////////////////

$(function() {
	$(".password_form").validate({
		errorElement: "span"
	});

	$(".content-body").on("keyup", ".password", function() {
		let mem_pass = $("#mem_pass").val();
		let confirm_pass = $("#confirm_pass").val();
		if (mem_pass) {
			if (mem_pass == confirm_pass) {
				$(".confirmNewPassword").find("span").prop("hidden", false)
			} else {
				$(".confirmNewPassword").find("span").prop("hidden", true)
			}
		}
	})
})

// 페이지로딩 ajax / no need
const loadMemberInfo_account = function() {
	$.ajax({
		url: getContextPath() + "/restapi/member/members",
		type: 'get',
		success: function(res) {
			$("#mem_nm").attr('placeholder', res.search.mem_nm);
			$(".profile_img").attr("src", getProfilePath(mem_pic_file_name));
		},
		async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

//이름 변경 버튼 바인딩
const changeUserNameBtn = $("body").on("click",".changeAccountBtn", function() {
	event.preventDefault();
	let form_data = { "_method": "put" };
	let pass = false;
	let passLength = $("#mem_pass").val().length;
	if ($(this).val() == "mem_nm") {
		form_data["mem_nm"] = $("#" + $(this).val() + "").val();
		confirmAlert("name", form_data);
	} else {
		$(".confirmNewPassword").find("span").prop("hidden", true)
		if(7 < mem_pass.length  && mem_pass.length < 16){
			let form_data = $(".password_form").serializeJSON();
			form_data["_method"] = "put";
			form_data["need"] = "mem_password";
	
			if (valid(pass) == true) {
				confirmAlert("pass", form_data);
			}
		}else{
			swal.warning({
				title : "글자 수를 맞춰주세요.",
				text: "password는 8자 이상 15자 이상이어야 합니다!!"
			});
		}
	}
})
// swal 확인 js
const confirmAlert = function(ajaxEvent, form_data) {
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
			ajaxEvent: ajaxEvent == "name" ? updateName(form_data) : updatePass(form_data);
		}
	})
}

// 이름 변경함수
const updateName = function(form_data) {
	form_data["need"] = "mem_nm";
	$.ajax({
		url: getContextPath() + "/restapi/member/members/",
		method: 'post',
		data: form_data,
		success: function(res) {
			window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
			$("#mem_nm").val("");
			$("#mem_nm").attr("placeholder", res.member.mem_nm);
			toastr.success('이름 변경에 성공했습니다.')
			swal.success();
		},
		enctype: 'multipart/form-data',
		async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

// 비밀번호 변경함수
const updatePass = function(form_data) {
	if (!$(".confirmNewPassword").find("span").prop("hidden") && !!$("#old_pass").val()) {
		console.log(form_data);
		$.ajax({
			url: getContextPath() + "/restapi/member/members/",
			method: 'post',
			data: form_data,
			success: function(res) {
				if (res.sr == "OK") {
					window.scrollTo({ top: 0, left: 0, behavior: 'smooth' });
					toastr.success('Update에 성공했습니다.')
					swal.success();
				} else if (res.sr == "NOTEXIST") {
					swal.error({
						title: res.sr,
						text: "비밀번호를 제대로 입력하세요."
					});
				} else {
					swal.error({
						title: res.sr,
						text: "잘못된 비밀번호입니다."
					});
				}
			},
			enctype: 'multipart/form-data',
			async: false
			, error: function(xhr, error, msg) {
				ajaxError(xhr, error, msg)
			},
			dataType: 'json'
		})
	}
}

const valid = function() {
	if (!$("#old_pass").val() || !$("#mem_pass").val() || !$("#confirm_pass").val()) {
		swal.warning({
			text: "빈칸을 모두 채워주세요!!"
		});
		return false;
	} else if (!$(".confirmNewPassword").val() && $(".confirmNewPassword").find("span").prop("hidden")) {
		swal.warning({
			text: "new password와 confirm new password가 다릅니다!!"
		});
		return false;
	}
	else if ($(".confirmNewPassword").find("span").prop("hidden")) {
		swal.warning({
			text: "confirm new password를 확인해 주세요!!"
		});
		return false;
	} else {
		return pass = true;
	}
}


////////////////////////////////////////////////////
//
// securityLog.jsp
//
////////////////////////////////////////////////////
$(function() {
	$('.profile_img_label').tooltip();
	$('.content-body').on('click', '.pagination .page-link', function() {
		event.preventDefault();
		let dataBtn = $(this).data('btn');
		if (dataBtn == 'prev') {
			currentPage = parseInt(startPage) - 1;
		} else if (dataBtn == 'next') {
			currentPage = parseInt(endPage) + 1;
		} else {
			if (currentPage == $(this).text()) {
				return false;
			} else {
				currentPage = $(this).text();
			}
		}
		window.scrollTo({ top: 0, left: 0, behavior: 'auto' });
		loadIssueList();
	})
})

// 페이지 로딩 시 불러오는 데이터
const loadMemberInfo_log = function() {
	$.ajax({
		url: getContextPath() + "/restapi/member/members",
		data: { "need": "logList" },
		type: 'get',
		success: function(res) {
			$(".profile_img").attr("src", getProfilePath(res.search.mem_pic_file_name));
			$(".profile_img_label").attr("title", "View " + res.search.mem_id + "'s profile");
			$(".profile_img_label").siblings("input").val(res.search.mem_id);
			$.each(res.logList, function(i, v) {
				let log = $("#logTemplate").children(".log").clone();
				let timeAgo = moment(v.date, moment.HTML5_FMT.DATETIME_LOCAL_SECONDS).fromNow();
				let ip = v.ip + '<span class="vertical-separator"></span>' + timeAgo;
				log.find(".log-card-ip").html(ip);
				log.find(".log-card-actor").children("a").text(res.search.mem_id + " - user.login");
				log.appendTo("#logList");
			})
		},
		async: false
		, error: function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType: 'json'
	})
}

const toOverview = function() {
	$('.profile_img_label').tooltip('hide');
	memberMovePageHistory('overview');
}

////////////////////////////////////////////////////
//
// personalPage.jsp
//
////////////////////////////////////////////////////

