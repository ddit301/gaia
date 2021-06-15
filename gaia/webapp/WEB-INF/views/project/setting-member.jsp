<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

            <div class="container-fluid">
                <div class="col-12 m-b-30">
                    <h4 class="d-inline">Members</h4>
                    <div id="proj-mem-list" class="row">
                    </div>
                </div>
            </div>

<div id="setting-member-template" hidden="hidden">
     <!-- start member card -->
     <div class="memcard col-md-3">
         <div class="card">
         	<div class="profileBox">
              <img class="img-fluid" src="${cPath }/resources/images/profiles/1" alt="">
         	</div>
             <div class="card-body">
                 <h5 class="proj-nick card-title">닉네임</h5>
                 <p class="proj-role card-text">직책</p>
                 <p class="card-text">
                 	since <small class="proj-in-date text-muted">가입일</small>
                 </p>
             </div>
         </div>
     </div>
     <!-- End card -->
</div>            

<script>
	$(function(){
		loadProjectMembers();
	})
</script>







