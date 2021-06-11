<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

            <div class="git repository container-fluid">
				<div id="readmeArea">
				</div>
            </div>
            
            <div class="container-fluid">
				<h4>SVN</h4>
            </div>



<script>
	$(function(){
		// 페이지 준비되면 모든 저장소 정보를 불러온다.
		loadRepositoryList();
	})
	
</script>



