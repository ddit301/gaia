<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row justify-content-end">
	<div class="col col-md-3">
		<ol class="breadcrumb">
		    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
		    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
		</ol>
	</div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card"> 
                <div class="card-body">
	                <div class="card">
		               	<div class="form-group">
		                   	<ul id="projectList">
	                  			
		                   	</ul>
	                   </div>
		            </div>
                    <div class="media align-items-center mb-4">
                        <img class="mr-3" src="${cPath}/resources/assets/images/member/profile.png" width="80" height="80" alt="">
                        <div class="media-body">
                            <h3 class="mb-0">${mem_nick }</h3>
                            <p class="text-muted mb-0">Deutch</p>
                        </div>
                    </div>
                    <h4>About Me</h4>
                    <p class="text-muted" id="mem_bio">${model.mem_bio }</p>
                    <ul class="card-profile__info">
                        <li class="mb-1"><strong class="text-dark mr-4"><i class="fa fa-star gradient-1-text"></i></strong> <span>ddit301</span></li>
                        <li><strong class="text-dark mr-4"><i class="mdi mdi-email-outline"></i></strong> <span>name@domain.com</span></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <ul class="mb-0 form-profile__icons">
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-user"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-paper-plane"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-camera"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-smile"></i></button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>  
        </div>
		<div class="col-lg-8 col-xl-9">
			<div class="card">
		    	<div class="container-fluid">
			        <div class="row" id="issues">
			            
			            
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
		                <button class="btn btn-transparent p-0 ml-3 font-weight-bold fixer_nick">by ${mem_nick }</button>
	             	</div>
	             </div>
	             <p class="issue-card-bot">담당하고 있는 이슈에 새로운 소식이 존재하지 않습니다.</p>
	    	</div>
	    </div>
	</div>
</div>
<script>
	// todo 
	// 1. 3가지만 화면에 출력하기.
	// 2. more page 클릭 시 가입된 모든 프로젝트 보여주기.
	// 3. 문자 길이 설정.
	var loadMemberInfo = function(){
		let mem_no = 1;
		$.ajax({
			url : getContextPath()+"/restapi/member/members/"+mem_no ,
			type : 'get',
			success : function(res) {
				let memberInfo = res;
				let projectList="";
				let length;
				let proj_manager ="";
				$.each(memberInfo.projectList, function(i, v){
					let uri = v.uri;
					proj_manager = v.projectManager.mem_nick;
					projectList += '<li><a href="'+getContextPath()+"/"+ v.uri+'" class="projectName">'+ v.proj_title +"</a></li>";
					
					$.each(v.issueList, function(j, iss){
						let issue = $("#issueTemplate").children(".issue").clone();
						let timeUploaded = iss.historyList[0].issue_his_date;
						let timeAgo = moment(timeUploaded, "YYYYMMDD").fromNow();
						let proj_manager_link = "<a href="+getContextPath()+"/"+proj_manager+">"+proj_manager+"</a>"; 
						let proj_link = "<a href="+uri+">"+"/"+v.proj_title+"</a>";
						let issue_link = "<a href="+iss.url+">"+"/"+iss.issue_sid+"</a>";
						
						issue.attr("data-issue_sid", iss.issue_sid);
						issue.find(".issue-card-top").children().first().html(proj_manager_link + proj_link + issue_link);
						
						issue.find(".issue-card-top").children().last().text(iss.issue_title);
						issue.find(".issue-card-mid").find(".issue_date").text(timeAgo);
						issue.find(".issue-card-mid").find(".fixer_nick").text("by "+iss.historyList[0].historyWriter.mem_nick);
						issue.find('.issue-card-bot').text(iss.historyList[0].issue_his_cont);
						https://localhost/gaia/kkobuk/testproject/issue/1
						issue.appendTo("#issues");
					})
					length = v.issueList.length+1
					if(length%2){
						$("#issueTemplate").children(".issue").clone().appendTo("#issues");
					}
				})
				$("#projectList").html(projectList);
				$("#mem_bio").text(memberInfo.mem_bio);
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
</script>