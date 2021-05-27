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
	<div class="row justify-content-end page-path">
		<div class="col col-md-3">
			<ol class="breadcrumb">
			    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
			    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
			</ol>
		</div>
	</div>
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
	                    <form class="basic-form">
			           		<div class="row">
			            		<div class="col-md-8">
				            		<h4 class="card-title">NickName</h4>
			                        <div class="form-group">
			                            <input type="text" class="form-control input-default" placeholder="Input Default">
			                        </div>
				            		<h4 class="card-title">Bio</h4>
			                        <div class="form-group">
			                            <textarea class="w-100 p-20 l-border-1" name="" id="" cols="30" rows="5" placeholder="It's really an amazing.I want to know more about it..!"></textarea>
			                        </div>
				            		<h4 class="card-title">Working-City</h4>
			                        <div class="form-group">
			                            <input type="text" class="form-control input-default" placeholder="Input Default">
			                        </div>
			                        <h4 class="card-title">Tel</h4>
			                        <div class="form-group">
			                            <input type="text" class="form-control input-default" placeholder="Input Default">
			                        </div>
			                        <h4 class="card-title">Status</h4>
			                        <div class="form-group">
			                            <input type="text" class="form-control input-default" placeholder="Input Default">
			                        </div>
					                <hr>
					                <p>
					                	<button type="submit" class="btn btn-primary">Update profile</button>
					                </p>
				        	    </div>
				            	<div class="col-md-4">
				            		<div class="img-grid-right">
					            		<label class="d-block"> Profile picture</label>
					            		<img class="mr-3 rounded-circle" height="200" width="200" src="${cPath}/resources/assets/images/member/profile.png">
				            		</div> 
				            	</div>
	           				</div>
	                    </form>
					</div>
		    	</div>
			</div>
		</div> <!-- col-lg-8 col-xl-9 END -->
	</div>
</div>