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
            <!-- row -->
            <div class="container-fluid">
            	<div class="issue-header row">
            		<div class="col-md-1"></div>
            		<div class="col-md-5">
	            		<button type="button" class="btn mb-1 btn-flat btn-light">Open</button>
	            		<button type="button" class="btn mb-1 btn-flat btn-dark">Closed</button>
            		</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">작성자</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">Robin</a> 
	                           	<a class="dropdown-item" href="#">Eisen</a> 
	                           	<a class="dropdown-item" href="#">Link 3</a>
                       		</div>
            			</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">중요도</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">Robin</a> 
	                           	<a class="dropdown-item" href="#">Eisen</a> 
	                           	<a class="dropdown-item" href="#">Link 3</a>
                       		</div>
            			</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">라벨</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">Robin</a> 
	                           	<a class="dropdown-item" href="#">Eisen</a> 
	                           	<a class="dropdown-item" href="#">Link 3</a>
                       		</div>
            			</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">마일스톤</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">Robin</a> 
	                           	<a class="dropdown-item" href="#">Eisen</a> 
	                           	<a class="dropdown-item" href="#">Link 3</a>
                       		</div>
            			</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">담당자</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">Robin</a> 
	                           	<a class="dropdown-item" href="#">Eisen</a> 
	                           	<a class="dropdown-item" href="#">Link 3</a>
                       		</div>
            			</div>
            			<div class="dropdown col-md-1">
                           <button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">정렬</button>
                           <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 37px, 0px);">
	                           	<a class="dropdown-item" href="#">최신순</a> 
	                           	<a class="dropdown-item" href="#">오래된순</a> 
	                           	<a class="dropdown-item" href="#">댓글많은순</a>
                       		</div>
            			</div>
            	</div>
           		<div id = "issuelist"></div>
           		<div class="issue-footer">
           			<div class="row">
	           			<div class="col-md-10"></div>
	           			<div class="col-md-2">
		           			<button type="button" class="btn mb-1 btn-success">이슈등록</button>
	           			</div>
           			</div>
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
            
            <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
	            $.ajax({
					url : '${cPath}/restapi/project/issue',
					type : 'get',
					data : {
						//'id' : feed_id
					},
					success : function(res) {
						$.each(res, function(i, v) {
							let template = $('#template');
							template.find('name').text('이름');
							template.children('sdf').text('asdf');
							$('#issuelist').append(template);
							let issue =
			           			'<div class="issueBox row">                                                                                '
					            +'		<div class="col-md-1"></div>                                                                    '
					            +'		<div class="issue-title col-md-5">                                                              '
					            +'			<span>'+v.issue_title+'</span>                                                            '
					            +'		</div>                                                                                          '
			            		+'       		<div class="col-md-1">                                                                  '
								+'				<img src="/gaia/resources/assets/images/user/1.png" height="40" width="40" alt="">      '
								+'			</div>                                                                                      '
			            		+'       		<div class="col-md-1">즉시</div>                                                        '
						        +'    		<div class="col-md-1">할일</div>                                                            '
						        +'    		<div class="col-md-1">설계구현</div>                                                        '
						        +'    		<div class="col-md-1">                                                                      '
						        +'    			<img src="/gaia/resources/assets/images/user/1.png" height="40" width="40" alt="">      '
						        +'    		</div>                                                                                      '
						        +'    		<div class="col-md-1"><i class="icon-bubbles icons"></i> <span>3</span></div>                                                            '
				            	+'</div>                                                                                                '
				            $('#issuelist').append(issue);
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
            

            
            
            <div id="template" hidden="hidden">
            
            </div>
            
            
            
            
            
            
            
            
            
            
            
            