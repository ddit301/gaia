<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h4>milestone :  ${manager_nick } / ${project_title }</h4>
	</div>
	
		<div class="btn-body">
			<a href="#" class="label label-info" style="float: right; margin-right: 5px;">New issue</a>
			<a href="#"	class="label label-info" style="float: right; margin-right: 5px;">Edit milestone</a>
		</div>
		<br>
		<br>
	
		<div class="table-list-cell milestone-title" style="background: white; padding:10px; margin:10px;">	
				<div class="milestone-title" style="width:50%;float:left;box-sizing:border-box">
					<h2 class="milestone-title-link">
						<a href="#">설계 구현</a>
					</h2>
				</div>
				<div class="milestone-bar" style="width:50%;float:right;box-sizing:border-box">
					<div class="progress mb-3" style="height: 7px">
						<div class="progress-bar gradient-1" style="width: 80%;"role="progressbar">
					</div>	
				</div>
			</div>	
			<br>
			<div class="mt-4">
				<h6>2020-05-04 ~ 2020-05-08</h6>
					<h6>
						<span class="pull-right">완성률 80%</span>
					</h6>
					<br>
				</div>		
			</div>
			
			<div class="table-list-cell milestone-title" style="background: white; padding:10px; margin:10px;">	
				<div class="milestone-title" style="width:50%;float:left;box-sizing:border-box">
					<h2 class="milestone-title-link">
						<a href="#">착수발표</a>
					</h2>
				</div>
				<div class="milestone-bar" style="width:50%;float:right;box-sizing:border-box">
					<div class="progress mb-3" style="height: 7px">
						<div class="progress-bar gradient-1" style="width: 50%;"role="progressbar">
					</div>	
				</div>
			</div>	
			<br> 
			<div class="mt-4">
				<h6>2020-05-09 ~ 2020-05-11</h6>
					<h6>
						<span class="pull-right">완성률 50%</span>
					</h6>
					<br>
				</div>		
			</div>
			<div class="issue-dropdown-bar" style="background:gray; height:50px; margin:10px; padding:10px;">
				<div class="issue-chk" style="float:left;">
					<a class="btn mb-1 btn-flat btn-secondary" href="#">2 open</a>
					<a class="btn mb-1 btn-flat btn-secondary" href="#">0 closed</a>
				</div> 
				
					<div class="dropdown-btn" style="float:right; padding-right:5px;">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">담당자</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">Shane</a> 
							<a class="dropdown-item" href="#">Robin</a> 
							<a class="dropdown-item" href="#">Eisen</a>
						</div>
					</div>
					
					<div class="dropdown-btn" style="float:right; padding-right:5px;">	
								<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">마일스톤</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">설계구현</a> 
							<a class="dropdown-item" href="#">db설계</a> 
							<a class="dropdown-item" href="#">REST API 구현</a>
						</div>
					</div>
					
						<div class="dropdown-btn" style="float:right; padding-right:5px;">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">라벨</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">버그</a> 
							<a class="dropdown-item" href="#">문서</a> 
							<a class="dropdown-item" href="#">처리완료</a>
						</div>
					</div>
					
					<div class="dropdown-btn" style="float:right; padding-right:5px;">	
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">중요도</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">무시</a> 
							<a class="dropdown-item" href="#">낮음</a> 
							<a class="dropdown-item" href="#">보통</a>
						</div>
					</div>	
					
					<div class="dropdown-btn" style="float:right; padding-right:5px;">				
						<button class="btn btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">작성자</button>
						<div class="dropdown-menu" x-placement="bottom-start"
							style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 28px, 0px);">
							<a class="dropdown-item" href="#">Shane</a> 
							<a class="dropdown-item" href="#">Robin</a> 
							<a class="dropdown-item" href="#">Eisen</a>
						</div>
					</div>
				</div> 

<!-- 			<div class="col-sm-12 col-md-5"><div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">Showing 11 to 20 of 57 entries</div></div> -->
						<div class="issue-list-cell milestone-issue" style="background:white; display:inline-block; width:98%; padding:10px;margin:10px;">	
							<div class="issue-title" style="float:left">
								<h4 class="issue-title-link">
									<a href="#">유스케이스 정의서 작성하기</a>
								</h4>													
							</div>
							<div class="issue-member" style="float:right" style="margin:5px;">
								<a class="issue-writer" href="#">Shane</a> &nbsp;	
								<a class="issuepriority" href="#">즉시</a> &nbsp;	
								<a class="issue-label" href="#">할일</a> &nbsp;	
								<a class="issue-milestone" href="#">설계구현</a> &nbsp;	
								<a class="issue-assignee" href="#">Shane</a> &nbsp;	
								<a class="issue-assignee" href="#">Robin</a> &nbsp;	
								<a class="issue-comment" href="#">댓글</a>		
							</div>
						</div>

					<div class="issue-list-cell milestone-issue" style="background:white; display:inline-block; width:98%; padding:10px;margin:10px;">	
							<div class="issue-title" style="float:left">
								<h4 class="issue-title-link">
									<a href="#">이슈 기능 구현하기</a>
								</h4>													
							</div>
							<div class="issue-member" style="float:right" style="margin:5px;">
								<a class="issue-writer" href="#">Eisen</a> &nbsp;	
								<a class="issuepriority" href="#">보통</a> &nbsp;	
								<a class="issue-label" href="#">할일</a> &nbsp;	
								<a class="issue-milestone" href="#">설계구현</a> &nbsp;	
								<a class="issue-assignee" href="#">Josh</a> &nbsp;	
								<a class="issue-assignee" href="#">Shane</a> &nbsp;	
								<a class="issue-comment" href="#">댓글</a>		
							</div>
						</div>
							<div class="card-body">
                                <div class="bootstrap-pagination">
                                    <nav>
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
                                    </nav>
                                </div>
                            </div>
		