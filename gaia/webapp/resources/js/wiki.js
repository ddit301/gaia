/////////////////////////////////////////////////////
//
//	wiki 페이지 버튼 이벤트를 위한 바인
//
//////////////////////////////////////////////////////
$(function(){
	
	// wiki 등록을 위한 버튼 이벤트
	$('.content-body').on('click','.new-wiki', function(){
		alert("test");
		
	})
	
	// 특정 위키 클릭시 불러오는 메서드
	$('.content-body').on('click','.wiki-btn',function(){
		
		//특정 위키의 wiki_no 불러오
		let wiki_no = $(this).siblings('input').val();
		wikiView(wiki_no);
		
	})
	
})

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
			
				$('.title-wiki').children('span').text(res.wiki_title);
				$('.wiki-writer').children('span:first').text(res.proj_user_nick);
				$('.wiki-writer').children('span:last').text(moment(res.wiki_write_date).fromNow());
				$('.wiki-content').children('span').text(res.wiki_cont);
				
				$.each(res, function(i, v) {
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
	
