<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="${cPath }/resources/assets/plugins/common/common.min.js"></script>
    <script src="${cPath }/resources/assets/js/custom.min.js"></script>
    <script src="${cPath }/resources/assets/js/settings.js"></script>
    <script src="${cPath }/resources/assets/js/gleek${empty project_title? '_horizontal' : ''}.js"></script>
    <script src="${cPath }/resources/assets/js/styleSwitcher.js"></script>
	<script src="${cPath }/resources/js/moment.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/js/bootstrap-material-datetimepicker.min.js"></script>
	<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.js"></script>	
	
<script type="text/javascript">
	let project_title = '${project_title}';
	let manager_nick = '${manager_nick}';   	
	
		// 뒤로가기 이벤트 binding 하기
		$(window).bind("popstate", function(event) {
		    var data = event.originalEvent.state;
		    if(data){ // 이전 페이지 데이터가 있으면 ajax로 다시 요청해 화면 렌더링.
		    	if(data.startsWith("issueView")){
		    		let issue_no = data.substring("issueView".length);
		    		issueView(issue_no);
		    	}else if(data == 'newIssue'){
		    		newIssue();
		    	}else{
			    	movePage(data);
		    	}
		    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
		    	var url = "${cPath}";
		    	$(location).attr('href',url);
		    }
	 	})
	 	
	 	var newIssue = function(){
			// 화면 위로 올리기
			window.scrollTo({top:0, left:0, behavior:'smooth'});
			
			data = 'newIssue'
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/issue/new'
			history.pushState(data, title, url);
			
			$.ajax({
				url : '${cPath}/view/project/newissue'
				,type : 'get'
				,success : function(res){
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
	 	var issueView = function(issue_no){
			// 화면 위로 올리기
			window.scrollTo({top:0, left:0, behavior:'smooth'});
			
			data = 'issueView'+issue_no;
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/issue/'+issue_no;
			history.pushState(data, title, url);
			
			$.ajax({
				url : '${cPath}/view/project/issueview'
				,type : 'get'
				,data : {
					'issue_no' : issue_no
					}
				,success : function(res){
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
	 	// 클릭 이벤트가 아닌 url을 직접 입력해서 페이지를 호출했을 경우에는 해당 이벤트를 통해 매칭시켜줍니다.	
		let pageParam = '${pageParam}';
		let issue_no = '${issue_no}';
		if(issue_no){
			if(issue_no == 'new'){
				newIssue();
			}else{
				issueView(issue_no);
			}
		}else{
			movePageHistory(pageParam);
		}
		
		// milestoneView
		var milestoneView = function(milest_no){
			let project_title = '${project_title}';
			let manager_nick = '${manager_nick}';
			
			data = 'milestoneview';
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/milestone/'+milest_no;
			history.pushState(data,title,url);
			
			$.ajax({
				url : '${cPath}/view/project/milestoneview'
				,type : 'get'
				,data : {
					'manager_nick' : manager_nick
					,'project_title' : project_title
					,'milest_no' : milest_no
					}
				,success : function(res) {
					$('.content-body').html(res);
				}
				,error : function(xhr){
					alert('error : ' + xhr.status);
				},
				dataType : 'html'
			})
		}
	 	
	 	/********************************************************************
	 	*
 		*	When document is ready
 		*		문서가 준비되고 나서 호출되어야 하는 함수들은 아래 기재합니다.
 		*	
 		*********************************************************************/
		$(function(){
			
			// 버튼 누르면 movePageHistory를 호출해 해당 버튼에 맞는 페이지로 매칭시켜줍니다.
			$('#main-wrapper').on('click', '.moveButton', function(){
				event.preventDefault();
				let menuName = $(this).data('menu');
				movePageHistory(menuName);
			})
							
			// 이슈 등록 버튼 이벤트
			$('#main-wrapper').on('click', '#newIssueBtn', function(){
				event.preventDefault();
				newIssue();
			})
			
			// 특정 이슈 클릭시 불러오는 메서드
			$('#main-wrapper').on('click', '.issueButton', function(){
				event.preventDefault();
				let issue_no = $(this).parents('.issueBox').data('issue_no');
				issueView(issue_no);
			})
			
			// 특정 마일스톤 클릭시 불러오는 메서드
			$('#main-wrapper').on('click','.milestoneButton',function(){
				event.preventDefault();
				let milest_no = $(this).parents('.milestoneBox').data('milest_no');
				milestoneView(milest_no);
			})
		
		})
		/********************************************************************
	 	*
 		*	END OF 'When document is ready '
 		*	
 		*********************************************************************/
	</script>
    

