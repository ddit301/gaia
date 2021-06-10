<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<style>
		table {
			text-align: center !important;
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
						<table id="inquiry-table" class="table table-striped ">
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

		function format(d) {
			// `d` is the original data object for the row
			return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">' +
				'<tr>' +
				'<td>질문자 : </td>' +
				'<td>' + d.mem_no + '</td>' +
				'</tr>' +
				'<tr>' +
				'<td>질문내용 : </td>' +
				'<td>' + d.inq_cont + '</td>' +
				'</tr>' +
				'<tr>' +
				'<td>첨부 파일 : </td>' +
				'<td><a>' + d.atch_file_sid + '</a></td>' +
				'</tr>' +
				'</table>';
		}

		function getInquiry() {
			$.ajax({
				url: getContextPath() + "/admin/inquiry/ListView",
				type: 'get',
				success: function (res) {
					table = $('#inquiry-table').DataTable({
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
						alert("status : " + xhr.status);
					}
				},
				dataType: 'json'
			})

		}
		getInquiry();


		$(document).ready(function () {


			$('#inquiry-table tbody').on('click', 'td.details-control', function () {
				var tr = $(this).closest('tr');
				var row = table.row(tr);

				if (row.child.isShown()) {
					row.child.hide();
					tr.removeClass('shown');
				}
				else {
					row.child(format(row.data())).show();
					tr.addClass('shown');
				}
			});


		});
	</script>