<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
            <div class="container-fluid">
            </div>
            
            <div id="myKanban">
            </div>


<div id="kanban-template" hidden="hidden" >
	<div class="kanban_card row">
		<div class="col-md-1">
			<i class="icon-speech"></i>
		</div>
		<div class="col-md-9">
			<div class="card_content">
				<div class="issue_title">
					<a href="#"></a>
				</div>
				<div class="issue_writer">
					#<span></span> opened by <span></span>
				</div>
				<div class="issue_label"></div>
				<div class="issue_milestone"></div>
			</div>
		</div>
		<div class="col-md-1">
			<i class="icon-options menu-icon"></i>
		</div>
	</div>
</div>
			    
  
 <script>
 
 	// 해당 페이지 열렸을때 실행될 코드
	$(function(){
		let rightClickedCard = null;
		
		// sweetAlert 버튼 초기화
		 swalWithBootstrapButtons = Swal.mixin({
			  customClass: {
				cancelButton: 'btn btn-light',
			   	confirmButton: 'btn btn-danger'
			  },
			  buttonsStyling: false
		})	
		
		// 칸반 보드 받아오기
		let board = getKanbaBoard();
		makeKanban(board);
		
	});	 
	 
	 
</script>
    
             
             
             
             
             