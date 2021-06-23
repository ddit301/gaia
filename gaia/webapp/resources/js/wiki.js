/////////////////////////////////////////////////////
//
//	wiki 페이지 버튼 이벤트를 위한 바인딩
//
//////////////////////////////////////////////////////
$(function(){
	
	// wiki history 에서 버튼을 클릭한 경우
	$('.content-body').on('click','.wiki-his-btn',function(){
		let wiki_no = $(this).siblings('input').val();
		wikiView(wiki_no);
		$('.wiki-history-title').children('span').eq(1).text(' ');
		$('.wiki-writer').children('a').text(' ');
	})
	
	
	// wiki 등록을 위한 버튼 이벤트
	$('.content-body').on('click','.new-wiki', function(){
		
		$('.modal-title').text('wiki 추가');
		$('#saveWikiBtn').text('save');
		$('#wiki-title-input').val('');
		
		// newhandler 생성 모달 반복 삭제
		let newHandler = function(){
			$(document).off("shown.bs.modal",'#wikiModal',newHandler)
		}
		$(document).on("shown.bs.modal",'#wikiModal',newHandler)
	})
	
	// 특정 위키 클릭시 불러오는 메서드
	$('.content-body').on('click','.wiki-btn',function(){
		//특정 위키의 wiki_no 불러옴.
		$('#wiki-history').empty();
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
		
		let wiki_title = wiki.wiki_title;
		let wiki_cont = wiki.wiki_cont;
		parent_wiki = wiki.wiki_sid;
	
		// wiki_title 에 기존 값 넣기 	
		$('#wiki-title-input').val(wiki_title);
		// editor 에 cont 넣기
		editor.setMarkdown(wiki_cont);
		
		// new wiki 와 모달을 같이 쓰기 때문에 save 를 edit 으로 변경한다.
		$('.modal-title').text('wiki 수정');
		$('#saveWikiBtn').text('edit');
			
		//	editHandler 생성 모달 반복 삭제
		let editHandler = function(){
			$(document).off("shown.bs.modal",'#wikiModal',editHandler);
		}
		$(document).on("shown.bs.modal",'#wikiModal',editHandler);
	});
		
	// wiki title 검색 버튼 클릭 시 
	$('.content-body').on('click','.wiki-search-btn',function(){
		let wiki_title = $('input.wikisearchtitle').val();
		wikilist(wiki_title);
		
	})
	// wiki history 버튼 클릭 
	$('.content-body').on('click','.wikiHis',function(){
			let wiki_sid = $(this).siblings('input').val();
			event.preventDefault();
			wikihistory(wiki_sid);
			
	});		
	
	// 위키 저장 버튼 바인딩
	$('.content-body').on('click', '#saveWikiBtn', function(){
		
		let isEdit = $('#saveWikiBtn').text() == 'edit';
		
		if(isEdit){
			editWiki();
		}else{
			newWiki();
		}
		
	});
	
	// close 버튼 누르면 에디터 비우도록.
	$('.content-body').on('click','#closeWikiBtn',function(){
		// 에디터 비우기
		wiki_title = null;
		wiki_cont = null;
		$('#wiki-title-input').val('');
			editor.reset();
			
		// 모달 닫기
		$('#wikiModal').modal('hide');
	})
	
	
})


	// 특정 위키 수정하는 함수 
	// 수정이긴하지만 계층형 이기 때문에 insert 를 시킬 예정 
