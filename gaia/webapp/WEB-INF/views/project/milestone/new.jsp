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
<!-- 		<div class="row page-titles mx-0"> -->
<!-- 			<div class="col p-md-0"> -->
<!-- 				<ol class="breadcrumb"> -->
<%-- 					<li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li> --%>
<%-- 					<li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li> --%>
<!-- 				</ol> -->
<!-- 			</div> -->
<!-- 		</div> -->
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
											<div id="mile-auto" class="milestonehead-heading">New milestone</div>
											<div class="milestonehead-description">Create a new
												milestone to help organize your issues and pull requests.</div>
										</div>
		
										
											<div class="form-title-group">
												<div class="input-label">
													<label for="milestone_title">Title</label>
												</div>
											
												<input type="text" class="milest-input form-control bg-transparent"
													id="milest_title" name="milest_title" placeholder=" Title" required>
												
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
												
											</div>
									
		
									</div>
									<div class="button m-t-15">
										<button type ="submit" hidden = "hidden"></button>
										<button
											class="create-btn btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" disabled >
											<i class="fa fa-check m-r-5"></i> create milestone
										</button>
										<button
											class="mile-close close-btn btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button">
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

		milestTitleArea = $('#newmilestone-form').find('#milest_title')
		milestContArea = $('#newmilestone-form').find('#milest_cont')
		
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
							let startDate = $('.milest-start-date').children('input').val();
							$('.milest-end-date').children('input').bootstrapMaterialDatePicker("setMinDate",startDate);
						})
						
		// 발표를 위한 마일스톤 생성 매크로
		$('#mile-auto').on('click', function(){
			milestTitleArea.val('최종 발표하기');
			milestContArea.val('최종 발표 잘 하기');
		})				
					
	})
</script>
