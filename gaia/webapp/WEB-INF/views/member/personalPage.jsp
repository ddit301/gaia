<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* Jun 19, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="${cPath }/resources/assets/css/personal.css" rel="stylesheet"> 

<div class="container-fluid personal-profile">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card side-position-fixed" id="side-profile"> 
                <div class="card-body">
                    <div class="media align-items-center mb-4">
                        <img class="mr-3 rounded-circle" onerror="imgOnErr()" width="80" height="80" alt="">
                        <div class="media-body">
                            <h3 class="mb-0">id</h3>
                            <p class="text-muted mb-0"></p>
                        </div>
                    </div>
                    <h4>About Me</h4>
                    <p class="text-muted" id="mem_bio">bio</p>
                    <ul class="card-profile__info">
                        <li class="mb-1"><strong class="text-dark mr-4"><i class="fa fa-star gradient-1-text"></i></strong> <span>닉네임</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-location-pin icons"></i></strong> <span>지역</span></li>
                    </ul>
                    	<h4> personal history</h4>	
                    <ul class="card-profile__info">
                        <li class="mb-1"><strong class="text-dark mr-4"><i class="icon-notebook icons"></i></strong> <span>이슈담당</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-bubbles icons"></i></strong> <span>참여 채팅수</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-note icons"></i></strong> <span>작성이슈수</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-pencil icons"></i></strong> <span>작성뉴스수</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-bulb icons"></i></strong> <span>작성마일스톤수</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-plus icons"></i></strong> <span>가입일</span></li>
                        <li><strong class="text-dark mr-4"><i class="icon-flag icons"></i></strong> <span>상태</span></li>
                    </ul>
                </div>
             
                
                
            </div>  
        </div>
		<div class="col-lg-8 col-xl-9 row" id="projCont">
			<div class="card col-md-12 row" id="projBody">
				<div class="projHeader col-md-12">
				<h1>Project</h1>
				</div>
				
<!-- 				여기에 내용물들을 작성하면 될 듯 합니다. -->
		    	<div id="personal-page-content" class="container-fluid row">
		    		<div class="row col-md-12">
		    		<div id="personal-page-body" class="container-fluid col-md-12 row">
		    			
		    		</div>
		    		</div>
				 </div>
		    	
		    		
		       
		    </div>
		</div>
    </div>
</div>
<!-- hidden -->
<div id="issueTemplate" hidden = "hidden">
	<div class="col-xl-6 issue" >
	    <div class="card">
	        <div class="card-body">
	         	<div class = "issue-card-top">
	            	<p class="mb-sm-0">You/don't/have/more/issues</p>
	            	<h3>?</h3>
	            </div> 
	            <div class="row issue-card-mid">
	             	<div class="col-md-6">
	                	<small class="text-muted issue_date"></small>
	             	</div>
	           	 	<div class="col-md-6 media-reply__link">
		                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
		                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
		                <button class="btn btn-transparent p-0 ml-3 font-weight-bold fixer_id">by ${mem_id }</button>
	             	</div>
	             </div>
	             <p class="issue-card-bot">담당하고 있는 이슈에 새로운 소식이 존재하지 않습니다.</p>
	    	</div>
	    </div>
	</div>
