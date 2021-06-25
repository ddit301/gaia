<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(function(){
		scrollUp();
		loadAnalytics();
	})
	
</script>


<div id="statTemplate" hidden="true">
	<!-- 						member 한명 시작 -->
	<div class="mem-stat-box row">
		<div class="col-md-2">
			<img src="/resources/images/profiles/4" class="profile" onerror="imgOnErr()">
			<span>팀장꼬북</span>
		</div>
		<span class="col-md-2">2020-11-14</span>
		<span class="col-md-1">PL</span>
		<span class="col-md-1">13</span>
		<span class="col-md-1">41</span>
		<span class="col-md-1">51</span>
		<span class="col-md-1">22</span>
		<span class="col-md-1">5</span>
		<span class="col-md-1">3</span>
		<span class="col-md-1">12</span>
	</div>
<!-- 						member 한명 종료 -->
</div>


<div class="container-fluid">
	<div class="col-md-12">
		<!-- 	프로젝트 진행 상황 -->
		<div class="row">
			<div class="card proj-going col-md-12">
				<div class="card-body">
					<h4 class="card-title">프로젝트 진행상황</h4>
					<div class="basic-form">
						<div class="form-group">
							<label>프로젝트 공정률 및 진척도</label>
						</div>
					</div>
					<div class="date-stauts row">
						<div class="col-md-5">
							<i class="icon icon-calender"></i>
							<span>2020.11.14 ~ 2021.06.28</span>
						</div>
						<div class="col-md-7">
							<div class="progress-area">
								<div class="progress-bar bg-success" role="progressbar" style="width:0%">92.8%</div>
							</div>
						</div>
					</div>
					<div class="progress-status row">
						<div class="col-md-5">
							<i class="icon icon-docs"></i>
							<span>총 132개의 일감중 102개 완료.</span>
						</div>
						<div class="col-md-7">
							<div class="progress-area">
								<div class="progress-bar bg-success" role="progressbar" style="width:0%">92.8%</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row proj-stat">
	<!-- 		project 통계1 -->
			<div class="stat1 col-md-6">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">프로젝트 통계</h4>
						<div class="basic-form">
							<div class="form-group">
								<label>마일스톤, 이슈 데이터</label>
							</div>
						</div>
<!-- 						stat data 시작 -->
						<div class="stat-data">
<!-- 						개별 스탯 -마일스톤 시작 -->
							<div class="row stat-milestone">
								<div class="col-md-4">
									<i class="icon icon-directions"></i>
									<span>마일스톤</span>
								</div>
								<div class="stat-num col-md-4">
									<span>125</span>
								</div>
								<div class="col-md-2">
									<i class="icon-check"></i>
									<span>120</span>
								</div>
								<div class="col-md-2">
									<i class="icon-close"></i>
									<span>5</span>
								</div>
							</div>
<!-- 						개별 스탯 -이슈 시작 -->
							<div class="row stat-issue">
								<div class="col-md-4">
									<i class="icon icon-fire"></i>
									<span>이슈</span>
								</div>
								<div class="stat-num col-md-4">
									<span>125</span>
								</div>
								<div class="col-md-2">
									<i class="icon-check"></i>
									<span>120</span>
								</div>
								<div class="col-md-2">
									<i class="icon-close"></i>
									<span>5</span>
								</div>
							</div>
<!-- 							개별스탯 이슈 종료 -->
<!-- 						개별 스탯 - 이슈 히스토리 시작 -->
							<div class="row stat-issue-history">
								<div class="col-md-4">
									<i class="icon icon-puzzle"></i>
									<span>히스토리</span>
								</div>
								<div class="stat-num col-md-4">
									<span>125</span>
								</div>
							</div>
<!-- 							개별스탯 이슈 히스토리 종료 -->
<!-- 						개별 스탯 - 라벨 시작 -->
							<div class="row stat-label">
								<div class="col-md-4">
									<i class="icon icon-list"></i>
									<span>라벨</span>
								</div>
								<div class="stat-num col-md-4">
									<span>12</span>
								</div>
							</div>
