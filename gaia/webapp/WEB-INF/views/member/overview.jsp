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
			            <div class="col" id="issueInfo">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">by ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
			            <div class="col issueInfo">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">by ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
		            </div>
		        </div>
		    </div>
		</div>
    </div>
</div>
<script>
	if(!memberInfo){
		loadMemberInfo();
	}
	console.log(memberInfo);
	let projects = "";
	let issues[];
	// todo 
	// 1. 3가지만 화면에 출력하기.
	// 2. more page 클릭 시 가입된 모든 프로젝트 보여주기.
	// 3. 문자 길이 설정.
	$.each(memberInfo.projectList, function(i, v){
		projects += '<li><a href="'+getContextPath()+"/"+ v.uri+'" class="projectName">'+ v.proj_title +"</a></li>";
		console.log(v.issueList);
		issues[i] = v.issueList;
	})
	$.each(memberInfo.projectList.issueList, function(i, v){
		$("#issues").clone().appendTo("#issueInfo");
		
	})
	$("#projectList").html(projects);
		
	
	
</script>