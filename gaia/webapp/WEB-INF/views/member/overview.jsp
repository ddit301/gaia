<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card side-position-fixed" id="side-profile"> 
                <div class="card-body" id="side-profile-body">
                    <div class="media align-items-center mb-4">
                        <img class="mr-3 rounded-circle" id="profile_img" onerror="imgOnErr()" width="80" height="80" alt="">
                        <div class="media-body">
                            <h3 class="mb-0">${mem_id }</h3>

                        </div>
                    </div>
                    <h4>About Me</h4>
                    <p class="text-muted" id="mem_bio"></p>
                    <ul class="card-profile__info">
                        <li class="mb-1" id="mem_nick"><strong class="text-dark mr-4"><i class="fa fa-star gradient-1-text"></i></strong> <span>닉네임</span></li>
                        <li class="mb-1" id="mem_work_city"><strong class="text-dark mr-4"><i class="icon-location-pin icons"></i></strong> <span>지역</span></li>
                        <li class="mb-1" id="mem_tel"><strong class="text-dark mr-4"><i class="icon-phone icons"></i></strong> <span>전화번호</span></li>
                    </ul>
                    
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
	            	<p class="mb-sm-0"></p>
	            	<h3>담당하고 있는 이슈가 없습니다. 
	            		<br> 
	            		프로젝트에 참여해 이슈를 작성해보세요.
	            	</h3>
	            </div> 
	            <div class="row issue-card-mid">
	             	<div class="col-md-6">
	                	<small class="text-muted issue_date"></small>
	             	</div>
	           	 	<div class="col-md-6 media-reply__link" id="by_mem_nick">
		                <button class="btn btn-transparent p-0 ml-10 font-weight-bold fixer_id"></button>
	             	</div>
	             </div>
	             <p class="issue-card-bot"></p>
	    	</div>
	    </div>
	</div>
</div>
<script>
loadMemberInfo_overview();
loadMenu();
</script>