/////////////////////////////////////////////////////
//
//	wiki 페이지 버튼 이벤트를 위한 바인딩
//
//////////////////////////////////////////////////////
$(function(){
	
	let wiki = null;
	
	// wiki 등록을 위한 버튼 이벤트
	$('.content-body').on('click','.new-wiki', function(){
	
	
	})
	
	// 특정 위키 클릭시 불러오는 메서드Í
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
		
		// new wiki 와 모달을 같이 쓰기 때문에 save 를 edit 으로 변경한다.
		$('.modal-title').text('wiki 수정');
		$('#saveWikiBtn').text('edit');
		
		editWiki();
	})
	
})
	// 특정 위키 수정하는 함수 
const editWiki = function(){
		
		let wiki_title = wiki.wiki_title;
		$('#wiki-title-input').val(wiki_title);
		
		let wiki_cont = wiki.wiki_cont;
		console.log(wiki_cont);
		
		// editor 에 cont 넣기
		// 값은 넘어가는데 클릭을 해야 표시가 된다. 문제가 있다. 해결해야함.
		
		editor.setMarkdown(wiki_cont);
		
		$('.CodeMirror-line').click();
		$('.CodeMirror-line').focus();
		editor.focus();		
		setTimeout(() => $('.CodeMirror-line').click(), 500);
		setTimeout(() => $('.CodeMirror-line').click(), 500);
		setTimeout(() => $('.CodeMirror-line').click(), 500);
		
//		$('.te-md-container').text(wiki_cont);
//		viewer.setMarkdown(wiki_cont);
		
		
//		$.ajax({
//		url : getContextPath()+'/view/project/editmilestone'
//		,type : 'get'
//		,data : {
//			'manager_id' : manager_id
//			,'project_title' : project_title
//			,'wiki_no' : wiki_no
//			}
//		,success : function(res) {
//			$('.content-body').html(res);
//		}
//		,error : function(xhr){
//			alert('error : ' + xhr.status);
//		},
//		dataType : 'html'
//	})
	
}

	// 특정 위키 삭제하는 함수
const delWiki = function(wiki_sid){
		alert(wiki_sid)
		$.ajax ({
			url : getContextPath() + '/restapi/project/wikis'
			, type : 'post'
			, data : {
				'_method' : "delete"
				, 'wiki_sid' : wiki_sid	
			},
			success : function(res) {
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
				$('.wiki-writer').children('span').eq(2).text(moment(res.wiki_write_date).fromNow());
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
	
const wikilist = function(){
	  var scopeWikiNo = '${wiki_no}';
            // project 내 첫번째 wiki 출력 
            	$.ajax({
            		url : getContextPath() + '/restapi/project/wikis/'
					,type : 'get'
					, data : {
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
							
							$('.title-wiki').children('span').text(res.dataList[0].wiki_title);
							$('.wiki-writer').children('span').eq(0).text(res.dataList[0].proj_user_nick);
							if(res.dataList[0].parent_wiki == null){
								$('.wiki-writer').children('span').eq(1).text('open');
							}else{
								$('.wiki-writer').children('span').eq(1).text('edit');
							}
							$('.wiki-writer').children('span').eq(2).text(moment(res.dataList[0].wiki_write_date).fromNow());
//							$('.wiki-content').children('span').text(res.dataList[0].wiki_cont);
							viewer.setMarkdown(res.dataList[0].wiki_cont);
							// delete modal 의 wiki-title 에 이름 넣기
							$('.wiki-title-modal').children('span').text(res.dataList[0].wiki_title);
							
							// delete modaal 의 delete 버튼에 wiki_sid 넣기
							$('.modal-footer').children('input').val(res.dataList[0].wiki_sid);
							
							$('#wiki-list').empty();
							
							$.each(res.dataList, function(i,v){
								
								let wikiBox = $('#wiki-template').children('.wikiBox').clone();
								wikiBox.attr('data-wiki_no',v.wiki_no);
								wikiBox.find('.wiki-title').children('a').text(v.wiki_title);
								wikiBox.find('.wiki-title').children('input').val(v.wiki_no);
								
								
								$('#wiki-list').append(wikiBox);
							})
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
	
