<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <link href="${cPath }/resources/dist/jkanban.min.css" rel="stylesheet" >
     <link href="${cPath }/resources/assets/css/kanban.css" rel="stylesheet">
     
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>

            <div class="container-fluid">
				<h4>Kanban Board</h4>
				조회중인 프로젝트 생성자 : ${manager_nick }<br/>
				조회중인 프로젝트 타이틀 : ${project_title }
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
			    
<script type="text/javascript" src="${cPath }/resources/dist/jkanban.js"></script>         
  
 	<script>
	 // ajax로 칸반 컬럼들 먼저 받아오기
	 boards = new Array();
	 $.ajax({
			url : getContextPath() + '/restapi/project/kanban-columns',
			type : 'get',
			success : function(res) {
				// 받아온 컬럼들의 데이터를 칸반 API 형식에 맞게 변환시킨다.
				for(i in res){
					let column = new Object();
					// id 는 항상 _ 로 시작해야 합니다. 이거 안하면 아이디로 인식을 안해서 카드가 안움직입니다..
					column.id = '_'+res[i].kb_col_no;
					column.title = res[i].kb_col_nm;
					
					column.item = new Array();
					for(j in res[i].cardList){
						let card = new Object();
						card.id = '_'+res[i].cardList[j].kb_card_no;
						// 해당 카드가 이슈에 연관된 카드 일 경우
						let cardCont = $('#kanban-template').children('.kanban_card').clone();
						let issue = res[i].cardList[j].issue
						if(issue){
							cardCont.children('div:first').find('i').removeClass('icon-speech');
							cardCont.children('div:first').find('i').addClass('icon-fire');
							// div clas""kanban-item" 에 data-issue-sid 로 이슈 번호를 기록해둔다.
							card.issue_sid = issue.issue_sid;
							cardCont.find('.issue_title a').text(issue.issue_title);
							cardCont.find('.issue_writer span:first').text(issue.issue_no);
							cardCont.find('.issue_writer span:last').text(issue.writer.mem_nick);
							if(issue.label){
								cardCont.find('.issue_label').text(issue.label.label_nm);
							}
							if(issue.milestone){
								cardCont.find('.issue_milestone').html('<i class="icon-directions"></i> '+issue.milestone.milest_title);
							}
						}else{
							cardCont.find('.card_content').text(res[i].cardList[j].kb_card_cont);
						}
						card.title = cardCont.wrap("<div/>").parent().html();
						column.item.push(card);
					}
					boards.push(column);
				}
			},
			error : function(xhr, error, msg) {
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
			,async : false
		})
		
      var KanbanTest = new jKanban({
    	  
    	// 칸반 보드로 쓸 div에 대한 셀렉터
        element: "#myKanban"
        // 칸반 컬럼간의 간격
        ,gutter: "10px"
        // 칸반 컬럼들의 가로 길이
        ,widthBoard: "350px"
        // 컬럼 크기 상대적으로 지정하려면 true. 이 경우에는 gutter와 widthBoard가 필요 없음.
        ,responsivePercentage : false
        // 위에서 만든 컬럼들을 가진 boards 객체를 등록해준다.
        ,boards: boards
        // 카드 클릭 이벤트
        ,click: function(el) {
          console.log("Trigger on all items click!");
        }
      	// 카드 우클릭 이벤트
        ,context: function(el, e) {
          console.log("Trigger on all items right-click!");
        }
      	// 카드 드랍 이벤트
        ,dropEl: function(el, target, source, sibling){
            
        	let droppedCardNo = el.getAttribute('data-eid').substring(1);
        	let newColumnNo = target.parentElement.getAttribute('data-id').substring(1);
        	let nextCardNo = null;
        	if(sibling){
	        	nextCardNo = sibling.getAttribute('data-eid').substring(1);
        	}
        	
			$.ajax({
				url : getContextPath()+'/restapi/project/kanban/moveCard.do',
				type : 'post',
				data : {
					'droppedCardNo' : droppedCardNo
					,'newColumnNo' : newColumnNo
					,'nextCardNo' : nextCardNo
				},
				success : function(res) {
					if(res.result != 'OK'){
						alert('kanban Card 이동에 실패했습니다. 상황을 Shane 에게 알려주세요.');
					}
				}
				,error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
				},
				dataType : 'json',
				async : false
			})
			
          console.log('변경 한 카드 번호 : ' + droppedCardNo);
          console.log('변경 후 다음 카드 번호 : ' + nextCardNo);
          console.log(el);
          console.log(target);
          console.log(source);
          console.log(sibling);
        }
        ,buttonClick: function(el, boardId) {
        
          // 카드 추가 중이던 기존의 모든 작성 폼 먼저 삭제 ( 폼 2개 있을때 취소/작성 버그가 있는걸 발견해서 추가 했음)
          $('form').remove();
          kb_col_no = boardId.substring(1);
          
          // 카드 추가를 위한 폼을 생성한다.
          var formItem = document.createElement("form");
          formItem.setAttribute("class", "itemform");
          formItem.innerHTML =
            '<div class="form-group"><textarea class="form-control" rows="2" autofocus></textarea></div><div class="form-group"><button type="submit" class="btn btn-primary btn-xs pull-right">저장</button><button type="button" id="CancelBtn" class="btn btn-default btn-xs pull-right">취소</button></div>';
          KanbanTest.addForm(boardId, formItem);
          
          // 카드 정보 입력 다 하고 실제 등록시 이벤트
          formItem.addEventListener("submit", function(e) {
            e.preventDefault();
            var text = e.target[0].value;
            
            // ajax에서 새 카드 추가 한 뒤에, 새로운 카드의 id를 받아온다.
            $.ajax({
				url : '${cPath}/restapi/project/kanban-cards',
				method : 'post',
				data : {
					'kb_col_no' : kb_col_no
					,'kb_card_cont' : text
				},
				success : function(res) {
		            // 카드 템플릿을 받아와 새로운 카드 객체를 만든다.
		            let cardCont = $('#kanban-template').children('.kanban_card').clone();
		            cardCont.find('.card_content').text(text);
		            KanbanTest.addElement(boardId, {
		            	// 위에서 받아온 아이디로 엘리먼트를 만들어서 넣는다.
		           	  id : '_'+res.kb_card_no
		              ,title: cardCont.wrap("<div/>").parent().html()
		            });
				},
				error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
				},
				dataType : 'json'
				,async : false
			})
            formItem.parentNode.removeChild(formItem);
            
          });
          
          // 카드 추가 취소 버튼 누를때 formitem 삭제
          document.getElementById("CancelBtn").onclick = function() {
            formItem.parentNode.removeChild(formItem);
          };
        }
        ,itemAddOptions: {
          enabled: true,
          content: '+ 카드 추가',
          class: 'btn btn-success',
          footer: true
        }

      });
    </script>
    
             
             
             
             
             