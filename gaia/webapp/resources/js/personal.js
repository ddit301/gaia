

$(function(){
	$('body').on('click', '.projectBox', function(){
		let mngid = $(this).data('manager_id');
		let projtitle = $(this).data('project_title');
		loadProject(mngid,projtitle);
	})
	$('body').on('click', '.mypage', function(){
		location.href= getContextPath() + '/' + mem_id;
	})
});

////////////////////////////////////////////////////
//
// personalPage 이벤
//
////////////////////////////////////////////////////

const printPersonalPage = function(mem_id){
	$.ajax({
		url : getContextPath() + '/restapi/member/members/personalProfile.do',
		method : 'get',
		data : {
			'mem_id' : mem_id
		},
		success : function(res) {
			member = res[0];
			let profileArea = $('.personal-profile');
			profileArea.find('.rounded-circle').attr('src', getProfilePath(member.MEM_PIC_FILE_NAME));
			profileArea.find('.media-body').find('h3').text(member.MEM_ID);
			profileArea.find('.media-body').find('p').eq(0).text(member.MEM_NM);
			profileArea.find('.card-body').find('p').eq(1).text(member.MEM_BIO);
			profileArea.find('.card-profile__info').find('span').eq(0).text(member.MEM_NICK);
			profileArea.find('.card-profile__info').find('span').eq(1).text(member.MEM_WORKING_CITY);
			profileArea.find('.card-profile__info').find('span').eq(2).text(member.MEM_TEL);
			profileArea.find('.card-profile__info').find('span').eq(3).text('할당된 일감 : ' + member.ISSUEASSIGNEECNT);
			profileArea.find('.card-profile__info').find('span').eq(4).text('참여 채팅수 : ' + member.MEMCHATCNT);
			profileArea.find('.card-profile__info').find('span').eq(5).text('작성 이슈 : ' + member.ISSUECNT);
			profileArea.find('.card-profile__info').find('span').eq(6).text('작성 뉴스 : ' + member.NEWSCNT);
			profileArea.find('.card-profile__info').find('span').eq(7).text('작성 마일스톤 : ' + member.MILESTONECNT);
			profileArea.find('.card-profile__info').find('span').eq(8).text('가입일 : ' + moment(member.MEM_SIGN_DATE).format('YYYY-MM-DD'));
			profileArea.find('.card-profile__info').find('span').eq(9).text('상태 : ' + member.MEM_STATUS);
			
			
			/*
			
			위까지 샘플 코드 였습니다. 멤버에 관한건 member. 으로 쓰시면 됩니다. 변수 목록은 아래와 같습니다.
			
			ISSUEASSIGNEECNT: 5 이슈 담당자로 지정된 카운트 입니다.
			ISSUECNT: 115 작성한 이슈 카운트 입니다.
			MEMCHATCNT: 6 참여중인 채팅방 갯수 입니다.
			MEM_BIO: "asd" 멤버 자기소개 입니다.
			MEM_ID: "kkobuk" 멤버 아이디 입니다.
			MEM_NICK: "꼬부기" 멤버 닉네임 입니다.
			MEM_NM: "박세현" 멤버 닉네임 입니다.
			MEM_PIC_FILE_NAME: "4" 멤버 프로필 사진 번호 입니다.
			MEM_SIGN_DATE: 1621436400000 멤버 가입 일 입니다.
			MEM_STATUS: "ON" 멤버 상태 입니다.
			MEM_WORKING_CITY: "Cupertino" 멤버 일하는 지역 입니다.
			MILESTONECNT: 3 멤버 작성한 마일스톤 갯수 입니다.
			NEWSCNT: 22 멤버가 작성한 뉴스 갯수 입니다.
			NEWSCOMCNT: 34 멤버가 작성한 뉴스 댓글 갯수 입니다.
			*/
			
			
			
			
			
			$.each(res, function(i, project){
				
				if(project.PROJ_DROP_DATE){
					return;
				}
				
				let projectBox = $('#personal-template').children('.projectBox').clone();
				
				projectBox.attr('data-manager_id',project.PROJ_MANAGERID);
				projectBox.attr('data-project_title',project.PROJ_TITLE);
				
				if(project.PROJ_TITLE == null){
					projectBox.find('.projTitle').find('span').text('참여 프로젝트가 없습니다.')
					projectBox.find('.manager-area').remove();
					projectBox.find('.profile').remove();
					projectBox.find('.proj-join-date-info').remove();
					projectBox.find('.proj-start-date-info').remove();
					projectBox.find('.progress-area').remove();
					
				}else{
					projectBox.find('.projTitle').find('span').text(project.PROJ_TITLE);
					projectBox.find('.projManager').find('span').text(project.MEM_ROLE_NM + ' - ' + project.PROJ_USER_NICK);
					projectBox.find('.profile').attr('src', getProfilePath(project.MANAGERPIC));
					projectBox.find('.proj-join-date-info').find('span').text('join ' + moment(project.JOIN_DATE).format('YYYY-MM-DD'));
					projectBox.find('.proj-start-date-info').find('span').text('project start ' + moment(project.PROJ_START_DATE).fromNow());
					
				}
			
				
				
				
				$('#personal-proj-list').append(projectBox);
				
 				// 날짜에 따른 진척률 계산
 				let startDate = project.PROJ_START_DATE;
 				let endDate = project.PROJ_EST_END_DATE;
 				let total;
 				let prog;
				
				
 				if(endDate){
 					total = moment(endDate) - moment(startDate);
 					prog = moment() - moment(startDate);
 				}			

 				let progPercent = endDate ? Math.round(prog / total * 1000) / 10 : 0;
 				progPercent = progPercent > 100 ? 100 : progPercent ;
				
 				let progressBar = projectBox.find('.progress-bar');
				
 				progressBar.text(progPercent + '%');
 				progressBar.attr("style", 'width:' + progPercent + '%');
				

				
				
		
				
//	 			프로젝트에 대한건 아래의 변수들을 사용하면 됩니다. $.each 안에서 project. 으로 불러오면 됩니다.
//	 			PROJ_CONT: "test" 
//	 			PROJ_DROP_DATE: 1624024190000
//	 			PROJ_JOIN_DATE: 1623915822000
//	 			PROJ_MANAGERID: "eisen"
//	 			PROJ_START_DATE: 1623818635000
//	 			PROJ_STATUS: "0"
//	 			PROJ_TITLE: "GilsTestProject"
//	 			PROJ_USER_NICK: "박세현"
			});
			
		},
		
		error : function(xhr, error, msg) {
			// 존재하지 않는 아이디의 경우가 있으므로 무조건 필요합니다. 따로 리다이렉트는 안합니다.
			// 존재하지 않는 회원의 페이지에 방문 했을경우의 디자인은 간단히만 처리 해 주세요. 일단 sweetr 메시지만 해둡니다.
			// toastr.error 아래에 코드 이어서 작성하면 됩니다.
			if(xhr.status == 404){
				toastr.error('존재하지 않는 회원 아이디 입니다');
			}
			ajaxError(xhr, error, msg);
		},
		dataType : 'json'
		,async : false
	})
} 	