</div>
<script>
$.ajax({
	url : getContextPath() + 'restapi/member/members/personalProfile.do',
	method : 'get',
	data : {
		'mem_id' : getCurrentUrl().substring(1)
	},
	success : function(res) {
		member = res[0];
		let profileArea = $('.personal-profile');
		profileArea.find('.rounded-circle').attr('src', getProfilePath(member.MEM_PIC_FILE_NAME));
		profileArea.find('.media-body').find('h3').text(member.MEM_ID);
		profileArea.find('.media-body').find('p').eq(0).text(member.MEM_NM);
		profileArea.find('.card-body').find('p').eq(1).text(member.MEM_BIO);
		profileArea.find('.card-profile__info').find('span').eq(0).text(member.MEM_NICK);
		profileArea.find('.card-profile__info').find('span').eq(1).text(member.MEM_WORKING_CITY);
		profileArea.find('.card-profile__info').find('span').eq(2).text('issue assignee : ' + member.ISSUEASSIGNEECNT);
		profileArea.find('.card-profile__info').find('span').eq(3).text('chat count : ' + member.MEMCHATCNT);
		profileArea.find('.card-profile__info').find('span').eq(4).text('issue count : ' + member.ISSUECNT);
		profileArea.find('.card-profile__info').find('span').eq(5).text('news count : ' + member.NEWSCNT);
		profileArea.find('.card-profile__info').find('span').eq(6).text('milestone count : ' + member.MILESTONECNT);
		profileArea.find('.card-profile__info').find('span').eq(7).text('sign date : ' + moment(member.MEM_SIGN_DATE).format('YYYY-MM-DD'));
		profileArea.find('.card-profile__info').find('span').eq(8).text('status : ' + member.MEM_STATUS);
		
		
		/*
		
		위까지 샘플 코드 였습니다. 멤버에 관한건 member. 으로 쓰시면 됩니다. 변수 목록은 아래와 같습니다.
		
		ISSUEASSIGNEECNT: 5 이슈 담당자로 지정된 카운트 입니다.
		ISSUECNT: 115 작성한 이슈 카운트 입니다.
		MEMCHATCNT: 6 참여중인 채팅방 갯수 입니다.
		MEM_BIO: "asd" 멤버 자기소개 입니다.
		MEM_ID: "kkobuk" 멤버 아이디 입니다.
		MEM_NICK: "꼬부기" 멤버 닉네임 입니다.
		MEM_NM: "박세현" 멤버 닉네임 입니다.
		MEM_PIC_FILE_NAME: "4" 멤버 프로필 사진 번호 입니다.
		MEM_SIGN_DATE: 1621436400000 멤버 가입 일 입니다.
		MEM_STATUS: "ON" 멤버 상태 입니다.
		MEM_WORKING_CITY: "Cupertino" 멤버 일하는 지역 입니다.
		MILESTONECNT: 3 멤버 작성한 마일스톤 갯수 입니다.
		NEWSCNT: 22 멤버가 작성한 뉴스 갯수 입니다.
		NEWSCOMCNT: 34 멤버가 작성한 뉴스 댓글 갯수 입니다.
		*/
		
		$.each(res, function(i, project){
			let personalPageBody = $('#personal-page-body');
			
			personalPageBody.append('<div id="projectBox" class="col-md-6 card">' 
			+ 'TITLE : ' + project.PROJ_TITLE
			+ '<br>'
			+ 'PROJECT MANAGER : ' + project.PROJ_MANAGERID
			+ '<br>'
			+ 'JOIN DATE : ' + moment(project.JOIN_DATE).format('YYYY-MM-DD')
			+ '<br>'
			+ 'project start ' + moment(project.PROJ_START_DATE).fromNow()
			+ '</div>');
			
			
// 			프로젝트에 대한건 아래의 변수들을 사용하면 됩니다. $.each 안에서 project. 으로 불러오면 됩니다.
// 			PROJ_CONT: "test" 
// 			PROJ_DROP_DATE: 1624024190000
// 			PROJ_JOIN_DATE: 1623915822000
// 			PROJ_MANAGERID: "eisen"
// 			PROJ_START_DATE: 1623818635000
// 			PROJ_STATUS: "0"
// 			PROJ_TITLE: "GilsTestProject"
// 			PROJ_USER_NICK: "박세현"
		});
		
	},
	error : function(xhr, error, msg) {
		// 존재하지 않는 아이디의 경우가 있으므로 무조건 필요합니다. 따로 리다이렉트는 안합니다.
		// 존재하지 않는 회원의 페이지에 방문 했을경우의 디자인은 간단히만 처리 해 주세요. 일단 sweetr 메시지만 해둡니다.
		// toastr.error 아래에 코드 이어서 작성하면 됩니다.
		if(xhr.status == 404){
			toastr.error('존재하지 않는 회원 아이디 입니다');
		}
		ajaxError(xhr, error, msg);
	},
	dataType : 'json'
})
</script>