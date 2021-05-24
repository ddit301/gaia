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
     
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
				<h4>Kanban Board</h4>
				조회중인 프로젝트 생성자 : ${manager_nick }<br/>
				조회중인 프로젝트 타이틀 : ${project_title }
            </div>
            <!-- #/ container -->
            
            <div class="kanbanCard">
			  <p>카드입니다</p>
			</div>
			
<script>
/*
 * 마우스 드래그에 대한 함수입니다.
 */
let cards = document.getElementsByClassName("kanbanCard");
for(var i in cards){
	dragElement(cards[i]);
}

function dragElement(elmnt) {
  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
    elmnt.onmousedown = dragMouseDown;

  function dragMouseDown(e) {
    e = e || window.event;	// Internet Explorer에는 e가 없고 window.event를 사용
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
  }

  function closeDragElement() {
    /* stop moving when mouse button is released:*/
    document.onmouseup = null;
    document.onmousemove = null;
    alert(elmnt.style.top + "," + elmnt.style.left)
  }
}
</script>
