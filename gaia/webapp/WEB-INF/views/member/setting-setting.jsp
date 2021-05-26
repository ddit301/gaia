<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<style>
	.flex-items-center {
	    align-items: center!important;
	}
    .flex-justify-between{
	    justify-content: space-between!important;
    }
    .menu-heading{
	    display: block;
	    margin-top: 0;
	    margin-bottom: 0;
	    font-size: inherit;
	    font-weight: 600;
	    color: var(--color-menu-heading-text);
	    border-bottom: 1px solid var(--color-border-secondary);
	}
	.menu-item{
		position: relative;
	    display: block;
	    padding: 8px 16px;
	    color: var(--color-text-primary);
	    border-bottom: 1px solid var(--color-border-secondary);
	}
	.d-block {
		display: block!important;
	}
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div class="container-fluid">
	<div class="d-md-flex flex-items-center flex-justify-between mt-1 mb-4">
		<div class="d-flex flex-items-center mb-2 mb-md-0">
        	<img class="mr-3 rounded-circle" height="48" width="48" src="${cPath}/resources/assets/images/member/profile.png">
           	<div class="flex-auto">
				<h5 class="m-b-3">Ingredia Nutrisha</h5>
                <div class="d-flex flex-items-center flex-wrap">
                <p class="color-text-tertiary mb-0 mr-3">Your personal account</p>
                <details class="dropdown details-overlay details-reset">
                	<summary> details</summary>
                </details>
                </div>
            </div>
        </div>
    	<p class="m-b-2">20 May 2018</p>
	</div>
    <div class="row basic-list-group ">
        <div class="col-md-3 pr-md-4">
            <div class="list-group">
          <span class="list-group-item menu-heading p-r-0">Account setting</span>
            	<a href="email-inbox.html" class="list-group-item text-primary p-r-0"> Profile <span class="badge badge-primary badge-sm float-right m-t-5">198</span> </a>
                <a href="#" class="list-group-item p-r-0">Account</a>  
                <a href="#" class="list-group-item p-r-0">Emails <span class="badge badge-danger badge-sm float-right m-t-5">47</span> </a>
                <a href="#" class="list-group-item p-r-0">Security log</a>
                <a href="#" class="list-group-item p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>Trash</a>
            </div>
            <div class="list-group">
            	<a href="#" class="list-group-item "><span class="fa fa-briefcase f-s-14 mr-2"></span>Work</a>  
            	<a href="#" class="list-group-item "><span class="fa fa-sellsy f-s-14 mr-2"></span>Private</a>  
            	<a href="#" class="list-group-item "><span class="fa fa-ticket f-s-14 mr-2"></span>Support</a>  
            	<a href="#" class="list-group-item "><span class="fa fa-tags f-s-14 mr-2"></span>Social</a>
            </div>
        </div>
        <div class="col-md-9">
            <div class="toolbar" role="toolbar">
            	<h2>Public profile</h2>
            </div>
            <hr>
            <div class="read-content">
	            <div class="row">
	            	<div class="col-md-8">
	                    <form class="basic-form">
		            		<h4 class="card-title">NickName</h4>
	                        <div class="form-group">
	                            <input type="text" class="form-control input-default" placeholder="Input Default">
	                        </div>
		            		<h4 class="card-title">Name</h4>
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
	                        <h4 class="card-title">Status</h4>
	                        <div class="form-group">
	                            <input type="text" class="form-control input-default" placeholder="Input Default">
	                        </div>
			                <hr>
			                <p>
			                	<button type="submit" class="btn btn-primary">Update profile</button>
			                </p>
	                    </form>
		            </div>
            	<div class="col-md-4">
            		<label class="d-block"> Profile picture</label>
            		<img class="mr-3 rounded-circle" height="200" width="200" src="${cPath}/resources/assets/images/member/profile.png">
            	</div>
           	</div>
            </div>
        </div>
       </div>
    </div>
</div>
</div>
<!-- #/ container -->
</div>