<!-- 							개별스탯 라벨 종료 -->
<!-- 						개별 스탯 - 멤버 역할 수 시작 -->
							<div class="row stat-role">
								<div class="col-md-4">
									<i class="icon icon-user"></i>
									<span>멤버 역할</span>
								</div>
								<div class="stat-num col-md-4">
									<span>1</span>
								</div>
							</div>
<!-- 							개별스탯 멤버 열할 수  종료 -->
						</div>
<!-- 					개별 스탯 종료 -->
					</div>
				</div>
			</div>
	<!-- 		project 통계2 -->
			<div class="stat2 col-md-6">
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">모듈별 통계</h4>
						<div class="basic-form">
							<div class="form-group">
								<label>뉴스, 칸반, 위키</label>
							</div>
						</div>
				<!-- 						stat data 시작 -->
						<div class="stat-data">
			<!-- 						개별 스탯 - 칸반 컬럼 시작 -->
							<div class="row stat-col">
								<div class="col-md-4">
									<i class="icon icon-cursor-move"></i>
									<span>칸반 컬럼</span>
								</div>
								<div class="stat-num col-md-4">
									<span>3</span>
								</div>
							</div>
			<!-- 						개별 스탯 - 칸반 카드 시작 -->
							<div class="row stat-card">
								<div class="col-md-4">
									<i class="icon icon-credit-card"></i>
									<span>칸반 카드</span>
								</div>
								<div class="stat-num col-md-4">
									<span>32</span>
								</div>
							</div>
			<!-- 						개별 스탯 - 칸반 뉴스 시작 -->
							<div class="row stat-news">
								<div class="col-md-4">
									<i class="icon icon-book-open"></i>
									<span>뉴스</span>
								</div>
								<div class="stat-num col-md-4">
									<span>32</span>
								</div>
							</div>
			<!-- 						개별 스탯 - 뉴스 댓글 시작 -->
							<div class="row stat-news-com">
								<div class="col-md-4">
									<i class="icon icon-bubbles"></i>
									<span>뉴스 댓글</span>
								</div>
								<div class="stat-num col-md-4">
									<span>321</span>
								</div>
							</div>
			<!-- 						개별 스탯 - 위키 시작 -->
							<div class="row stat-wiki">
								<div class="col-md-4">
									<i class="icon icon-notebook"></i>
									<span>위키</span>
								</div>
								<div class="stat-num col-md-4">
									<span>32</span>
								</div>
							</div>
<!-- 							개별스탯 칸반 카드 종료 -->
						</div>
				<!-- 						stat data 종료 -->
					</div>
				</div>
			</div>
<!-- 		통계 2 끝 -->
		</div>
		<div class="row">
	<!-- 		member 통계 -->
			<div class="card col-md-12">
				<div class="card-body">
					<h4 class="card-title">멤버별 통계</h4>
					<div class="basic-form">
						<div class="form-group">
							<label id="ana-memcount"></label>
						</div>
					</div>
					<div id="mem-stat-header">
						<div class="row">
							<span class="col-md-2">회원정보</span>
							<span class="col-md-2">가입일</span>
							<span class="col-md-1">역할</span>
							<span class="col-md-1">마일스톤</span>
							<span class="col-md-1">이슈</span>
							<span class="col-md-1">이슈댓글</span>
							<span class="col-md-1">담당</span>
							<span class="col-md-1">위키</span>
							<span class="col-md-1">뉴스</span>
							<span class="col-md-1">뉴스댓글</span>
						</div>
					</div>
					<div id="mem-stat-area">
