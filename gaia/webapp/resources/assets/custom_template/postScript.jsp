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
   	<script type="text/javascript">
   	
		// 뒤로가기 이벤트 binding 하기
		$(window).bind("popstate", function(event) {
		    var data = event.originalEvent.state;
		    if(data){ // 이전 페이지 데이터가 있으면 ajax로 다시 요청해 화면 렌더링.
		    	movePage(data);
		    }else{ // 히스토리에 정보가 없을경우 메인화면으로 이동시키기.
		    	var url = "${cPath}";
		    	$(location).attr('href',url);
		    }
	 	})
	 	
	 	var issueView = function(issue_no){
			let project_title = '${project_title}';
			let manager_nick = '${manager_nick}';
			
			data = 'issueview';
			title = '';
			url = '${cPath}/${manager_nick}/${project_title}/issue/'+issue_no;
			history.pushState(data, title, url);
			
			$.ajax({
				url : '${cPath}/view/project/issueview'
				,type : 'get'
				,data : {
					'manager_nick' : manager_nick
					,'project_title' : project_title
					,'issue_no' : issue_no
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
			issueView(issue_no);
		}else{
			movePageHistory(pageParam);
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
							
			// 특정 이슈 클릭시 불러오는 메서드
			$('#main-wrapper').on('click', '.issueButton', function(){
				event.preventDefault();
				let issue_no = $(this).parents('.issueBox').data('issue_no');
				issueView(issue_no);
			})
		
		})
		/********************************************************************
	 	*
 		*	END OF 'When document is ready '
 		*	
 		*********************************************************************/
	</script>
    

