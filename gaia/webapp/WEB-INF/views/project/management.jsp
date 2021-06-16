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
	})
</script>


<div class="container-fluid">

	<div class="col-lg-12">

		<!-- 	프로젝트 소개 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">프로젝트 소개</h4>
				<div class="basic-form">
					<div class="form-group">
						<label>해당 프로젝트에 대한 소개를 써주세요.</label>
						<textarea class="form-control h-150px" rows="6" id="comment"></textarea>
					</div>
					<button style="float: right" class="btn btn-success">저장</button>
				</div>
			</div>
		</div>

		<!--          예정 마감일 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">프로젝트 예정 마감일</h4>
				<p class="text-muted">프로젝트 마감 예정일을 설정해주세요.</p>
				<div class="row form-material">
					<div class="col-md-6">
						<input class="datePick form-control" type="text">
					</div>
				</div>
				<button style="float: right" class="btn btn-success">저장</button>
			</div>
		</div>

		<!--    모듈 사용 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">사용 모듈 설정</h4>
				<p class="text-muted">해당 프로젝트에서 사용할 모듈들을 체크해주세요</p>
				<div class="basic-form">
					<form>
						<div class="form-group">
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
									class="form-check-input" value="">클라우드
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
							<button style="float: right" class="btn btn-success">저장</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!--      이슈 중요도 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">이슈 중요도 설정</h4>
				<p class="text-muted">해당 프로젝트에서 사용할 이슈 중요도들을 체크해주세요</p>
				<div class="basic-form">
					<form>
						<div class="form-group">
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
							<button style="float: right" class="btn btn-success">저장</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!--      라벨 설정 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">라벨 설정</h4>
				<p class="text-muted">이슈에 설정할 라벨들을 등록합니다. 우클릭으로 수정/삭제 할 수 있습니다.</p>
				<div class="basic-form">
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
				<button style="float: right" class="btn btn-success">라벨추가</button>
			</div>
		</div>

		<!--      멤버 역할 및 권한 관리 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">멤버 역할 및 권한 관리</h4>
				<p class="text-muted">역할 별로 다른 권한을 부여할 수 있습니다.</p>
				<div id="rolehead">
					<div class="row">
						<div class="col-md-1">
							<span>역할 이름</span>
						</div>
						<div class="basic-form col-md-11">
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
					</div>
				</div>
<!-- 				rolehead끝 -->
				<div id="rolebody">
<!-- 				role 시작 -->
					<div class="row">
						<div class="col-md-1">
							<span>관리자</span>
						</div>
						<div class="basic-form col-md-11">
							<div class="form-group row">
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
							</div>
						</div>
					</div>
	<!-- 				role 끝 -->
<!-- 				role 시작 -->
					<div class="row">
						<div class="col-md-1">
							<span>PL</span>
						</div>
						<div class="basic-form col-md-11">
							<div class="form-group row">
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
							</div>
						</div>
					</div>
	<!-- 				role 끝 -->
<!-- 				role 시작 -->
					<div class="row">
						<div class="col-md-1">
							<span>AA</span>
						</div>
						<div class="basic-form col-md-11">
							<div class="form-group row">
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
								<div class="col-md-1">
									<input type="checkbox">
								</div>
							</div>
						</div>
					</div>
	<!-- 				role 끝 -->
				</div>
<!-- 				rolebody 끝 -->
				<button style="float: right" class="btn btn-success">저장</button>
			</div>
		</div>




	</div>













</div>
