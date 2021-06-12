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



	<script type="text/javascript" class="init">

		function questionFormat(d) {
			return '<div class="col-sm-8 col-sm-offset-2" ><table id="q__'+d.inq_no +'" class="table table-detail inquiry-question-detail ">' +
				'<tr>' +
				'<td>질문자 : </td>' +
				'<td class="q__table">' + d.mem_no + '</td>' +
				'</tr>' +
				'<tr>' +
				'<td>첨부 파일 : </td>' +
				'<td><a>' + d.atch_file_sid + '</a></td>' +
				'</tr>' +
				'<tr>' +
				'<td>질문내용 : </td>' +
				'<td>' + d.inq_cont + '</td>' +
				'</tr>' +
				'<tr>'+
				'<td colspan="2"><button id="'+d.inq_no +'" class="a__check">답변 확인</button> </td>'+
				'</tr>'+
				'</table></div>';
		}
    	
		function answerFormat(d) {
			return '<table id="a__'+d.inq_no +'" class="table table-detail inquiry-answer-table"><tr>' +
				'<td>답변자 : </td>' +
				'<td>' + d.prov_id + ' </td>' +
				'</tr>' +
				'<tr>' +
				'<td>답변일자 : </td>' +
				'<td>'+d.inq_com_date+'</td>' +
				'</tr>' +
				'<tr>' +
				'<td>답변내용 : </td>' +
				'<td> '+d.inq_com_cont+'</td>' +
				'</tr>' +
				'<tr>'+
				'<td colspan="2"><button id="'+d.inq_com_no+'" class="a__modify">답변 수정</button> </td>'+
				'</tr></table>';
		}
		
// 		[{inq_no":"a__3","inq_com_no":"3","prov_id":"admin1 ","inq_com_cont":" 문의 답변 내용 3"}]
		function modifyFormat(d) {
			return '<form id="answerForm" method="POST" >'+
			'<input name="inq_no" type="hidden" value="'+d[0].inq_no+'"></input>'+
			'<table id="'+d[0].inq_no +'" class="table table-detail inquiry-answer-table"><tr>' +
				'<td>답변내용 : </td>' +
				'<td><input name="inq_com_cont" class="form-control input-sm" type="text" value="'+d[0].inq_com_cont+'"></input></td>' +
				'</tr>' +
				'<tr>'+
				'<td colspan="2"><button type="submit" id="'+d[0].inq_com_no+'" class="a__insert">등록</button> </td>'+
				'</tr></table></form>';
		}
		
		
		

		function getInquiryQuestion() {
			$.ajax({
				url: getContextPath() + "/admin/inquiry/QuestionListView",
				type: 'GET',
				success: function (res) {
					table = $('#inquiry-question-table').DataTable({
						data: res,
						columns: [
							{
								"className": 'details-control',
								"orderable": false,
								"data": null,
								"defaultContent": ''
							},
							{ data: 'inq_no' },
							{ data: 'mem_no' },
							{ data: 'inq_date' },
							{ data: 'inq_status_yn' }
						],
						order: [[3, 'desc']],
						buttons: [
							'copy', 'excel', 'pdf'
						]
					});
				},
				async: true
				, error: function (xhr) {
					console.log(xhr);
					if (xhr.status == '404') {
						alert("실패");
					} else {
						$('#inquiry-question-table').after('등록된 문의가 없습니다.');
// 						alert("status : " + xhr.status);
					}
				},
				dataType: 'json'
			})
		}
		
		function getInquiryAnswer(inq_no) {
		 	let id = ('q__'+inq_no);
			$.ajax({
				url: getContextPath() + "/admin/inquiry/Answer",
				data: {'inq_no': inq_no},
				type: 'GET',
				success: function (res) {
					$('#'+id).after(answerFormat(res));
				},
				async: true
				, error: function (xhr) {
					console.log('error: ',xhr);
					if (xhr.status == '404') {
						alert("실패");
					} else {
						$('#'+id).after('<table id="a__'+inq_no +'" class="table table-detail inquiry-answer-table"><tr><td>등록된 답변이 없습니다.</td></tr><tr><td><button>답변 등록</button></td></tr></table>');
// 						alert("status : " + xhr.status);
					}
				},
				dataType: 'json'
			})
		}
		
		function postInquiryAnswer(){
		    let param = $('#answerForm');
			$.ajax({
		        dataType : 'json', 
		        url: getContextPath() + "/admin/inquiry/Answer",
		        type: 'POST',
		        async: true,
		        data: param.serialize(),
		        success: function(res){
		        	$('#answerForm').remove();
		            let id = "q__" + res.inq_no;
		            $('#'+id).after(answerFormat(res));
		        },
		        error: function(xhr){
		        	console.log('error: ',xhr);
					if (xhr.status == '404') {
						alert("실패");
					}
		        },
		        dataType: 'json'
			});
		}

		$(document).ready(function () {
			getInquiryQuestion();
			getEvent();
		});
		
		
		function getEvent(){
			$('#inquiry-question-table tbody').on('click', 'td.details-control', function () {
				let tr = $(this).closest('tr');
				let row = table.row(tr);

				if (row.child.isShown()) {
					row.child.hide();
					tr.removeClass('shown');
				}
				else {
					row.child(questionFormat(row.data())).show();
					tr.addClass('shown');
				}
			});
			 $(document).on('click', '.a__check', function(){
				let inq_no = $(this).attr('id');
				let id = ('a__'+inq_no);
				if($('#'+id).length){
					$(this).html('답변 확인');
					$('#'+id).remove();
					return;
				} else{
					$(this).html('답변 닫기');
					getInquiryAnswer(inq_no);
					return;
				}
				
			});
			$(document).on('click', '.a__modify', function(){
				
				let paramData = new Array();
				
				let data = new Object() ;
				let id = $(this).attr('id');
				let answertable = $(this).parents('.inquiry-answer-table');
				
				data.inq_no = answertable.attr('id').substring(3);
				data.inq_com_no = id;
				data.prov_id = answertable.find('td').eq(1).text();
				data.inq_com_cont = $(answertable.find('td')[5]).text();
				
				paramData.push(data);
				
				let modifyForm = modifyFormat(paramData);
				$( answertable ).replaceWith(modifyForm);
			});
			$(document).on('submit', '#answerForm', function(e){
				e.preventDefault();
				postInquiryAnswer();
			});
			
		}
	</script>