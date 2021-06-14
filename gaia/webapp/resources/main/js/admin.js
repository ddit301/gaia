/**
 * @author Robin
 * @since 2021. 5. 18
 * @version 1.0
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier        Modification
 * --------     --------    ----------------------
 * 2021. 5. 18      Robin      Initial Commit
 * Copyright (c) 2021 by Team SEED All right reserved
 * </pre>
 */


function monitoringDiv(id, title) {
	return '<div class="col-sm-8 col-sm-offset-2">' + '<h4 class="font-alt mb-0">' + title + '</h4>'
		+ '<hr class="divider-w mt-10 mb-20">'
		+'<div class="col-sm-10 col-sm-offset-1">'
		+ '<div id="' + id + '" class="row multi-columns-row monitoring-detail-div"></div></div></div>';
}

function monitoringDetailDiv(subtitle, divId) {
	return '<div class="col-sm-12 col-md-12 col-lg-12">' + '<div class="features-item">'
		+ '<h3 class="features-title font-alt">' + subtitle + '</h3>' +
		'<div id="' + divId + '"></div>' + '</div>' + '</div>';
}

function OSInformation(OS_Information) {
	return '<h6 class="features-subtitle font-alt">' + OS_Information['osName']
		+ ' [version: ' + OS_Information['osVersion'] + OS_Information['osArch'] + '] -'
		+ OS_Information['processorCount'] + '</h6>';
}

function JVMInformation(JVM_Information) {
	return '<h6 class="features-subtitle font-alt">' + JVM_Information['specName']
		+ JVM_Information['specVersion'] + ' ['
		+ JVM_Information['processorCount'] + '] </h6>'
		+ '<h6 class="features-subtitle font-alt">' + JVM_Information['vmName']
		+ JVM_Information['vmVersion'] +
		+JVM_Information['vmVendor'] + '</h6>';
}

function DiskInformation(Disk_Information) {
	let total = Disk_Information['total'].replace(/[^0-9]/g, '');
	let used = Disk_Information['used'].replace(/[^0-9]/g, '');
	let percentage = used / total * 100;
	return '<h6 class="features-subtitle font-alt">DISK: ' + Disk_Information['drive'] + '</h6>'
		+ '<h6 class="font-alt">TOTAL: ' + Disk_Information['total'] + ' / USED: ' + Disk_Information['used'] + ' / FREE: ' + Disk_Information['free'] + '</h6><br>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + used + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + percentage + '%;">'
		+ '<span class="font-alt" style="opacity: 1;">' + Math.round(percentage) + '</span>'
		+ '</div>'
		+ '</div>';
}

function MemoryUsageSummary(usage, Memory_Usage_Summary) {
	let max, used, commited, init;
	max = Memory_Usage_Summary['max'] / 1000000;
	used = Memory_Usage_Summary['used'] / 1000000;
	commited = Memory_Usage_Summary['commited'] / 1000000;
	init = Memory_Usage_Summary['init'] / 1000000;
	let percentage = commited / max * 100;
	if (percentage < 0) percentage = 100

	return '<h6 class="features-contents font-alt">' + usage + '</h6>'
		+ '<h6 class="font-alt">MAX: ' + (max / 1000).toFixed(2) + 'GB / COMMITED: ' + commited.toFixed(0) + 'MB [ USED:' + used.toFixed(0) + 'MB / INIT: ' + init.toFixed(0) + 'MB ] </h6><br>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + commited + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + max + '" style="width: ' + percentage + '%;">'
		+ '<span class="font-alt" style="opacity: 1;">' + Math.round(percentage) + '</span>'
		+ '</div>'
		+ '</div>';
}

function GarbageCollectionInformation(Garbage_Collection_Information) {
	let returnText = "";

	$.each(Garbage_Collection_Information, function (i, v) {
		returnText += '<h6 class="features-subtitle font-alt">' + i + ":" + v + '</h6>'
	})

	return returnText;
}

function ClassLoadingInformation(Class_Loading_Information) {
	let total = Class_Loading_Information['total loaded class'];
	let loaded = Class_Loading_Information['loaded class count'];
	let percentage = loaded / total * 100;
	return '<h6 class="features-contents font-alt">since JVM started</h6>'
		+ '<h6 class="font-alt">TOTAL: ' + total + ' classes / loaded: ' + loaded + ' classes / unloaded: ' + Class_Loading_Information['unloaded class count'] + ' classes</h6><br>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + loaded + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + percentage + '%;">'
		+ '<span class="font-alt" style="opacity: 1;">' + Math.round(percentage) + '</span>'
		+ '</div>'
		+ '</div>';
}

