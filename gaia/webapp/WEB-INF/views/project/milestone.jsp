<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/milestone.css" rel="stylesheet"> 
	     	<div class="container">
	            <div class="row page-titles mx-0">
	                <div class="col p-md-0">
	                    <ol class="breadcrumb">
	                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
	                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
	                    </ol>
	                </div>
	            </div>
            <!-- row -->


	     		<div class="milestone-new-btn">
					<a id="newMilestone" class="label label-info" data-menu="newmilestone" href="javascript:void(0)">New milestone</a>
				</div>
		     	<div class="milestone-header row">
					<div class="milestone-chk row col-md-6">
						<button type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-success ">All</button>
		            	<button data-status="0" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Open</button>
		            	<button data-status="1" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Closed</button>
					</div>
		     	</div>
		     	<div id="milestone-list"></div>
		     	<div class="milestone-footer">
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
			
				<div id="milestone-template" hidden="hidden">
					<div class="milestoneBox">	
						<div class = "row">
							<div class="milestone-title col-md-6">
								<a class="milestoneButton" data-menu="milestoneview" href="javascript:void(0)"></a>    
				            </div>                                                                                     
							<div class="milestone-bar col-md-6">
								<div class="progress mb-3">
									<div class="progress-bar gradient-1" style=; role="progressbar">
									</div>	
								</div>
							</div>	                                                                                         
						</div>
						<div class = "row">
	                        <div class="milestone-date col-md-6">
								<span></span>                            
		                    </div>
		                    <div class="milestone-percent col-md-6">
		                        <span></span>
		                    </div>                               
						</div>
						<div class="row">
							<div class="milestone-descript col-md-6">
								<span></span>	
							</div>
<!-- 							<div class="milestone-status row col-md-6"> -->
<!-- 								<div class ="col-md-7"></div> -->
<!-- 								<button type="button" id="open-milest" class="milest-status-btn btn btn-sm btn-outline-secondary col-md-2">open</button> -->
<!--                                 <button type="button" id ="close-milest" class="milest-status-btn btn btn-sm btn-outline-danger col-md-2">close</button> -->
<!-- 							</div> -->
						</div>
					</div>     
				</div>
				
 <script>
 $(function(){
	// 페이지 로딩시 마일스톤 리스트 뽑기 
	milestonelist();
 })
</script>
            

		
			