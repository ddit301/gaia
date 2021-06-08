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
	
	<div class="row menu">
		<div class="col-lg-4 col-xl-3">
			<jsp:include page="side-bar.jsp"/>
		</div>
		<div class="col-lg-8 col-xl-9">
			<div class="row justify-content-end">
				<div class="col col-md-3">
					<ol class="breadcrumb">
					    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
					    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
					</ol>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
				    <div class="basic-list-group ">
			            <div class="toolbar" role="toolbar">
			            	<h2>Public profile</h2>
			            </div>
			            <hr>
		           		<div class="row">
		            		<div class="col-md-8">
			                    <form class="basic-form" name="profile" >
			                    	<input type="hidden" value="put" name="_method">
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
				                        	<div>
				                        	</div>
				                        </div>
						                <hr>
						                <p>
						                	<button type="submit" onclick="updateProfile();" class="btn btn-primary">Update profile</button>
						                </p>
					                </div>
	        	   				</form>
			        	    </div>
			            	<div class="col-md-4">
				            	<form class="basic-form profile_image" id="profile_imageForm" name="member" enctype="multipart/form-data" >
				            		<input type="hidden" value="put" name="_method">
				            		<div class="img-grid-right">
					            		<label class="d-block"> Profile picture</label>
					            		<img class="mr-3 rounded-circle profile_img" height="200" width="200" src= "${cPath}/resources/profiles/1.jpeg" >
					            		<button type="button" class="btn mb-1 btn-outline-info edit-profile">Edit</button>
					            		<input class="form-control btn mb-1 btn-outline-info" id="upload_image" type="file" name="files" accept="image/*" hidden="hidden" />
				            		</div>
			            		</form>
			            	</div>
		        	    </div>
					</div>
		    	</div>
			</div>
		</div> <!-- col-lg-8 col-xl-9 END -->
	</div>
</div>

<script>
// 프로필 사진 변경 ajax
$(".edit-profile").on("click", function(){
	$("#upload_image").click();
})
var imageSelect = $("#upload_image").on("change", function(){
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
// 페이지로딩 ajax
var loadMemberInfo = function(){
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
loadMemberInfo();
// 프로필 설정 ajax
function updateProfile(){
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

</script>