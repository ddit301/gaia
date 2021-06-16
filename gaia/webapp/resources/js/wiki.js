/////////////////////////////////////////////////////
//
//	wiki 페이지 버튼 이벤트를 위한 바인딩
//
//////////////////////////////////////////////////////
$(function(){
	
	let wiki = null;
	
	// wiki 등록을 위한 버튼 이벤트
	$('.content-body').on('click','.new-wiki', function(){
			alert("1 new wiki");
	$('.modal-title').text('wiki 추가');
	$('#saveWikiBtn').text('save');
	$('#wiki-title-input').val('');
		
		// newhandler 생성 모달 반복 삭제
		let newHandler = function(){
			newWiki();
			$(document).off("shown.bs.modal",'#wikiModal',newHandler)
				}
			$(document).on("shown.bs.modal",'#wikiModal',newHandler)
				})
	
	// 특정 위키 클릭시 불러오는 메서드
	$('.content-body').on('click','.wiki-btn',function(){
		//특정 위키의 wiki_no 불러옴.
		let wiki_no = $(this).siblings('input').val();
		wikiView(wiki_no);
	
	})
	
	// 모달창에서 위키 삭제 버튼 클릭 시 
	$('.content-body').on('click','#delete-wiki-btn',function(){
		let wiki_sid  = $(this).siblings('input').val();
		delWiki(wiki_sid);
	})
	
	// 위키 수정 버튼 클릭 시
	$('.content-body').on('click','.edit-wiki',function(){
		alert("2 edit wiki");
		
		// new wiki 와 모달을 같이 쓰기 때문에 save 를 edit 으로 변경한다.
		$('.modal-title').text('wiki 수정');
		$('#saveWikiBtn').text('edit');
			
		//	editHandler 생성 모달 반복 삭제
		let editHandler = function(){
			editWiki();
			$(document).off("shown.bs.modal",'#wikiModal',editHandler)
				}
			$(document).on("shown.bs.modal",'#wikiModal',editHandler)
				});
		
	// wiki title 검색 버튼 클릭 시 
	$('.content-body').on('click','.wiki-search-btn',function(){
		let wiki_title = $('input.wikisearchtitle').val();
		wikilist(wiki_title);
		
	})
	
	
})


	// 특정 위키 수정하는 함수 
	// 수정이긴하지만 계층형 이기 때문에 insert 를 시킬 예정 
const editWiki = function(){
		alert("3 edit function")
		let wiki_title = wiki.wiki_title;
		let wiki_cont = wiki.wiki_cont;

		parent_wiki = wiki.wiki_sid;

		// wiki_title 에 기존 값 넣기 	
		$('#wiki-title-input').val(wiki_title);
		// editor 에 cont 넣기
		editor.setMarkdown(wiki_cont);
		
	$('#saveWikiBtn').on('click', function(){	
		// 위키 insert => edit 하기
		
		// 수정된 입력값 wiki_title 에 넣기
		wiki_title = $('#wiki-title-input').val();
		wiki_cont = editor.getMarkdown();
		// 수정된 content wiki_cont 에 넣기
		
				$.ajax({
					url : getContextPath()+'/restapi/project/wikis',
					method : 'post',
					data : {
						'wiki_title' : wiki_title
						,'wiki_cont' : wiki_cont
						,'parent_wiki' : parent_wiki
					},
					success : function(res) {
						
						$('.modal-backdrop').removeClass('show').css("display","none");
						// toastr 알람
						toastr.success('새로운 위키 수정에 성공했습니다.')
						movePageHistory("wiki");
						
						// 에디터 비우기
						$('#wiki-title-input').val('');
						editor.reset();
						// 모달 닫기
						$('#wikiModal').modal('hide');
						
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg);
					},
					dataType : 'json'
				})
		
			});
		
			$('.content-body').on('click','#closeWikiBtn',function(){
//				alert("close")
				// 에디터 비우기
				wiki_title = null;
				wiki_cont = null;
				$('#wiki-title-input').val('');
					editor.reset();
					
				// 모달 닫기
				$('#wikiModal').modal('hide');
			})
}


	// 특정 위키 삭제하는 함수
