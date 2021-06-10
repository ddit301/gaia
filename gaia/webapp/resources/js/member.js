// 페이지 열릴때 멤버 관련된 url 이란 판단이 되면, memberMovePageHistory 발동.
$(function(){
	if(memberPageParam){
		memberMovePage(memberPageParam);
	}
})

var memberMovePageHistory = function(pageParam){
	var url = getContextPath() +'/'+mem_id+'/' +pageParam;
	history.pushState('member-'+pageParam, null, url);
	memberMovePage(pageParam);
}

var memberMovePage = function(pageParam){
		let path = getContextPath()+"/view/member/";
		let index;
		// member 페이지에서는 horizontal로만 보여줍니다.
		new quixSettings({
		    layout: "horizontal" // vertical or horizontal
		});
		// sideBar와 햄버거 메뉴를 숨깁니다 - project에 종속되기 떄문.
		$('.nk-sidebar').prop('hidden','true');
		$('.nav-control').prop('hidden','true');
		
		if(!pageParam){
			pageParam = 'overview';	
		}
		// setting으로 요청이 들어오면 profile로 변경시키기.(setting/profile -> setting으로만 표시 )
		if(pageParam=="setting"){
			pageParam = 'profile';	
		}
		// profile.jsp에서 'setting/account'로 pageParam을 넘김.
		if(pageParam.includes("/"))
			index = pageParam.indexOf("/");
			pageParam = pageParam.slice(index+1);
		
		$.ajax({
			url : path+pageParam ,
			type : 'get',
			data : {'mem_id' : mem_id
				},
			success : function(res) {
				$('.content-body').html(res);
			},
			error : function(xhr) {
				// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
				if(xhr.status == '404'){
					alert('등록되지 않는 버튼 : ' + pageParam);				
				}else{
					alert("status : " + xhr.status);
				}
			},
			dataType : 'html'
		})
	}