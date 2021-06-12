<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<style>
		table {
			text-align: center !important;
			vertical-align: middle !important;
		}

		td.details-control {
			background: url('../resources/main/images/details_open.png') no-repeat center center;
			background-size: 1.5rem;
			cursor: pointer;
		}

		tr.shown td.details-control {
			background: url('../resources/main/images/details_close.png') no-repeat center center;
			background-size: 1.5rem;
			cursor: pointer;
		}
	</style>

	<div class="main">
		<section class="module">
			<div class="container">
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3">
						<h1 class="module-title font-alt">문의내역</h1>
					</div>
				</div>
				<hr class="divider-w pt-20">
				<div class="row">
					<div class="col-sm-12">
						<table id="inquiry-question-table" class="table table-striped ">
							<thead>
								<tr class="navbar-custom">
									<th></th>
									<th>INQ_NO</th>
									<th>질문자 </th>
									<th>질문일시 </th>
									<th>답변상태 </th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</section>
	</div>
	<!--  
    JavaScripts
    =============================================
    -->
	<script type="text/javascript" src="/resources/main/js/inquiry.js">

	</script>
	<script type="text/javascript" class="init">

		$(document).ready(function () {
			getInquiryQuestion();
			getEvent();
		});

	</script>