const editWiki = function(){
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
			toastr.success('위키 수정에 성공했습니다.')
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
//				$('.modal-backdrop').modal('show');
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
		
		$.ajax({
			url : getContextPath() + '/restapi/project/wikis/'+ wiki_no
			, type : 'get'
			,success : function(res) {
				
				wiki = res;

				$('.title-wiki').children('span').text(res.wiki_title);
				$('.wiki-writer').children('span').eq(0).text(res.proj_user_nick);
				if(res.parent_wiki == null){
					$('.wiki-writer').children('span').eq(1).text('open');
					$('.wiki-writer').children('a').text('');
					$('.wiki-history-title').children('span').eq(1).text('(히스토리가 없습니다.)');
				}else{
					$('.wiki-writer').children('span').eq(1).text('edit');
					$('.wiki-writer').children('a').text(' history');
					$('.wiki-writer').children('.wiki-his-link-no').val(res.wiki_sid);
					$('.wiki-history-title').children('span').eq(1).text('');
				}
				
				$('.wiki-writer').children('span').eq(2).text('this wiki');
				$('.wiki-writer').children('span').eq(3).text(moment(res.wiki_write_date).fromNow()+'. ');
				// 마크다운 뷰어
				viewer.setMarkdown(res.wiki_cont);
				// delete modal 의 wiki-title 에 이름 넣기
				$('.wiki-title-modal').children('span').text(res.wiki_title);
				
				// delete modaal 의 delete 버튼에 wiki_sid 넣기
				$('.modal-footer').children('input').val(res.wiki_sid);
				
				
			},
			error : function(xhr, error, msg) {
		
				console.log(xhr);
				console.log(error);
				console.log(msg);
			},
			dataType : 'json'
			,async : false
		})
		
	}
	
	
const wikilist = function(wiki_title){
            // project 내 첫번째 wiki 출력 
            	$.ajax({
            		url : getContextPath() + '/restapi/project/wikis/'
					,type : 'get'
					, data : {
						'wiki_title' : wiki_title
					},
					success : function(res) {
							$.each(res.dataList, function(i,v){
									$('.title-wiki').children('span').text(v.wiki_title);
							})
							wiki = res.dataList[0];
							if(wiki == null){
								$('.title-wiki').children('span').text('등록된 위키가 없습니다.');
								$('.wiki-writer').children('span').eq(0).text('등록된 위키가 없습니다.');
								$('.wiki-writer').children('span').eq(1).text('');
								$('.wiki-writer').children('span').eq(2).text('');
								$('.wiki-writer').children('span').eq(3).text('');
								$('.wiki-writer').children('a').text(' ');
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
								$('.wiki-writer').children('a').text('');
								$('.wiki-history-title').children('span').eq(1).text('(히스토리가 없습니다.)');
							}else{
								$('.wiki-writer').children('span').eq(1).text('edit');
								$('.wiki-writer').children('a').text(' history');
								$('.wiki-writer').children('.wiki-his-link-no').val(wiki.wiki_sid);
								$('.wiki-history-title').children('span').eq(1).text('');
							}
							$('.wiki-writer').children('span').eq(2).text('this wiki');
							$('.wiki-writer').children('span').eq(3).text(moment(wiki.wiki_write_date).fromNow()+'. ');
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
			
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'

				})
	
}

// 위키 생성 하는 함수
const newWiki = function() {
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
}
	
	// 위키 히스토리 불러오는 함수
	const wikihistory = function(wiki_sid){
		
		$.ajax({
        		url : getContextPath() + '/restapi/project/wikis/history/'+ wiki_sid	
				,type : 'get',
				success : function(res) {
					
					$.each(res, function(i, v) {
					let wikiHisBox = $('#wiki-history-temple').children('.wikiHisBox').clone();
//					wikiHisBox.attr('data-wiki_no',v.wiki_no);
					wikiHisBox.find('.wiki-his-nick').children('span').eq(0).text(v.proj_user_nick);
					if(v.parent_wiki == null){
					wikiHisBox.find('.wiki-his-nick').children('span').eq(1).text(' open this wiki');
					}else{
					wikiHisBox.find('.wiki-his-nick').children('span').eq(1).text(' edit this wiki');
					}
					wikiHisBox.find('.wiki-his-date').children('span').text(v.wiki_write_date);
					wikiHisBox.find('.wiki-his-link').children('input').val(v.wiki_no);
					
					$('#wiki-history').append(wikiHisBox);
					
					
//					$('#wiki-history').empty();
				})
					
				},
				error : function(xhr, error, msg) {
					console.log(xhr);
					console.log(error);
					console.log(msg);
				},
				dataType : 'json'

			})
			
	}
	
	
		
