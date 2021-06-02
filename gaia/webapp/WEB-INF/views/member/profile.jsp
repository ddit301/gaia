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
			            <div class="toolbar" role="toolbar">
			            	<h2>Public profile</h2>
			            </div>
			            <hr>
	                    <form class="basic-form" name="profile"  >
	                    	<input type="hidden" value="put" name="_method">
			           		<div class="row">
			            		<div class="col-md-8">
				            		<div class="ml-3 form-group">
				                        <div class="card mem_nick">
						            		<h4 class="card-title">NickName</h4>
				                            <input type="text" name="mem_nick" class="form-control input-default" placeholder="Input Default">
				                        </div>
				                        <div class="card mem_bio">
						            		<h4 class="card-title">Bio</h4>
				                            <textarea class="w-100 p-20 l-border-1" name="mem_bio" cols="30" rows="5" placeholder="It's really an amazing.I want to know more about it..!"></textarea>
				                        </div>
				                        <div class="card mem_working_city">
						            		<h4 class="card-title">Working-City</h4>
				                            <input type="text" class="form-control input-default" name="mem_working_city" placeholder="Input Default">
				                        </div>
				                        <div class="card mem_tell">
					                        <h4 class="card-title">Tel</h4>
				                            <input type="text" class="form-control input-default" name="mem_tel" placeholder="Input Default">
				                        </div>
				                        <div class="card mem_status">
				                        	<h4 class="card-title">Status</h4>
				                        	  <label for="huey"><input type="radio" id="vs" name="mem_status" value="va" >휴가중</label>
				                        	  <label for="huey"><input type="radio" id="si" name="mem_status" value="si" >아픔</label>
				                        	  <label for="huey"><input type="radio" id="wh" name="mem_status" value="wh" >재택 근무</label>
				                        	  <label for="huey"><input type="radio" id="fc" name="mem_status" value="fc" >방해금지</label>
				                        	  <label for="huey"><input type="radio" id="ab" name="mem_status" value="ab" >부재중</label>
				                        	  <label for="huey"><input type="radio" id="ow" name="mem_status" value="ow" >외근</label>
				                        	  <label for="huey"><input type="radio" id="wf" name="mem_status" value="wf" >가족과의 시간</label>
				                        	  <label for="huey"><input type="radio" id="rm" name="mem_status" value="rm" >휴면회원 </label>
				                        	  <label for="huey"><input type="radio" id="active" name="mem_status" value="active" checked>활동중</label>
				                        	  <label for="huey"><input type="radio" id="off" name="mem_status" value="off" >비활동중</label>
				                        </div>
						                <hr>
						                <p>
						                	<button type="submit" onclick="updateProfile();" class="btn btn-primary">Update profile</button>
						                </p>
					                </div>
				        	    </div>
				        	    </form>
				            	<div class="col-md-4">
				            		 <form class="basic-form" name="profile_img"  >
					            		<div class="img-grid-right">
						            		<label class="d-block"> Profile picture</label>
						            		<img class="mr-3 rounded-circle" height="200" width="200" id="profile_img"src="${cPath}/resources/assets/images/member/profile.png">
						            		<button type="button" class="btn mb-1 btn-outline-info edit-profile">Edit</button>
						            		<input class="form-control btn mb-1 btn-outline-info" id="upload_image" type="file" name="mem_pic_file_name" accept="image/*" hidden="hidden"/>
					            		</div>
				            		</form> 
				            	</div>
					</div>
		    	</div>
			</div>
		</div> <!-- col-lg-8 col-xl-9 END -->
	</div>
</div>
<script>
$(".edit-profile").on("click", function(){
	$("#upload_image").click();
})
let imageSelect = $("#upload_image").on("change", function(){
	imagePath = $("#upload_image").val()
	$.ajax({
		url : getContextPath()+"/restapi/member/members/member" ,
		method : 'post',
		data : imagePath, 
		success : function(res) {
			$("#profile_img").attr("src", res);
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
})

var loadMemberInfo = function(){
	$.ajax({
		url : getContextPath()+"/restapi/member/members/member" ,
		type : 'get',
		success : function(res) {
			console.log(JSON.stringify(res));
			let placeholder = $(".card.mem_nick").children('input').attr('placeholder', res.mem_nick);
			let bio = $(".card.mem_bio").children('textarea').attr('placeholder', res.mem_bio);
			let workingCity = $(".card.mem_working_city").children('input').attr('placeholder', res.mem_working_city);
			let tel = $(".card.mem_tel").children('input').attr('placeholder', res.mem_tel);
			let status = $(".card.mem_status").children('input').attr('placeholder', res.mem_status);
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
	var status = $("input[type='radio'][name='status']:checked").val();
	console.log(profile);
	$.ajax({
		url : getContextPath()+"/restapi/member/members/",
		method : 'post',
		data : profile, 
		success : function(res) {
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