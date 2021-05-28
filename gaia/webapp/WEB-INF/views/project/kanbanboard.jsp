<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <link href="${cPath }/resources/assets/css/kanban.css" rel="stylesheet">
     <link href="${cPath }/resources/dist/jkanban.min.css" rel="stylesheet" >
     
     
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
            
            <div id="myKanban"></div>
		    <button id="addDefault">Add "Default" board</button>
		    <br />
		    <button id="removeBoard">Remove "Done" Board</button>
		    <br />
		    <button id="removeElement">Remove "My Task Test"</button>
			    
<script type="text/javascript" src="${cPath }/resources/dist/jkanban.min.js"></script>         
  
 	<script>
	 // ajax로 칸반 컬럼들 먼저 받아오기
	 let boards;
	 $.ajax({
			url : getContextPath() + '/restapi/project/kanban-columns',
			type : 'get',
			success : function(res) {
				boards = res;
				
				// 받아온 컬럼들의 데이터를 칸반 API 형식에 맞게 변환시킨다.
				for(i in boards){
					boards[i].id = boards[i].kb_col_no;
					boards[i].title = boards[i].kb_col_nm;
					boards[i].item = boards[i].cardList;
					
					for(j in boards[i].item){
						boards[i].item[j].id = boards[i].item[j].kb_card_no;
						boards[i].item[j].title = boards[i].item[j].kb_card_cont;
					}
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
        element: "#myKanban",
        // 칸반 컬럼간의 간격
        gutter: "10px",
        // 칸반 컬럼들의 가로 길이
        widthBoard: "350px",
        // 컬럼 크기 상대적으로 지정하려면 true. 이 경우에는 gutter와 widthBoard가 필요 없음.
        responsivePercentage : false,
        // 모든 아이템들을 드래그 가능하도록 할지
//         dragItems  : true,  
//         itemHandleOptions:{
//           enabled: true,
//         },
//         click: function(el) {
//           console.log("Trigger on all items click!");
//         },
//         context: function(el, e) {
//           console.log("Trigger on all items right-click!");
//         },
//         dropEl: function(el, target, source, sibling){
//           console.log(target.parentElement.getAttribute('data-id'));
//           console.log(el, target, source, sibling)
//         },
//         buttonClick: function(el, boardId) {
//           console.log(el);
//           console.log(boardId);
//           // create a form to enter element
//           var formItem = document.createElement("form");
//           formItem.setAttribute("class", "itemform");
//           formItem.innerHTML =
//             '<div class="form-group"><textarea class="form-control" rows="2" autofocus></textarea></div><div class="form-group"><button type="submit" class="btn btn-primary btn-xs pull-right">Submit</button><button type="button" id="CancelBtn" class="btn btn-default btn-xs pull-right">Cancel</button></div>';

//           KanbanTest.addForm(boardId, formItem);
//           formItem.addEventListener("submit", function(e) {
//             e.preventDefault();
//             var text = e.target[0].value;
//             KanbanTest.addElement(boardId, {
//               title: text
//             });
//             formItem.parentNode.removeChild(formItem);
//           });
//           document.getElementById("CancelBtn").onclick = function() {
//             formItem.parentNode.removeChild(formItem);
//           };
//         },
//         itemAddOptions: {
//           enabled: true,
//           content: '+ 카드 추가',
//           class: 'custom-button',
//           footer: true
//         },
        	boards: boards
//         boards: [
//           {
//             id: "_todo",
//             title: "To Do (Can drop item only in working)",
//             class: "info,good",
//             dragTo: ["_working"],
//             item: [
//               {
//                 id: "_test_delete",
//                 title: "Try drag this (Look the console)",
//                 drag: function(el, source) {
//                   console.log("START DRAG: " + el.dataset.eid);
//                 },
//                 dragend: function(el) {
//                   console.log("END DRAG: " + el.dataset.eid);
//                 },
//                 drop: function(el) {
//                   console.log("DROPPED: " + el.dataset.eid);
//                 }
//               },
//               {
//                 title: "Try Click This!",
//                 click: function(el) {
//                   alert("click");
//                 },
//                 context: function(el, e){
//                   alert("right-click at (" + `${e.pageX}` + "," + `${e.pageX}` + ")")
//                 },
//                 class: ["peppe", "bello"]
//               }
//             ]
//           },
//           {
//             id: "_working",
//             title: "Working (Try drag me too)",
//             class: "warning",
//             item: [
//               {
//                 title: "Do Something!"
//               },
//               {
//                 title: "Run?"
//               }
//             ]
//           },
//           {
//             id: "_done",
//             title: "Done (Can drop item only in working)",
//             class: "success",
//             dragTo: ["_working"],
//             item: [
//               {
//                 title: "All right"
//               },
//               {
//                 title: "Ok!"
//               }
//             ]
//           }
//         ]
      });

//       var addBoardDefault = document.getElementById("addDefault");
//       addBoardDefault.addEventListener("click", function() {
//         KanbanTest.addBoards([
//           {
//             id: "_default",
//             title: "Kanban Default",
//           }
//         ]);
//       });

//       var removeBoard = document.getElementById("removeBoard");
//       removeBoard.addEventListener("click", function() {
//         KanbanTest.removeBoard("_done");
//       });

//       var removeElement = document.getElementById("removeElement");
//       removeElement.addEventListener("click", function() {
//         KanbanTest.removeElement("_test_delete");
//       });

//       var allEle = KanbanTest.getBoardElements("_todo");
//       allEle.forEach(function(item, index) {
//         //console.log(item);
//       });
    </script>
    
             
             
             
             
             