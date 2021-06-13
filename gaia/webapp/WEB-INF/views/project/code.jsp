<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
		<div class="container-fluid row">
<!-- 		repository start -->
			<div class="repository col-md-9">
<!-- 			git repository -->
	            <div class="git">
	            	<div class="repoHeader">
	            		<span></span>
	            	</div>
	            	<div class="repoBody">
		            	<div class="fileNav card">
		            		<div class="fileNavHeader">
		            			<span>열람중인 경로 정보</span>
		            		</div>
		            		<div class="fileNavBody">
		            		</div>
		            	</div>
		            	<div class="col-md-6"></div>
	            	</div>
					<div id="gitReadmeArea"></div>
	            </div>
<!-- 			svn repository -->
	            <div class="svn">
	            </div>
<!-- 		repository end -->
			</div>
			
			<div class="project-overview col-md-3">
				<span>프로젝트 정보 오버뷰 내용 들어갈 곳</span>
			</div>
		</div>

<div id="codeTemplates" hidden="true">
	<div class="fileObj fileBox row">
		<div class="filename col-md-9">
			<i></i><!-- 파일 타입에 따라 icon-file 혹은 icon-folder 로 변한다. --> 
			<a class="filename-text">filename</a>
		</div>
		<div class="filesize col-md-3">
			<span class="filesize-text"></span>
		</div>
	</div>
</div>


<script>
	$(function(){
		// 페이지 준비되면 모든 저장소 정보를 불러온다.
		loadRepositoryList();
	})
	
</script>



