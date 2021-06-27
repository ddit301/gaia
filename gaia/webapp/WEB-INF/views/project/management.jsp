<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
	$(function() {
		// datePicker 동작시키기
		$('.datePick').bootstrapMaterialDatePicker({
			// 시간은 설정 안하고 날짜만 선택할 것
			time : false
			// 설정은 최소 오늘 이후의 날자만 가능
			,
			minDate : new Date()
		});
		
		// 프로젝트 정보 받아오기
		loadProjectForManagement();
		
		// colorpicker 발동시키기
        var colorpicker = tui.colorPicker.create({
            container: document.getElementById('color-picker')
        });

        colorpicker.on('selectColor', function(ev) {
//             console.log(ev.color);
			$('#label-color-input').val(ev.color);
        	$('#preview-labelBox').css({"backgroundColor":ev.color});
        });
        
        // 우클릭한 라벨 초기화
        rightClickedLabel = null;

		
	})
</script>

<!-- Label 추가 혹은 수정용 Modal -->
<div class="modal fade" id="addLabelModal" tabindex="-1" aria-labelledby="addLabelModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="addLabelModalLabel"></h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="labelmodal modal-body container-fluid">
   		<div class="row">
   			<div class="col-md-7">
   				<span>아이콘 선택</span>
   				<div id="label-icon-select">
   					<i class="icon-plus"></i>
   					<i class="icon-direction"></i>
   					<i class="icon-directions"></i>
   					<i class="icon-close"></i>
   					<i class="icon-clock"></i>
   					<i class="icon-cursor"></i>
   					<i class="icon-bell"></i>
   					<i class="icon-pin"></i>
   					<i class="icon-present"></i>
   					<i class="icon-doc"></i>
   					<i class="icon-trash"></i>
   					<i class="icon-like"></i>
   					<i class="icon-loop"></i>
   					<i class="icon-volume-1"></i>
   					<i class="icon-magnifier"></i>
   					<i class="icon-star"></i>
   					<i class="icon-credit-card"></i>
   					<i class="icon-reload"></i>
   					<i class="icon-paper-clip"></i>
   					<i class="icon-lock"></i>
   					<i class="icon-user"></i>
   					<i class="icon-emotsmile"></i>
   					<i class="icon-list"></i>
   					<i class="icon-check"></i>
   					<i class="icon-trophy"></i>
   					<i class="icon-crop"></i>
   					<i class="icon-hourglass"></i>
   					<i class="icon-printer"></i>
   					
   				</div>
   			</div>
   			<div class="col-md-5">
   				<span>색상 선택</span>
   				   <div id="color-picker"></div>
   			</div>
   		</div>
   		<div class="label-add-footer row">
   			<div class="label-preview col-md-6">
   				<p>미리보기</p>
   				<div id="preview-labelBox">
					<i class="icon-plus"></i>
					<span></span>
				</div>
   			</div>
   			<div class="col-md-6">
	   			<span>라벨명 입력</span>
	   			<input id="label-no-input" type="text" hidden="true">
	   			<input id="label-name-input" type="text" maxlength="10">
	   			<input id="label-color-input" type="text" hidden="true">
	   			<input id="label-icon-input" type="text" hidden="true">
   			</div>
   		</div>
      </div>
      <div class="modal-footer">
      	<button id="labelAddConfirmBtn" onclick="addOrEditLabel()" class="btn btn-success">저장</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" hidden="hidden">Close</button>
      </div>
    </div>
  </div>
</div>



<div id="manage-template" hidden="hidden">

<!-- label box 템플릿 시작 -->
	<div class="labelBox">
		<i></i>
		<span>라벨명</span>
	</div>
<!-- label box 템플릿 끝 -->

<!-- 	role 시작 -->
	<div class="roleBox row">
		<div class="rolename col-md-1">
			<input type="text" placeholder="역할명" maxlength="8">
		</div>
		<div class="basic-form col-md-10">
			<div class="role_auth_list form-group row">
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
				<div class="col-md-1">
					<input type="checkbox" checked>
				</div>
			</div>
		</div>
		<div class="col-md-1">
			<button class="roleDeleteBtn btn btn-danger">삭제</button>
		</div>
	</div>
	<!-- 	role 끝 -->
</div>
<!-- template 끝 -->


