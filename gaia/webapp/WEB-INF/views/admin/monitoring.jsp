<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="main">
	<section class="module">
		<div class="container">
			<div class="row monitoring-div">
<!-- 				<div class="col-sm-8 col-sm-offset-2"> -->
<!-- 					<h4 class="font-alt mb-0">EnvironmentResource</h4> -->
<!-- 					<hr class="divider-w mt-10 mb-20"> -->
<!-- 					<div class="row multi-columns-row"> -->
					
					
					
<!-- 					<div class="col-sm-6 col-md-6 col-lg-6"> -->
<!-- 						<div class="features-item"> -->
<!-- 							<div class="features-icon"> -->
<!-- 								<span class="icon-lightbulb"></span> -->
<!-- 							</div> -->
<!-- 							<h3 class="features-title font-alt">JVM Information</h3> -->
<%-- 							${map.JVMInformation } --%>
<!-- 						</div> -->
<!-- 						</div><div class="col-sm-6 col-md-6 col-lg-6"> -->
<!-- 						<div class="features-item"> -->
<!-- 							<div class="features-icon"> -->
<!-- 								<span class="icon-lightbulb"></span> -->
<!-- 							</div> -->
<!-- 							<h3 class="features-title font-alt">Disk Information</h3> -->
<%-- 							${map.DiskInformation } --%>
<!-- 						</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->

<%-- 				<pre>${info }</pre> --%>

			</div>
		</div>
	</section>
</div>
<button type="button" id="btn" class="btn btn-secondary">Thread
	Dump</button>


<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Thread Dump</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<pre>
      	
      	</pre>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

	function monitoringDiv(id, title){
		return '<div class="col-sm-8 col-sm-offset-2">'+
		'<h4 class="font-alt mb-0">'+title+'</h4>'+
		'<hr class="divider-w mt-10 mb-20">'+
		'<div id="'+id+'" class="row multi-columns-row monitoring-detail-div"></div></div>';
	}

	function monitoringDetailDiv(subtitle, content){
		let detailContents = "";
		$.each(content, function(i, v){
// 			detailContents += i;
			detailContents += v;
		});
		
		return '<div class="col-sm-12 col-md-12 col-lg-12">'+
			'<div class="features-item">'+
// 				'<div class="features-icon">'+
// 					'<span class="icon-lightbulb"></span>'+
// 				'</div>'+
				'<h3 class="features-title font-alt">'+ subtitle +'</h3>'+
// 				detailContents+
				'내용 Content'+
			'</div>'+
		'</div>';
	}


	function loadMonitoring(){
		$.ajax({
			url: getContextPath() + "/admin/monitoring/info",
			type: 'GET',
			success: function (res) {
				console.log("EnvironmentResource",res.Environment_Resource);
				
				$.each(res, function(index, value){
					let id = index.toLowerCase();
					index = index.replace("_", " ");
					$('.monitoring-div').append(monitoringDiv(id, index));
					
					$.each(value, function(i, v){
						console.log(id);
						i = i.replaceAll("_", " ");
						$('#' + id).append(monitoringDetailDiv(i, v));
					})
			        console.log(index, ": " , value);
			    })
				
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

	$(document).ready(function () {
		loadMonitoring();
		$("#btn").on("click", function() {
			window.open("monitoring/threadDump");
		});
	});
</script>