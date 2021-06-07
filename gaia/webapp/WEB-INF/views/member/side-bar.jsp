<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 26, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="card">
	<div class="card-body">
		<div class="card display-webkit-box">
			<img class="mr-3 rounded-circle" id="side_bar_profile_img" height="48" width="48" src="${cPath}/resources/profiles/1.jpeg">
           	<div class="flex-auto">
				<h5 class="m-b-3">${mem_nick }</h5>
                <div class="d-flex flex-items-center flex-wrap">
	                <p class="color-text-tertiary mb-0 mr-3">Your personal account</p>
                </div>
            </div>
        </div>
        <div class="card">
        	<div class="list-group">
     			<span class="list-group-item menu-heading p-r-0">Account setting</span>
	         	<a href="javascript:void()" class="list-group-item text-primary p-r-0 moveButton" data-menu="setting"> Profile <span class="badge badge-primary badge-sm float-right m-t-5">198</span> </a>
	            <a href="javascript:void()" class="list-group-item text-primary p-r-2 moveButton" data-menu="setting/account">Account</a>  
	            <a href="javascript:void()" class="list-group-item text-primary p-r-0 moveButton" data-menu="setting/securityLog">Security log</a>
        	</div>
        </div>
	</div>
</div>

<script>
	$('.moveButton').on('click',  function(){
		event.preventDefault();
		let menuName = $(this).data('menu');
		movePageHistoryMember(menuName);
	})
</script>