const delWiki = function(wiki_sid){
		$.ajax ({
			url : getContextPath() + '/restapi/project/wikis'
			, type : 'post'
			, data : {
				'_method' : "delete"
				, 'wiki_sid' : wiki_sid	
			},
			success : function(res) {
				$('.modal-backdrop').removeClass('show').css("display","none");
				swal.success();
				movePageHistory("wiki");
			},
			error : function(xhr, error ,msg) {
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
			, async : false
			
		})
	
}	


	// 특정 위키 불러오는 함수
const wikiView = function(wiki_no){
		window.scrollTo({top:0, left:0, behavior:'auto'});
		data = 'wikiView'+wiki_no;
		title = '';
		url = getContextPath()+'/'+manager_id+'/'+project_title+'/wiki/'+wiki_no;
		history.pushState(data,title,url);
		
		$.ajax({
			url : getContextPath() + '/restapi/project/wikis/'+ wiki_no
			, type : 'get'
			, data : {
				
			},
			success : function(res) {
				
				wiki = res;
				
				console.log(res);

				$('.title-wiki').children('span').text(res.wiki_title);
				$('.wiki-writer').children('span').eq(0).text(res.proj_user_nick);
				if(res.parent_wiki == null){
					$('.wiki-writer').children('span').eq(1).text('open');
				}else{
					$('.wiki-writer').children('span').eq(1).text('edit');
				}
					$('.wiki-writer').children('span').eq(2).text('this page');
				
				$('.wiki-writer').children('span').eq(3).text(moment(res.wiki_write_date).fromNow());
				// 마크다운 뷰어
				viewer.setMarkdown(res.wiki_cont);
				// delete modal 의 wiki-title 에 이름 넣기
				$('.wiki-title-modal').children('span').text(res.wiki_title);
				
				// delete modaal 의 delete 버튼에 wiki_sid 넣기
				$('.modal-footer').children('input').val(res.wiki_sid);
				
				
			},
			error : function(xhr, error, msg) {
				// 조회중인 프로젝트 번호를 세션에서 못 받아 올 경우, 메인 홈페이지로 보낸다.
				if(xhr.status == 400){
					window.location.href = getContextPath();
				}
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
			,async : false
		})
		
	}
	
	
const wikilist = function(wiki_title){

	  var scopeWikiNo = '${wiki_no}';
            // project 내 첫번째 wiki 출력 
            	$.ajax({
            		url : getContextPath() + '/restapi/project/wikis/'
					,type : 'get'
					, data : {
						'wiki_title' : wiki_title
					},
					success : function(res) {
						if(!!scopeWikiNo){
							$.each(res.dataList, function(i,v){
								if(v.wiki_no == '${wiki_no}'){
									$('.title-wiki').children('span').text(v.wiki_title);
									
									
								}
							})
						}else{ // requestScope에 wiki_no가 존재하지 않을 시 가장 처음 작성된 kiki를 불러옴.
						
						}	
							
							wiki = res.dataList[0];
							if(wiki == null){
								$('.title-wiki').children('span').text('등록된 위키가 없습니다');
								$('.wiki-writer').children('span').eq(0).text('');
								$('.wiki-writer').children('span').eq(1).text('');
								$('.wiki-writer').children('span').eq(2).text('');
								$('.wiki-writer').children('span').eq(3).text('');
								viewer.setMarkdown(' ');
								$('#wiki-list').empty();
								// wiki 없는경우 delete/edit disabled 시키
								$('.delete-wiki').prop('disabled',true);
								$('.edit-wiki').prop('disabled',true);
							}
							else{
							
							$('.title-wiki').children('span').text(wiki.wiki_title);
							$('.wiki-writer').children('span').eq(0).text(wiki.proj_user_nick);
							if(wiki.parent_wiki == null){
								$('.wiki-writer').children('span').eq(1).text('open');
							}else{
								$('.wiki-writer').children('span').eq(1).text('edit');
							}
							$('.wiki-writer').children('span').eq(2).text('this wiki');
							$('.wiki-writer').children('span').eq(3).text(moment(wiki.wiki_write_date).fromNow());
//							$('.wiki-content').children('span').text(res.dataList[0].wiki_cont);
							viewer.setMarkdown(wiki.wiki_cont);
							// delete modal 의 wiki-title 에 이름 넣기
							$('.wiki-title-modal').children('span').text(wiki.wiki_title);
							
							// delete modaal 의 delete 버튼에 wiki_sid 넣기
							$('.modal-footer').children('input').val(wiki.wiki_sid);
							
							$('#wiki-list').empty();
							
							$.each(res.dataList, function(i,v){
								
								let wikiBox = $('#wiki-template').children('.wikiBox').clone();
								wikiBox.attr('data-wiki_no',v.wiki_no);
								wikiBox.find('.wiki-title').children('a').text(v.wiki_title);
								wikiBox.find('.wiki-title').children('input').val(v.wiki_no);
								
								
								$('#wiki-list').append(wikiBox);
							})
							}
					},
					error : function(xhr, error, msg) {
						// 조회중인 프로젝트 번호를 세션에서 못 받아 올 경우, 메인 홈페이지로 보낸다.
						if(xhr.status == 400){
							window.location.href = getContextPath();
						}
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'

				})
	
}

// 위키 생성 하는 함수
const newWiki = function() {
	$('#saveWikiBtn').on('click', function(){
		alert("click save btn")
				wiki_title = $('#wiki-title-input').val();
				wiki_cont = editor.getMarkdown();
				// 위키 insert 하기
				$.ajax({
					url : getContextPath()+'/restapi/project/wikis',
					method : 'post',
					data : {
						'wiki_title' : wiki_title
						,'wiki_cont' : wiki_cont
						
					},
					success : function(res) {
						
				$('.modal-backdrop').removeClass('show').css("display","none");
						// toastr 알람
						toastr.success('새로운 위키 등록에 성공했습니다.')
						movePageHistory("wiki");
						
						
						// 에디터 비우기
						$('#wiki-title-input').val('');
						editor.reset();
						// 모달 닫기
						$('#wikiModal').modal('hide');
						
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg);
					},
					dataType : 'json'
				})
				
			})
	
}
	
