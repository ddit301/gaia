<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/issue.css" rel="stylesheet">
    
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>

            <div class="container-fluid">
            	<div class="row issue-header">
            		<div class="col-md-1"></div>
            		<div id="iss-filter-btn" class="col-md-5">
	            		<button type="button" class="btn mb-1 btn-flat btn-grey">All</button>
	            		<button data-status="0" type="button" class="btn mb-1 btn-flat btn-success">Open</button>
	            		<button data-status="1" type="button" class="btn mb-1 btn-flat btn-warning">Closed</button>
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
           			<div class="row">
		           		<div class="col-md-11"></div>
	           			<div class="col-md-1">
		           			<button type="button" id="newIssueBtn" class="btn mb-1 btn-rounded btn-outline-dark">이슈등록</button>
	           			</div>
           			</div>
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
			<img src="" alt="">      
		</div>                                                                                      
	    <div class="issue-priority col-md-1"></div>                                                       
		<div class="issue-label col-md-1"></div>                                                           
		<div class="milestone col-md-1"></div>                                                        
		<div class="issue-assignee col-md-1">                                                                      
			<img src="" alt="">      
		</div>                                                                                      
		<div class="reply col-md-1">
		</div>                                                            
	</div>        
</div>
            
            <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
            	issue_status = null;
            	currentPage = 1;
            	startPage = null;
            	endPage = null;
            
	            loadIssueList = function(){
		            $.ajax({
						url : getContextPath() + '/restapi/project/issues',
						type : 'get',
						data : {
							'issue_status' : issue_status
							,'currentPage' : currentPage
						},
						success : function(res) {
							$('#issuelist').empty();
							startPage = res.startPage;
							endPage = res.endPage;
							
							// pagination 만들어주기
							let prevBtn;
							let nextBtn;
							if(res.startPage <= 1){
								prevBtn = '<li class="page-item disabled"><a class="page-link" data-btn="prev" href="#" tabindex="-1">Previous</a></li>';
							}else{
								prevBtn = '<li class="page-item"><a class="page-link" data-btn="prev" href="#" tabindex="-1">Previous</a></li>';
							}
							if(res.endPage < res.totalPage){
								nextBtn = '<li class="page-item"><a class="page-link" data-btn="next" href="#">Next</a></li>';
							}else{
								nextBtn = '<li class="page-item disabled"><a class="page-link" data-btn="next" href="#">Next</a></li>';
							}
							
							let pageNation = prevBtn;
							for(i=res.startPage; i<=res.endPage && i<=res.totalPage; i++){
								if(res.currentPage == i){
									pageNation += '<li class="page-item active"><a class="page-link">'+ i +'</a></li>'
								}else{
									pageNation += '<li class="page-item"><a class="page-link">'+ i +'</a></li>'
								}
							}
							pageNation += nextBtn;
							$('.pagination').html(pageNation);
							
							$.each(res.dataList, function(i, v) {
								let issueBox = $('#issue-template').children('.issueBox').clone();
								issueBox.attr('data-issue_sid',v.issue_sid);
								issueBox.attr('data-issue_no',v.issue_no);
								issueBox.children('.issue-title').children('a').text(v.issue_title);
								issueBox.children('.issue-priority').text(
									v.issue_priority == 1 ? '무시' :
									v.issue_priority == 2 ? '낮음' :
									v.issue_priority == 3 ? '보통' :
									v.issue_priority == 4 ? '높음' :
									v.issue_priority == 5 ? '긴급' : '즉시'
									);
								if(v.label){
									issueBox.children('.issue-label').text(v.label.label_nm);
								}
								if(v.milestone){
									issueBox.children('.milestone').text(v.milestone.milest_title);
								}
								issueBox.children('.issue-assignee').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
								issueBox.children('.issue-writer').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
								if(v.replyCount > 0){
									issueBox.children('.reply').html(
											'<i class="icon-bubbles icons"></i><span>&nbsp;'+v.replyCount+'</span>'
										);
								}
								
								$('#issuelist').append(issueBox);
							})
							
						},
						error : function(xhr, error, msg) {
							// 조회중인 프로젝트 번호를 세션에서 못 받아 올 경우, 메인 홈페이지로 보낸다.
							if(xhr.status == 400){
								window.location.href = getContextPath();
							}
							console.log(xhr);
							console.log(error);
							console.log(msg);
						},
						dataType : 'json'
					})
	            }
	            
	            // 페이지 로딩시 이슈 리스트를 한번 불러온다.
	            loadIssueList();
	            
	            /*
	             * document.ready
	            **/ 
	            $(function(){
	            	
	            	$('.pagination').on('click', '.page-link', function(){
	            		event.preventDefault();
	            		let dataBtn = $(this).data('btn');
	            		if(dataBtn== 'prev'){
	            			currentPage = parseInt(startPage) - 1;
	            		}else if(dataBtn == 'next'){
	            			currentPage = parseInt(endPage) + 1;
	            		}else{
	            			if(currentPage == $(this).text()){
	            				return false;
	            			}else{
		            			currentPage = $(this).text();
	            			}
	            		}
	            		window.scrollTo({top:0, left:0, behavior:'auto'});
	            		loadIssueList();
	            	})
	            	
	            	$('#iss-filter-btn').children('button').on('click', function(){
	            		issue_status = $(this).data('status');
	            		currentPage = 1;
	            		window.scrollTo({top:0, left:0, behavior:'auto'});
	            		loadIssueList();
	            	});
	            	
	            	
	            })
            	
				
				
            </script>
            
            
            
            
            
            
            