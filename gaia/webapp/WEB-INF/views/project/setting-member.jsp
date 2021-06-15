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


<!-- 회원 관리 Modal -->
<div class="modal fade" id="mngProjMem" tabindex="-1" aria-labelledby="mngProjMemLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="mngProjMemLabel">프로젝트 멤버 관리</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="mngMemModal modal-body">
      	<img style="max-width:300px;">
        <div>
        	<label>회원 번호 :</label> 
        	<span id="proj_mem_no"></span>
        </div>
        <div>
        	<label>회원 닉네임 : </label>
        	<span id="proj_mem_nick"></span>
        </div>
        <div>
        	<label>회원 역할 : </label>
        	<select id="proj_mem_role"></select>
        </div>
        <button id="banMemberBtn" class="btn btn-danger">회원 탈퇴</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- 회원 초대 Modal -->
<div class="modal fade" id="inviteMember" tabindex="-1" aria-labelledby="inviteMemberLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="inviteMemberLabel">프로젝트 멤버 초대</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="inviteModal modal-body">
      	<input type="text"><button id="memSearchBtn" class="btn">검색</button>
    	<ul id="memSearchResult">
    	</ul> 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>




<div id="setting-member-template" hidden="hidden">
<!--     	멤버 검색결과 li 시작 -->
    		<li class="searchedMember">
    			<img class="profile" src="/resources/images/profiles/1">
    			<span class="memid">id</span>
    			<span class="memnm">name</span>
    			<span class="memnick">nick</span>
    			<span class="memcity">city</span>
    			<i class="icon-plus"></i>
    		</li>
<!--     		li 끝 -->
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
     <!-- start plus member card -->
     <div class="pluscard col-md-3">
         <div class="card">
         	<div class="profileBox">
              <span style="font-size:10em;text-align:center; width:100%">+</span>
         	</div>
             <div class="card-body">
                 <h5 class="proj-nick card-title">추가 멤버 초대</h5>
                 <p class="proj-role card-text">초대하려면 클릭하세요.</p>
                 <p class="card-text">
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







