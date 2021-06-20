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
	<div class="codepage-body row">
<!-- 		repository start -->
		<div class="repository col-md-9 row">
	<!-- 			git repository -->
			<div class="git row">
				<div class="card repoHeader row">
					<div class="row">
						<div class="repoInfo col-md-6">
							<div class="githubimg row">
								<img src="${cPath }/resources/images/github/GitHub-Mark/PNG/GitHub-Mark-32px.png">
								<img src="${cPath }/resources/images/github/GitHub-Logos/GitHub_Logo.png">
							</div>
							<a>
								<span></span>
							</a>
						</div>		         
						<div class="languageInfo col-md-6">
							<span></span>
			            </div>
					</div>
				</div> 
				<div class="repoBody col-md-12">
					<div class="fileNav card">
						<div class="fileNavHeader">
							<span></span>
						</div>
						<div class="fileNavBody">
						</div>
					</div>
					<div id="gitReadmeArea" class="col-md-12 card"></div>
				</div>
			</div>
	<!-- 			git end & svn repository start -->
			<div class="svn">
			</div>
	<!-- 		repository end -->
		</div>
	<!-- project-overview start -->
		<div class="project-overview col-md-3">
			<div class="col-md-12">
				<div class="card">
					<p class="projtitle">GAIA</p>
					<div class="overview-cont">
						<span>뭐 어쩌구 쩌쩌구 하는 프로젝트인데 어쩌구 저쩌구 쫌 길게 들어감.</span>
					</div>
					<div class="start-date">
						<span>2021.04.14</span>
					</div>
					<div class="end-date">
						~ <span>2021.04.14</span>
					</div>
					<div class="progress-bar bg-success" role="progressbar"></div>
				</div>
				<div class="manager-overview card">
					<p>프로젝트 관리자</p>
					<div class="mem-overview-card">
						<img class="profile" onerror="imgOnErr()">
						<span>운영자</span>
					</div>
				</div>
				<div class="members-overview card">
					<p>소속 멤버</p>
					<div>
						<div class="mem-overview-card">
							<img class="profile" onerror="imgOnErr()">
							<span>운영자</span>
						</div>
						<div class="mem-overview-card">
							<img class="profile" onerror="imgOnErr()">
							<span>운영자</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- project-overview end -->
</div>

<div id="codeTemplates" hidden="true">
<!-- 	파일 박스 템플릿 -->
	<div class="fileObj fileBox row">
		<div class="filename col-md-9">
			<i></i><!-- 파일 타입에 따라 icon-file 혹은 icon-folder 로 변한다. --> 
			<a class="filename-text">filename</a>
		</div>
		<div class="filesize col-md-3">
			<span class="filesize-text"></span>
		</div>
	</div>
<!-- 	멤버 카드 템플릿 -->
	<div class="mem-overview-card">
		<img class="profile" onerror="imgOnErr()">
		<span>운영자</span>
		<small>PL</small>
	</div>
</div>


<script>
	$(function(){
		// 페이지 준비되면 모든 저장소 정보를 불러온다.
		loadRepositoryList();
		loadProjectOverview();
	})
	
</script>



