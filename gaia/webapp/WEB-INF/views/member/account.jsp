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
<div class="container-fluid">
	
	<div class="row menu">
		<div class="col-lg-4 col-xl-3">
			<jsp:include page="side-bar.jsp"/>
		</div>
		<div class="col-lg-8 col-xl-9">
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
                            	<input type="password" name="old_pass" id="old_pass" class="form-control input-default" placeholder="Input old password" required>
		            		</div>
		            		<div class="card newPassword">
		         		    	<h4 class="card-title">New passowrd</h4>
                            	<input type="password" name="mem_pass" id ="mem_pass" class="form-control input-default password" placeholder="8자 ~ 15자 사이로 작성해 주세요." required>
		            		</div>
		            		<div class="card confirmNewPassword">
	         		    		<h4 class="card-title">Confirm new passowrd <span hidden="hidden">✓</span></h4>
                            	<input type="password" name="confirm_pass" id="confirm_pass" class="form-control input-default password" placeholder="Input confirm new password"required>
		            		</div>
		            		<div class="outline-button">
				            	<button type="button" class="btn mb-1 btn-dark changeAccountBtn" id="changePassBtn" value="mem_pass">Change password</button>
				            </div>
		            	</form>
	                    <div class="toolbar Subhead mt-4" role="toolbar" hidden="hidden">
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
loadMemberInfo_account();
</script>