<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <style>
    .btn-dark:hover{
    	background-color:#7b7b7b;
    }
    </style>
<div class="container-fluid container-lg container-xl">
	
	<div class="row menu">
		<div class="col-lg-4 col-xl-3">
			<jsp:include page="side-bar.jsp"/>
		</div>
		<div class="col-lg-8 col-xl-9">
			<div class="row justify-content-end page-path">
				<div class="col col-md-3">
					<ol class="breadcrumb">
					    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
					    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
					</ol>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
				    <div class="form-group ">
			            <div class="toolbar Subhead mt-4 " role="toolbar">
			            	<h2>Change username</h2>
			            </div>
			            <p style="font-weight:bold">Changing your username can have unintended side effects.</p>
			            <div class="card input-control">
				            <h4 class="card-title">Name</h4>
			            	<input type="text" placeholder="input default" id="mem_nm" class="form-control input-default">
			            </div>
			            <div class="outline-button">
			            	<button type="button" class="btn mb-1 btn-dark changeAccountBtn" id="changeUserNameBtn" value="mem_nm">Change username</button>
			            </div>
                     	<div class="toolbar Subhead mt-4 " role="toolbar">
			            	<h2>Change password</h2>
		            	</div>
		            	<form class="basic-form input-control password_form" name="password">
		            		<div class="card oldPassword">
		         		    	<h4 class="card-title">Old passowrd</h4>
                            	<input type="text" name="old_pass" id="old_pass" class="form-control input-default" placeholder="Input Default" required>
		            		</div>
		            		<div class="card newPassword">
		         		    	<h4 class="card-title">New passowrd</h4>
                            	<input type="text" name="mem_pass" id ="mem_pass" class="form-control input-default password" placeholder="Input Default" required>
		            		</div>
		            		<div class="card confirmNewPassword">
	         		    		<h4 class="card-title">Confirm new passowrd <span hidden="hidden">✓</span></h4>
                            	<input type="text" name="confirm_pass" id="confirm_pass" class="form-control input-default password" placeholder="Input Default"required>
		            		</div>
		            		<div class="outline-button">
				            	<button type="button" class="btn mb-1 btn-dark changeAccountBtn" id="changePassBtn" value="mem_pass">Change password</button>
				            </div>
		            	</form>
	                    <div class="toolbar Subhead mt-4" role="toolbar">
			            	<h2>Delete Account</h2>
			            	<p>Your account is currently an owner in these organizations: DDIDTeam1, DDITHelloWorld, and ddit301
								You must remove yourself, transfer ownership, or delete these organizations before you can delete your user.</p>
			            </div>
					</div>
		    	</div>
			</div>
		</div> <!-- col-lg-8 col-xl-9 END -->
	</div>
</div>
<script>
function confirmAlert(ajaxEvent, form_data){
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
//이름 변경.
var changeUserNameBtn = $(".changeAccountBtn").on("click",function(){
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
// 페이지로딩 ajax / no need
var loadMemberInfo = function(){
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
loadMemberInfo();

function updateName(form_data){
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
// password
function updatePass(form_data){
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

function valid(){
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

$(".password_form").validate({
	  errorElement: "span"
});

$(".password").on("keyup", function(){
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
</script>