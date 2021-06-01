<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid container-lg container-xl">
<div class = "alert">
	<p> update success</p>
</div>
	<div class="row justify-content-end page-path">
		<div class="col col-md-3">
			<ol class="breadcrumb">
			    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
			    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
			</ol>
		</div>
	</div>
	<div class="row menu">
		<div class="col-lg-4 col-xl-3">
			<jsp:include page="side-bar.jsp"/>
		</div>
		<div class="col-lg-8 col-xl-9">
			<div class="card">
				<div class="card-body">
				    <div class="basic-list-group ">
			            <div class="toolbar Subhead mt-4 mb-5 my-5" role="toolbar">
			            	<h2>Change username</h2>
			            </div>
			            <div class="card input-control">
				            <h4 class="card-title">Name</h4>
			            	<input type="text" placeholder="input default" class="form-control mem_nm">
			            </div>
                     	<div class="toolbar Subhead mt-4 mb-5 my-5" role="toolbar">
			            	<h2>Change password</h2>
		            	</div>
		            	<form class="basic-form input-control" name="profile">
		            		<div class="card oldPassword">
		         		    	<h4 class="card-title">Old passowrd</h4>
                            	<input type="text" name="old_password" class="form-control " placeholder="Input Default">
		            		</div>
		            		<div class="card newPassword">
		         		    	<h4 class="card-title">New passowrd</h4>
                            	<input type="text" name="mem_pass" class="form-control input-default" placeholder="Input Default">
		            		</div>
		            		<div class="card confirmNewPassword">
		         		    	<h4 class="card-title">Confirm new passowrd</h4>
                            	<input type="text" name="confirm_pass" class="form-control input-default" placeholder="Input Default">
		            		</div>
		            	</form>
	                    <div class="toolbar Subhead mt-4 mb-5 my-5" role="toolbar">
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
var loadMemberInfo = function(){
	$.ajax({
		url : getContextPath()+"/restapi/member/members/member/",
		type : 'get',
		success : function(res) {
			console.log(JSON.stringify(res));
			let nm = $(".mem_nm").attr('placeholder', res.mem_nm);
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
loadMemberInfo();
function updateProfile(){
	event.preventDefault();
	var profile  = $(".basic-form").serializeJSON();
	$.ajax({
		url : getContextPath()+"/restapi/member/members/",
		method : 'post',
		data : profile,
		success : function(res) {
			console.log(res);
			window.scrollTo({top:0, left:0, behavior:'smooth'});
			$(".alert").slideToggle(1000)
						.delay(2000)
						.slideUp(500);
		},
		async : false,
		error : function(xhr) {
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

</script>