function ThreadSummary(Thread_Summary) {
	let total = Thread_Summary['totalThreadCount'];
	let live = Thread_Summary['liveThreadCount'];
	let peak = Thread_Summary['peakLiveThreadCount'];
	let daemon = Thread_Summary['daemonTheadCount'];
	return '<h6 class="features-subtitle font-alt">Thread Summary</h6>'
		+ '<h6 class="font-alt">TOTAL: ' + total + '</h6>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + total + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + total / total * 100 + '%;">'
		+ '</div>'
		+ '</div>'
		+ '<h6 class="font-alt">live: ' + live + '</h6>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + live + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + live / total * 100 + '%;">'
		+ '</div>'
		+ '</div>'
		+ '<h6 class="font-alt">peak: ' + peak + '</h6>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + peak + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + peak / total * 100 + '%;">'
		+ '</div>'
		+ '</div>'
		+ '<h6 class="font-alt">daemon: ' + daemon + '</h6>'
		+ '<div class="progress">'
		+ '<div class="progress-bar progress-bar-striped active" aria-valuenow="' + daemon + '" role="progressbar" aria-valuemin="0" aria-valuemax="' + total + '" style="width: ' + daemon / total * 100 + '%;">'
		+ '</div>'
		+ '</div><br>'
		+ '<button type="button" id="threadBtn" class="btn btn-sm btn-secondary" data-toggle="modal" data-target="#threadModal">'
		+ 'Thread Dump</button>';
}

function renderMonitoringData(res) {
	let OS_Information = res['Environment_Resource']['OS_Information'];
	let JVM_Information = res['Environment_Resource']['JVM_Information'];
	let Disk_Information = res['Environment_Resource']['Disk_Information'];
	let Memory_Usage_Summary1 = res['Memory']['Memory_Usage_Summary']['Heap Memory Usage'];
	let Memory_Usage_Summary2 = res['Memory']['Memory_Usage_Summary']['Non Heap Memory Usage'];
	let Garbage_Collection_Information = res['Memory']['Garbage_Collection_Information'];
	let Memory_Pool_Usage_Information = res['Memory']['Memory_Pool_Usage_Information'];
	let Compiler_Information = res['Class_Resource']['Compiler_Information'];
	let Class_Loading_Information = res['Class_Resource']['Class_Loading_Information'];
	let Thread_Summary = res['Thread']['Thread_Summary'];

	$('#OS_Information').append(OSInformation(OS_Information));
	$('#JVM_Information').append(JVMInformation(JVM_Information));
	$('#Disk_Information').append(DiskInformation(Disk_Information));
	$('#Memory_Usage_Summary').append(MemoryUsageSummary('Heap Memory Usage', Memory_Usage_Summary1));
	$('#Memory_Usage_Summary').append(MemoryUsageSummary('Non Heap Memory Usage', Memory_Usage_Summary2));
	$('#Garbage_Collection_Information').append(GarbageCollectionInformation(Garbage_Collection_Information));

	$.each(Memory_Pool_Usage_Information, function (i, v) {
		$('#Memory_Pool_Usage_Information').append('<h6 class="features-subtitle font-alt">' + i + '</h6>');
		$.each(v, function (index, value) {
			$('#Memory_Pool_Usage_Information').append(MemoryUsageSummary(index, value));
		});
		$('#Memory_Pool_Usage_Information').append("<br>");
	})
	$('#Compiler_Information').append(GarbageCollectionInformation(Compiler_Information));
	$('#Class_Loading_Information').append(ClassLoadingInformation(Class_Loading_Information));
	$('#Thread_Summary').append(ThreadSummary(Thread_Summary));
};

function loadMonitoring() {
	$.ajax({
		url: getContextPath() + "/admin/monitoring/info",
		type: 'GET',
		success: function (res) {
			$.each(res, function (index, value) {
				let id = index.toLowerCase();
				index = index.replace("_", " ");
				$('.monitoring-div').append(monitoringDiv(id, index));

				$.each(value, function (i, v) {
					let subtitle = i.replaceAll("_", " ");
					$('#' + id).append(monitoringDetailDiv(subtitle, i));
				})
			})
			renderMonitoringData(res);
		},
		async: true
		, error: function (xhr) {
			console.log(xhr);
			if (xhr.status == '404') {
				alert("실패");
			} else {
				$('.container').after('서버가 다운되었습니다.');
			}
		},
		dataType: 'json'
	})
}


