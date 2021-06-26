<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container-fluid">
    <div class="row">
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
		           		<div class="row">
		            		<div class="col-md-8">
			                    <form class="basic-form" name="profile" >
			                    	<input type="hidden" value="put" name="_method">
				            		<div class="ml-3 form-group">
				                        <div class="card mem_nick">
						            		<h4 class="card-title">Nickname</h4>
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
				                        <div class="card mem_tel">
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
					            		<img id="prof-change" class="mb-3 rounded-circle profile_img" style="width: 100%;" onerror="imgOnErr()" >
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
scrollUp();
loadMemberInfo_profile();
</script>