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
            
            <div id="myKanban">
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
						card.title = res[i].cardList[j].kb_card_cont;
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
          console.log('변경 한 카드 번호 : '+el.getAttribute('data-eid').substring(1));
          console.log('변경 전 컬럼 번호 : '+source.parentElement.getAttribute('data-id').substring(1));
          console.log('변경 후 컬럼 번호 : '+target.parentElement.getAttribute('data-id').substring(1));
          console.log('변경 후 다음 카드 번호 : '+sibling.getAttribute('data-eid').substring(1));
          console.log(el)
          console.log(target)
          console.log(source)
          console.log(sibling)
        }
        ,buttonClick: function(el, boardId) {
          console.log(el);
          console.log(boardId);
          
          // create a form to enter element
          var formItem = document.createElement("form");
          formItem.setAttribute("class", "itemform");
          formItem.innerHTML =
            '<div class="form-group"><textarea class="form-control" rows="2" autofocus></textarea></div><div class="form-group"><button type="submit" class="btn btn-primary btn-xs pull-right">Submit</button><button type="button" id="CancelBtn" class="btn btn-default btn-xs pull-right">Cancel</button></div>';

          KanbanTest.addForm(boardId, formItem);
          formItem.addEventListener("submit", function(e) {
            e.preventDefault();
            var text = e.target[0].value;
            KanbanTest.addElement(boardId, {
              title: text
            });
            formItem.parentNode.removeChild(formItem);
          });
          document.getElementById("CancelBtn").onclick = function() {
            formItem.parentNode.removeChild(formItem);
          };
        }
//         itemAddOptions: {
//           enabled: true,
//           content: '+ 카드 추가',
//           class: 'custom-button',
//           footer: true
//         }
        	

      });
    </script>
    
             
             
             
             
             