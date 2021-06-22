<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* Jun 19, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${cPath }/resources/assets/css/personal.css" rel="stylesheet"> 

<div class="container-fluid personal-profile">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card side-position-fixed" id="side-profile"> 
                <div class=" card-body">
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
		<div class="col-lg-8 col-xl-9 row">
			<div class="col-lg-12 row" id="personal-proj-list">
			
			</div>
		</div>
    </div>
</div>
<!-- hidden -->
<div id="personal-template" hidden="hidden">
			    		<!-- 			    		project box 시작 -->
							<div class="projectBox col-md-6">
								<div class ="projCardBox card col-md-12">
									<div class="projTitle">
									   <i class="icon-fire large-icons"></i> 
									   <span>프로젝트이름</span>
							 		 </div>
										<div class="manager-area">
											<div class="projManager">
											   <i class="icon-badge large-icons"></i> 
													<span>프로젝트 매니져</span>
								
													
													<img class="profile" onerror="imgOnErr()" src="/resources/images/profiles/1">
											</div>
										</div>
									<div class="proj-join-date-info">
										<i class="icon-rocket icons"></i> 
										
											<span>JOIN 2021-06-21</span>		
									</div>
									<div class="proj-start-date-info">
									<i class="icon-direction icons"></i> 
										<span>project start 5 days ago</span>
									</div>
									<div class="progress-area">
										<div class="progress-bar bg-success" role="progressbar"
											style="width: 0%">10%
										</div>
									</div>
								</div>
							</div>
<!-- 			    		project box 끝 -->
</div>

<script>

printPersonalPage();


</script>