<div class="container-fluid">

	<div class="col-lg-12">

		<!-- 	프로젝트 소개 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">프로젝트 소개</h4>
				<div class="basic-form">
					<div class="form-group">
						<label>해당 프로젝트에 대한 소개를 써주세요.</label>
						<textarea class="form-control h-150px" rows="6" id="mng_proj_cont"></textarea>
					</div>
					<button id="save_project_cont" style="float: right" class="btn btn-success">저장</button>
				</div>
			</div>
		</div>

		<!--          예정 마감일 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">프로젝트 종료 예정일</h4>
				<p class="text-muted">프로젝트 종료 예정일을 설정해주세요.</p>
				<div class="proj-finish-date form-material">
					<input id="mng_proj_end" class="datePick form-control" type="text">
					<div class="proj-close-btns">
						<button class="btn btn-success">열기</button>
						<button class="btn btn-danger">종료</button>
					</div>
				</div>
			</div>
		</div>

		<!--    모듈 사용 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">사용 모듈 설정</h4>
				<p class="text-muted">해당 프로젝트에서 사용할 모듈들을 체크해주세요</p>
				<div class="basic-form">
					<div id="mng_module" class="form-group">
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">마일스톤
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">이슈
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">간트
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">캘린더
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">칸반
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">뉴스
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">위키
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">통계
							</label>
						</div>
						<button id="saveModuleBtn" style="float: right" class="btn btn-success">저장</button>
					</div>
				</div>
			</div>
		</div>

		<!--      이슈 중요도 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">이슈 중요도 설정</h4>
				<p class="text-muted">해당 프로젝트에서 사용할 이슈 중요도들을 체크해주세요</p>
				<div class="basic-form">
					<div id="issue_module" class="form-group">
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">즉시
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">긴급
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">높음
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">보통
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">낮음
							</label>
						</div>
						<div class="form-check form-check-inline">
							<label class="form-check-label"> <input type="checkbox"
								class="form-check-input" value="">무시
							</label>
						</div>
						<button onclick="saveIssueSetting()" style="float: right" class="btn btn-success">저장</button>
					</div>
				</div>
			</div>
		</div>

		<!--      라벨 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">라벨 설정</h4>
				<p class="text-muted">이슈에 설정할 라벨들을 등록합니다. 우클릭으로 수정/삭제 할 수 있습니다.</p>
				<div id="labelBoxArea" class="basic-form">
					<div class="labelBox">
						<i class="icons icon-cursor"></i> <span>이벤트</span>
					</div>
					<div class="labelBox">
						<i class="icons icon-cursor"></i> <span>이벤트</span>
					</div>
					<div class="labelBox">
						<i class="icons icon-cursor"></i> <span>이벤트</span>
					</div>
					<div class="labelBox">
						<i class="icons icon-cursor"></i> <span>이벤트</span>
					</div>
				</div>
				<button onclick="labelAddModalSetting()" style="float: right" class="btn btn-success" data-toggle="modal" data-target="#addLabelModal">라벨추가</button>
			</div>
		</div>

		<!--      멤버 역할 및 권한 관리 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">멤버 역할 및 권한 관리
					<a class="lightbox" data-toggle="lightbox" href="/resources/images/presentation/binary.png">
					<i class="icon-question"></i>
				</a>
				</h4>
				<p class="text-muted">역할 별로 다른 권한을 부여할 수 있습니다.</p>
				<div id="rolehead">
					<div class="row">
						<div class="col-md-1">
							<span>역할 이름</span>
						</div>
						<div class="basic-form col-md-10">
							<div class="form-group row">
								<span class="rolelabel col-md-1">마일스톤수정</span> 
								<span class="rolelabel col-md-1">마일스톤삭제</span> 
								<span class="rolelabel col-md-1">이슈수정</span> 
								<span class="rolelabel col-md-1">뉴스등록</span>
								<span class="rolelabel col-md-1">뉴스수정</span> 
								<span class="rolelabel col-md-1">뉴스삭제</span>
								<span class="rolelabel col-md-1">칸반추가</span>
								<span class="rolelabel col-md-1">칸반수정</span>
								<span class="rolelabel col-md-1">칸반삭제</span>
								<span class="rolelabel col-md-1">위키추가</span>
								<span class="rolelabel col-md-1">위키수정</span>
								<span class="rolelabel col-md-1">위키삭제</span>
							</div>
						</div>
						<div class="col-md-1">
						</div>
					</div>
				</div>
				<div id="roleBoxArea">
				</div>
				<div class="roleBtnArea">
					<button onclick="addRoleTemplate();" class="btn btn-primary">추가</button>
					<button onclick="addAndEditRole()" id="editRoleBtn" class="btn btn-success">저장</button>
				</div>
			</div>
		</div>

	</div>
	
</div>













