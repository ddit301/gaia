<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<div class="milest-container container-fluid">
	<div class="milestone-header row card">
		<div class="milestone-chk row col-md-12">
			<button type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-success ">All</button>
	        <button data-status="0" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Open</button>
	        <button data-status="1" type="button" class="status-btn btn col-mb-2 btn-sm btn-flat btn-light">Closed</button>
			<button id="newMilestone" class="btn btn-success">New milestone</button>
		</div>
	</div>
	<div id="milestone-list">
	</div>
</div>	
			
				<div id="milestone-template" hidden="hidden">
					<div class="milestoneBox card">	
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
						</div>
					</div>     
				</div>
				
 <script>
 $(function(){
	// 페이지 로딩시 마일스톤 리스트 뽑기 
	milestonelist();
 })
</script>
            

		
			