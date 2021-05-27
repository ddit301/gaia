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
			    <button id="addToDo">Add element in "To Do" Board</button>
			    <br />
			    <button id="removeBoard">Remove "Done" Board</button>
			    <br />
			    <button id="removeElement">Remove "My Task Test"</button>
			    
<script type="text/javascript" src="${cPath }/resources/dist/jkanban.min.js"></script>         
  
 <script>
      var KanbanTest = new jKanban({
        element: "#myKanban",
        gutter: "10px",
        widthBoard: "450px",
        itemHandleOptions:{
          enabled: true,
        },
        click: function(el) {
          console.log("Trigger on all items click!");
        },
        context: function(el, e) {
          console.log("Trigger on all items right-click!");
        },
        dropEl: function(el, target, source, sibling){
          console.log(target.parentElement.getAttribute('data-id'));
          console.log(el, target, source, sibling)
        },
        buttonClick: function(el, boardId) {
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
        },
        itemAddOptions: {
          enabled: true,
          content: '+ Add New Card',
          class: 'custom-button',
          footer: true
        },
        boards: [
          {
            id: "_todo",
            title: "To Do (Can drop item only in working)",
            class: "info,good",
            dragTo: ["_working"],
            item: [
              {
                id: "_test_delete",
                title: "Try drag this (Look the console)",
                drag: function(el, source) {
                  console.log("START DRAG: " + el.dataset.eid);
                },
                dragend: function(el) {
                  console.log("END DRAG: " + el.dataset.eid);
                },
                drop: function(el) {
                  console.log("DROPPED: " + el.dataset.eid);
                }
              },
              {
                title: "Try Click This!",
                click: function(el) {
                  alert("click");
                },
                context: function(el, e){
                  alert("right-click at (" + `${e.pageX}` + "," + `${e.pageX}` + ")")
                },
                class: ["peppe", "bello"]
              }
            ]
          },
          {
            id: "_working",
            title: "Working (Try drag me too)",
            class: "warning",
            item: [
              {
                title: "Do Something!"
              },
              {
                title: "Run?"
              }
            ]
          },
          {
            id: "_done",
            title: "Done (Can drop item only in working)",
            class: "success",
            dragTo: ["_working"],
            item: [
              {
                title: "All right"
              },
              {
                title: "Ok!"
              }
            ]
          }
        ]
      });

      var toDoButton = document.getElementById("addToDo");
      toDoButton.addEventListener("click", function() {
        KanbanTest.addElement("_todo", {
          title: "Test Add"
        });
      });

      var addBoardDefault = document.getElementById("addDefault");
      addBoardDefault.addEventListener("click", function() {
        KanbanTest.addBoards([
          {
            id: "_default",
            title: "Kanban Default",
            item: [
              {
                title: "Default Item"
              },
              {
                title: "Default Item 2"
              },
              {
                title: "Default Item 3"
              }
            ]
          }
        ]);
      });

      var removeBoard = document.getElementById("removeBoard");
      removeBoard.addEventListener("click", function() {
        KanbanTest.removeBoard("_done");
      });

      var removeElement = document.getElementById("removeElement");
      removeElement.addEventListener("click", function() {
        KanbanTest.removeElement("_test_delete");
      });

      var allEle = KanbanTest.getBoardElements("_todo");
      allEle.forEach(function(item, index) {
        //console.log(item);
      });
    </script>