<!-- 						member 한명 시작 -->
						<div class="mem-stat-box row">
							<div class="col-md-2">
								<img src="/resources/images/profiles/4" class="nonlink profile" onerror="imgOnErr()">
								<span>팀장꼬북</span>
							</div>
							<span class="col-md-2">2020-11-14</span>
							<span class="col-md-1">PL</span>
							<span class="col-md-1">13</span>
							<span class="col-md-1">41</span>
							<span class="col-md-1">51</span>
							<span class="col-md-1">22</span>
							<span class="col-md-1">5</span>
							<span class="col-md-1">3</span>
							<span class="col-md-1">12</span>
						</div>
<!-- 						member 한명 종료 -->
<!-- 						member 한명 시작 -->
						<div class="mem-stat-box row">
							<div class="col-md-2">
								<img src="/resources/images/profiles/4" class="profile" onerror="imgOnErr()">
								<span>팀장꼬북</span>
							</div>
							<span class="col-md-2">2020-11-14</span>
							<span class="col-md-1">PL</span>
							<span class="col-md-1">13</span>
							<span class="col-md-1">41</span>
							<span class="col-md-1">51</span>
							<span class="col-md-1">22</span>
							<span class="col-md-1">5</span>
							<span class="col-md-1">3</span>
							<span class="col-md-1">12</span>
						</div>
<!-- 						member 한명 종료 -->
<!-- 						member 한명 시작 -->
						<div class="mem-stat-box row">
							<div class="col-md-2">
								<img src="/resources/images/profiles/4" class="profile" onerror="imgOnErr()">
								<span>팀장꼬북</span>
							</div>
							<span class="col-md-2">2020-11-14</span>
							<span class="col-md-1">PL</span>
							<span class="col-md-1">13</span>
							<span class="col-md-1">41</span>
							<span class="col-md-1">51</span>
							<span class="col-md-1">22</span>
							<span class="col-md-1">5</span>
							<span class="col-md-1">3</span>
							<span class="col-md-1">12</span>
						</div>
<!-- 						member 한명 종료 -->
					</div>
				</div>
			</div>
		
		</div>
	</div>

	<div class="ga-datas">
<!-- 			browser -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22browser%22%5D&r=user-technology-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/browser.png">
			</a>
<!-- 			OS -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22operatingSystem%22%5D&r=user-technology-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/os.png">
			</a>
<!-- 		device -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22deviceCategory%22%5D&r=user-technology-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/device.png">
			</a>
<!-- 			language -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22language%22%5D&r=user-demographics-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/language.png">
			</a>
<!-- 			resolution -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22screenResolution%22%5D&r=user-technology-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/resolution.png">
			</a>
<!-- 			city -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22city%22%5D&r=user-demographics-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/city.png">
			</a>
<!-- 			time -->
			<a>
				<img src="${cPath}/resources/images/analytics/time.png">
			</a>
<!-- 		last 30min -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/realtime/overview?params=_u..nav%3Ddefault" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/last.png">
			</a>
<!-- 			cohort -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/dashboard?params=_u..nav%3Ddefault%26_u.date00%3D20210513%26_u.date01%3D20210623&r=lifecycle-retention-overview" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/cohort.png">
			</a>
<!-- 			title -->
			<a>
				<img src="${cPath}/resources/images/analytics/title.png">
			</a>
<!-- 		country -->
			<a href="https://analytics.google.com/analytics/web/?utm_source=marketingplatform.google.com&utm_medium=et&utm_campaign=marketingplatform.google.com%2Fabout%2Fanalytics%2F#/p273331838/reports/explorer?params=_u..nav%3Ddefault%26_r.explorerCard..selmet%3D%5B%22activeUsers%22%5D%26_r.explorerCard..seldim%3D%5B%22country%22%5D&r=user-demographics-detail" target=”_blank”>
				<img src="${cPath}/resources/images/analytics/country.png">
			</a>
<!-- 			user -->
			<a>
				<img src="${cPath}/resources/images/analytics/user.png">
			</a>
	</div>
</div>