function questionFormat(d) {
	return '<div class="col-sm-8 col-sm-offset-2" ><table id="q__' + d.inq_no + '" class="table table-detail inquiry-question-detail ">' +
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
		'<tr>' +
		'<td colspan="2"><button id="' + d.inq_no + '" class="a__check">답변 확인</button> </td>' +
		'</tr>' +
		'</table></div>';
}

function answerFormat(d) {
	return '<table id="a__' + d.inq_no + '" class="table table-detail inquiry-answer-table"><tr>' +
		'<td>답변자 : </td>' +
		'<td>' + d.prov_id + ' </td>' +
		'</tr>' +
		'<tr>' +
		'<td>답변일자 : </td>' +
		'<td>' + d.inq_com_date + '</td>' +
		'</tr>' +
		'<tr>' +
		'<td>답변내용 : </td>' +
		'<td> ' + d.inq_com_cont + '</td>' +
		'</tr>' +
		'<tr>' +
		'<td colspan="2"><button id="' + d.inq_com_no + '" class="a__modify">답변 수정</button> </td>' +
		'</tr></table>';
}

function modifyFormat(d) {
	return '<form id="answerForm" method="POST" >' +
		'<input name="inq_no" type="hidden" value="' + d[0].inq_no + '"></input>' +
		'<table id="' + d[0].inq_no + '" class="table table-detail inquiry-answer-table"><tr>' +
		'<td>답변내용 : </td>' +
		'<td><input name="inq_com_cont" class="form-control input-sm" type="text" value="' + d[0].inq_com_cont + '"></input></td>' +
		'</tr>' +
		'<tr>' +
		'<td colspan="2"><button type="submit" id="' + d[0].inq_com_no + '" class="a__insert">등록</button> </td>' +
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
	let id = ('q__' + inq_no);
	$.ajax({
		url: getContextPath() + "/admin/inquiry/Answer",
		data: { 'inq_no': inq_no },
		type: 'GET',
		success: function (res) {
			$('#' + id).after(answerFormat(res));
		},
		async: true
		, error: function (xhr) {
			console.log('error: ', xhr);
			if (xhr.status == '404') {
				alert("실패");
			} else {
				$('#' + id).after('<table id="a__' + inq_no + '" class="table table-detail inquiry-answer-table"><tr><td>등록된 답변이 없습니다.</td></tr><tr><td><button>답변 등록</button></td></tr></table>');
				// 						alert("status : " + xhr.status);
			}
		},
		dataType: 'json'
	})
}

function postInquiryAnswer() {
	let param = $('#answerForm');
	$.ajax({
		dataType: 'json',
		url: getContextPath() + "/admin/inquiry/Answer",
		type: 'POST',
		async: true,
		data: param.serialize(),
		success: function (res) {
			$('#answerForm').remove();
			let id = "q__" + res.inq_no;
			$('#' + id).after(answerFormat(res));
			toastr.success("답변을 등록하였습니다.");
		},
		error: function (xhr) {
			console.log('error: ', xhr);
			if (xhr.status == '404') {
				alert("실패");
			}
		},
		dataType: 'json'
	});
}



function getInquiryEvent() {
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
	$(document).on('click', '.a__check', function () {
		let inq_no = $(this).attr('id');
		let id = ('a__' + inq_no);
		if ($('#' + id).length) {
			$(this).html('답변 확인');
			$('#' + id).remove();
			return;
		} else {
			$(this).html('답변 닫기');
			getInquiryAnswer(inq_no);
			return;
		}

	});
	$(document).on('click', '.a__modify', function () {

		let paramData = new Array();

		let data = new Object();
		let id = $(this).attr('id');
		let answertable = $(this).parents('.inquiry-answer-table');

		data.inq_no = answertable.attr('id').substring(3);
		data.inq_com_no = id;
		data.prov_id = answertable.find('td').eq(1).text();
		data.inq_com_cont = $(answertable.find('td')[5]).text();

		paramData.push(data);

		let modifyForm = modifyFormat(paramData);
		$(answertable).replaceWith(modifyForm);
	});
	$(document).on('submit', '#answerForm', function (e) {
		e.preventDefault();
		postInquiryAnswer();
	});

}

function loadThreadDump() {
	$.ajax({
		url: getContextPath() + "/admin/monitoring/threadDump",
		type: 'GET',
		success: function (res) {
			console.log(res);
			$('#threadModal').find('.modal-body').append(res);
		},
		async: true
		, error: function (xhr) {
			if (xhr.status == '404') {
				toastr.error('소스가 유실되었습니다.');
			} else {
				console.log(xhr);
				toastr.warning('잘못된 설정');
			}
		},
		dataType: 'text'
	})
}

function getMonitoringEvent() {
	$(document).on('click', '#threadBtn', function () {
		loadThreadDump();
	});
}

