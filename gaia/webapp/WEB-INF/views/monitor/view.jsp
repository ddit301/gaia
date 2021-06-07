<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<pre>
${info }
</pre>
<button type="button" id="btn" class="btn btn-secondary">Thread Dump</button>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Thread Dump</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
	$(function(){
		$("#btn").on("click", function(){
			window.open("monitoring/threadDump");
		});
	});
</script>