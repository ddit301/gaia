<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="${cPath }/resources/assets/css/newmilestone.css"
	rel="stylesheet">
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
	
	
	
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<form id="newmilestone-form" action="#">
								<div class="newmilestonebox">
									<div class="compose-content mt-5">
										<div class="milestonehead">
											<div class="milestonehead-heading">New milestone</div>
											<div class="milestonehead-description">Create a new
												milestone to help organize your issues and pull requests.</div>
										</div>
		
										
											<div class="form-title-group">
												<div class="input-label">
													<label for="milestone_title">Title</label>
												</div>
											
												<input type="text" class="milest-input form-control bg-transparent"
													id="milest_title" name="milest_title" placeholder=" Title" required>
													<span></span>
											</div>
		
											<div class="form-date-group row">
												<div class="date-box">
													<div class="input-label">
														<label for="milestone_start_on">Start date (optional)</label>
													</div>
													<div class="milest-start-date">
														<input type="date" pattern="\d\d\d\d-\d\d-\d\d"
															placeholder="yyyy-mm-dd" class="form-control"
															id="milest-start-date" name="mmilest-start-date">
													</div>
												</div>
												<div class="date-box">
													<div class="input-label">
														<label for="milestone_due_on">Due date (optional)</label>
													</div>
													<div class="milest-end-date">
														<input type="date" pattern="\d\d\d\d-\d\d-\d\d"
															placeholder="yyyy-mm-dd" class="form-control"
															id="milest-end-date" name="milest-end-date">
													</div>
												</div>
											</div>
											<div class="form-text-group">
												<div class="input-label">
													<label for="milestone_description">Description</label>
												</div>
												<textarea class="milest-input textarea_editor form-control bg-light"
													id="milest_cont" name="milest_cont" rows="1" placeholder="Enter text" required></textarea>
												<span></span>
											</div>
									
		
									</div>
									<div class="button m-t-15">
										<button
											class="create-btn btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" disabled >
											<i class="fa fa-check m-r-5"></i> create milestone
										</button>
										<button
											class="close-btn btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button">
											<i class="ti-close m-r-5 f-s-12"></i> close
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
$(function(){
	
// 	 $('#newmilestone-form').validate({
// 		 onfocusout: false,
// 		 rules: {
// 			 milest_title : {
// 				 required: true
				 
// 			 }, milest_cont : {
// 				 required: true
				 
// 			 }
// 		 }, messages : {
// 			 milest_title : {
// 				 required : "This field is required."
			
// 			 }, milest_cont : {
// 				 required : "This field is required."
// 			 }
// 		 }
// 	 })
	
	
		milestTitleArea = $('#newmilestone-form').find('#milest_title')
		milestContArea = $('#newmilestone-form').find('#milest_cont')
		
		$('.milest-input').on('change',function(){
			
			milest_title = milestTitleArea.val();
			milest_cont = milestContArea.val();
			
			
			if(milest_title.length * milest_cont.length != 0){
				$('.create-btn').prop('disabled',false);
			}else {
				$('.create-btn').prop('disabled',true);

			}
		
		})
	
		// 작성 마일스톤 등록
		$('.create-btn').on('click', function() {
	
			milest_title = $('#newmilestone-form').find('#milest_title').val();
			milest_start_date = $('.milest-start-date').children('input').val();
			milest_end_date = $('.milest-end-date').children('input').val();
			milest_cont = $('#newmilestone-form').find('#milest_cont').val();
			
			$.ajax({
				url : getContextPath() + '/restapi/project/milestones',
				type : 'post',
				data : {
	
					'milest_title' : milest_title,
					'milest_start_date' : milest_start_date,
					'milest_end_date' : milest_end_date,
					'milest_cont' : milest_cont
	
				},
				success : function(res) {
	
					milestoneView(res.milest_no);
				},
				error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
				},
				dataType : 'json'
			})
	
		})
	
		// datePicker 동작시키기
		$('.date-box').find('input').bootstrapMaterialDatePicker({
			// 시간은 설정 안하고 날짜만 선택할 것
			time : false
			// 설정은 최소 오늘 이후의 날자만 가능
			,
			minDate : new Date()
		});
	
		// startDate 가 정해 진 후에는 endDate는 그 이후로만 적용할 수 있도록 막기
		$('.milest-start-date').children('input')
				.on(
						'change',
						function() {
							let startDate = $('.milest-start-date').children(
									'input').val();
							$('.milest-end-date').children('input')
									.bootstrapMaterialDatePicker("setMinDate",
											startDate);
						})
					
	})
</script>
