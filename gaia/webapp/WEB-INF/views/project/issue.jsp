<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
            <div class="container-fluid">
           	    <div class="row">
	           		<div class="col-md-11"></div>
           			<div class="col-md-1">
	           			<button type="button" id="newIssueBtn" class="btn mb-1 btn-rounded btn-outline-dark">이슈등록</button>
           			</div>
       			</div>
            	<div class="row issue-header">
            		<div class="col-md-1"></div>
            		<div id="iss-filter-btn" class="col-md-5">
	            		<button type="button" class="btn mb-1 btn-flat btn-light">All</button>
	            		<button data-status="0" type="button" class="btn mb-1 btn-flat btn-success">Open</button>
	            		<button data-status="1" type="button" class="btn mb-1 btn-flat btn-light">Closed</button>
            		</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">작성자</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">Robin</a> 
                           	<a class="dropdown-item" href="#">Eisen</a> 
                           	<a class="dropdown-item" href="#">Link 3</a>
                      		</div>
           			</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">중요도</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">Robin</a> 
                           	<a class="dropdown-item" href="#">Eisen</a> 
                           	<a class="dropdown-item" href="#">Link 3</a>
                      		</div>
           			</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">라벨</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">Robin</a> 
                           	<a class="dropdown-item" href="#">Eisen</a> 
                           	<a class="dropdown-item" href="#">Link 3</a>
                      		</div>
           			</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">마일스톤</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">Robin</a> 
                           	<a class="dropdown-item" href="#">Eisen</a> 
                           	<a class="dropdown-item" href="#">Link 3</a>
                      		</div>
           			</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">담당자</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">Robin</a> 
                           	<a class="dropdown-item" href="#">Eisen</a> 
                           	<a class="dropdown-item" href="#">Link 3</a>
                      		</div>
           			</div>
           			<div class="dropdown col-md-1">
                          <button type="button" class="btn btn-grey dropdown-toggle" data-toggle="dropdown" aria-expanded="false">정렬</button>
                          <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
                           	<a class="dropdown-item" href="#">최신순</a> 
                           	<a class="dropdown-item" href="#">오래된순</a> 
                           	<a class="dropdown-item" href="#">댓글많은순</a>
                      		</div>
           			</div>
            	</div>
            	
           		<div id="issuelist"></div>
           		<div class="issue-footer">
           			<div>
	           			<ul class="pagination justify-content-center">
	                   </ul>
           			</div>
           		</div>
           	</div>
				

<div id="issue-template" hidden="hidden" >
	<div class="issueBox row">                                                                                
		<div class="iss-chkbox col-md-1">
			<input type="checkbox">
		</div>                                                                    
		<div class="issue-title col-md-5">                                                              
			<a class="issueButton" href="javascript:void(0)"></a>                                                       
		</div>                                                                                          
	    <div class="issue-writer col-md-1">                                                                  
			<img class="profile" onerror="imgOnErr()">
		</div>                                                                                      
	    <div class="issue-priority col-md-1"></div>                                                       
		<div class="issue-label col-md-1"></div>                                                           
		<div class="milestone col-md-1"></div>                                                        
		<div class="issue-assignee col-md-1">                                                                      
		</div>                                                                                      
		<div class="reply col-md-1">
		</div>                                                            
	</div>        
</div>
            
<script>
	issue_status = 0;
	currentPage = 1;
	startPage = null;
	endPage = null;
       
    // 페이지 로딩시 이슈 리스트를 한번 불러온다.
    loadIssueList();

</script>
            
            
            
            
            
            
            