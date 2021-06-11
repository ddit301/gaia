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
							card.issue_no = issue.issue_no;
							card.class = ['issueCard', 'card'];
							cardCont.find('.issue_title a').attr('href','issue/'+issue.issue_no);
							cardCont.find('.issue_title a').attr('issue_no',issue.issue_no);
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
							card.class = ['normalCard', 'card'];
						}
						card.title = cardCont.wrap("<div/>").parent().html();
						column.item.push(card);
					}
					boards.push(column);
				}
			},
			error : function(xhr, error, msg) {
				ajaxError(xhr, error, msg);
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
          console.log(el);
        }
      	// 카드 우클릭 이벤트
        ,context: function(el, e) {
          rightClickedCard = el;
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
					toastr.success('카드 이동에 성공했습니다.')
					
					if(res.result != 'OK'){
						alert('kanban Card 이동에 실패했습니다. 상황을 Shane 에게 알려주세요.');
					}
				}
				,error : function(xhr, error, msg) {
					ajaxError(xhr, error, msg)
				},
				dataType : 'json',
				// async false 이면 카드 드랍시에 딜레이가 발생합니다만 안정성이 보장됩니다.
				// async true 로 해 둘 경우에는 카드 이동시 렉은 발생하지 않지만 렉이 걸리면 꼬일 수가 있습니다.
				// 일단 async true로 해두고, 지켜보고 카드 순서가 꼬이는 문제가 발생하면 async를 다시 false로 바꾸겠습니다.
				// 여러명의 유저가 하나의 칸반을 같이 사용할때의 경우도 고려를 해야 합니다 - web socket 사용
				async : true
			})
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
		              ,class : ['normalCard', 'card']
		            });
				},
				error : function(xhr, error, msg) {
					ajaxError(xhr, error, msg)
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
 
 	/********************************************************************
 	*
	*	When document is ready
	*		문서가 준비되고 나서 호출되어야 하는 함수들은 아래 기재합니다.
	*	
	*********************************************************************/	 
	$(function(){
		let rightClickedCard = null;		
		
		// contextMenu (우클릭)에 대한 설정 - 일반 카드 : 수정 삭제 모두 가능
	    $.contextMenu({
	        selector: '.normalCard', 
	        items: {
	            editCard: {
	                name: "카드 수정",
	                callback: function(key, opt){
	                   	editCard();
	                }
	            },deleteCard: {
	                name: "카드 삭제",
	                callback: function(key, opt){
	                	delCard();
	                }
	            }
	        }, 
	        events: {
	            show: function(opt) {
	                // this is the trigger element
	                var $this = this;
	                // import states from data store 
	                $.contextMenu.setInputValues(opt, $this.data());
	                // this basically fills the input commands from an object
	                // like {name: "foo", yesno: true, radio: "3", &hellip;}
	            }, 
	            hide: function(opt) {
	                // this is the trigger element
	                var $this = this;
	                // export states to data store
	                $.contextMenu.getInputValues(opt, $this.data());
	                // this basically dumps the input commands' values to an object
	                // like {name: "foo", yesno: true, radio: "3", &hellip;}
	            }
	        }
	    });
		// contextMenu (우클릭)에 대한 설정 - 이슈 카드 : 수정은 안되고 삭제만 된다.
	    $.contextMenu({
	        selector: '.issueCard', 
	        items: {
	            issueView: {
	                name: "이슈 보기",
	                callback: function(key, opt){
	                	jumpToIssue();
	                }
	            },
	            deleteCard: {
	                name: "카드 삭제",
	                callback: function(key, opt){
	                	delCard();
	                }
	            }
	        }, 
	        events: {
	            show: function(opt) {
	                var $this = this;
	                $.contextMenu.setInputValues(opt, $this.data());
	            }, 
	            hide: function(opt) {
	                var $this = this;
	                $.contextMenu.getInputValues(opt, $this.data());
	            }
	        }
	    });
		
		
	});	 
	 
// sweetAlert 버튼 초기화
 swalWithBootstrapButtons = Swal.mixin({
	  customClass: {
		cancelButton: 'btn btn-light',
	   	confirmButton: 'btn btn-danger'
	  },
	  buttonsStyling: false
	})	 

// 카드 이슈로 이동하는 funciton
jumpToIssue = function(){
	issueView(rightClickedCard.dataset.issue_no);
}
	
// 카드 삭제하는 Function 입니다.
delCard = function(){
	swalWithBootstrapButtons.fire({
		  title: '정말 카드를 삭제하시겠습니까?',
		  text: "삭제시 되돌릴 수 없습니다!",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonText: '삭제',
		  cancelButtonText: '취소',
		  reverseButtons: true
		}).then((result) => {
		  if (result.isConfirmed) {
		    swalWithBootstrapButtons.fire(
		      'Deleted!',
		      '카드를 삭제했습니다.',
		      'success'
		    )
		    let kb_card_no = rightClickedCard.dataset.eid.substring(1);
		    
		    $.ajax({
				url : getContextPath() + '/restapi/project/kanban-cards',
				method : 'post',
				data : {
					'kb_card_no' : kb_card_no
					,'_method' : 'delete'
				},
				success : function(res) {
					if(res.result == "OK"){
						rightClickedCard.remove();
					}else{
						alert('삭제에 실패했습니다. 지속해서 문제 발생시 관리자에게 문의해주세요.');				
					}
				},
				error : function(xhr, error, msg) {
					ajaxError(xhr, error, msg)
				},
				dataType : 'json'
			})
		    
		  } else if (
		    /* Read more about handling dismissals below */
		    result.dismiss === Swal.DismissReason.cancel
		  ) {
		  }
		})

}

// 카드 수정하는 Function 입니다. jquery ajax 대신 Vanilla JS Fetch API를 사용했습니다. 
editCard = function(){
	let kb_card_no = rightClickedCard.dataset.eid.substring(1);
	let kb_card_cont = rightClickedCard.getElementsByClassName('card_content')[0].innerText;
	
	Swal.fire({
		  title: '칸반 카드 수정',
		  input: 'textarea',
		  inputValue : kb_card_cont,
		  inputPlaceholder : '카드 내용을 입력해주세요.',
		  inputValidator : (value) => {
			  if(!value || value.trim() === ''){
				  return '내용을 입력해주세요.'
			  }
		  },
		  showCancelButton: true,
		  confirmButtonText: 'Save',
		  showLoaderOnConfirm: true,
		  preConfirm: (newCont) => {
			  kb_card_cont = newCont;
			  // formData 로 만들어서 ajax 전송 한다. _method로 put 요청을 보낸다.
				let formData = new FormData();
				formData.append('kb_card_no',kb_card_no);
				formData.append('_method','put');
			    formData.append('kb_card_cont',kb_card_cont);
		        return fetch(getContextPath() + '/restapi/project/kanban-cards',{
			    	method : 'post'
			    	,body : formData
		    })
		      .then(response => {
		        if (!response.ok) {
		          throw new Error(response.statusText)
		        }
		        return response.json()
		      })
		      .catch(error => {
		        Swal.showValidationMessage(
		          `Request failed: ${error}`
		        )
		      })
		  },
		  allowOutsideClick: () => !Swal.isLoading()
		}).then((result) => {
		  if (result.isConfirmed) {
			  // 새로 수정한 카드 내용으로 기존 카드 내용 변경하기
			  rightClickedCard.getElementsByClassName('card_content')[0].innerText = kb_card_cont;
		    swal.success();
		  }
		})
}
	 
</script>
    
             
             
             
             
             