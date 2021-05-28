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
            		<div class="col-md-5">
	            		<button type="button" class="btn mb-1 btn-flat btn-grey">Open</button>
	            		<button type="button" class="btn mb-1 btn-flat btn-dark">Closed</button>
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
		           			<button type="button" class="btn mb-1 btn-rounded btn-outline-dark">이슈등록</button>
	           			</div>
           			</div>
           			<div>
	           			<ul class="pagination justify-content-center">
	                       <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">Previous</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">1</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">2</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">3</a>
	                       </li>
	                       <li class="page-item"><a class="page-link" href="#">Next</a>
	                       </li>
	                   </ul>
           			</div>
           		</div>
           	</div>
				

<div id="issue-template" hidden="hidden" >
	<div class="issueBox row">                                                                                
		<div class="col-md-1"></div>                                                                    
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
            	
	            $.ajax({
					url : getContextPath() + '/restapi/project/issues',
					type : 'get',
					data : {
						//'manager_nick' : manager_nick
					},
					success : function(res) {
						
						$.each(res, function(i, v) {
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
							issueBox.children('.issue-label').text(v.label_nm);
							issueBox.children('.milestone').text(v.milest_title);
							issueBox.children('.issue-assignee').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							issueBox.children('.issue-writer').children('img').attr('src','/gaia/resources/assets/images/user/1.png');
							if(v.replyCount > 0){
								issueBox.children('.reply').html(
										'<i class="icon-bubbles icons"></i><span>'+v.replyCount+'</span>'
									);
							}
							
							$('#issuelist').append(issueBox);
						})
						
					},
					error : function(xhr, error, msg) {
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
				
				
            </script>
            
            
            
            
            
            
            