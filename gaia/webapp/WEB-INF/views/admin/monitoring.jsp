<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="main">
	<section class="module">
		<div id="hiddenAA">
			<a id="hiddenBtt" class="font-alt">GAIA</a>
		</div>
		<div class="container">
			<div class="row monitoring-div">
			</div>
			
		</div>
	</section>
</div>


<!-- Modal -->
<div class="modal fade" id="threadModal" tabindex="-1" role="dialog" aria-labelledby="threadModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title font-alt" id="myModalLabel">Thread Dump</h4>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
	$(document).ready(function () {
		loadMonitoring();
		getMonitoringEvent();
		
		$('#hiddenBtt').on('click', function(){
			console.log('dd');
			let img = '<img src = "${cPath }/resources/images/presentation/admin/admin.png">'
			$('.module').prepend(img);
		})
		
	});
</script>