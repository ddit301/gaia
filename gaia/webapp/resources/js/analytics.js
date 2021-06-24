/**********************************

	Document Ready 시작

********************************/

$(function() {

	/**********************************
		버튼 매핑 시작
	********************************/



})
/**********************************

			Document Ready 끝

********************************/



/**********************************
	변수 선언부
********************************/



/**********************************
	함수 선언부
********************************/

// 페이지에 필요한 데이터들 비동기로 받아오기.
const loadAnalytics = function(){
	$.ajax({
		url : getContextPath() + '/restapi/project/loadAnalytics.do',
		method : 'get',
		success : function(res) {
			let members = res.members;
			let project = res.project;
			
			// 시작, 종료 일자 출력 진행도 출력
			let startDate = moment(project.PROJ_START_DATE).format('YYYY-MM-DD');
			let endDate = project.PROJ_EST_END_DATE;
			let endDateText = endDate ? moment(endDate).format('YYYY-MM-DD') : '';
			let total;
			let prog;
			
			if(endDate){
				total = moment(endDate) - moment(startDate);
				prog = moment() - moment(startDate);
			}	
			
			let progPercent = endDate ? Math.round(prog / total * 1000) / 10 : 0;
			progPercent = progPercent > 100 ? 100 : progPercent ;
			
			let progressBar = $('.date-stauts').find('.progress-bar');
			progressBar.text(progPercent + '%');
			progressBar.attr("style", 'width:' + progPercent + '%');
			
			let dateText = startDate + ' ~ ' + endDateText;
			$('.date-stauts').find('span').text(dateText);
			
			// 총 일감 및 완료 일감 관련 출력
			let totalTask = project.ISSUECOUNT + project.MILESTONECOUNT;
			let finishedTask = totalTask - project.OPENISSUE - project.OPENMILESTONE;
			// 0 으로 나누어지지 않도록 처리
			let taskProg = totalTask ? Math.round(finishedTask / totalTask * 1000) / 10 : 0;
			
			let taskProgBar = $('.progress-status').find('.progress-bar');
			taskProgBar.text(taskProg + '%');
			taskProgBar.attr("style", 'width:' + taskProg + '%');
			
			// 일감 갯수에 대해 출력
			$('.progress-status').find('span').text('총 '+ totalTask + '개의 일감중 '+ finishedTask + '완료.');
			
			// 마일스톤 통계 출력
			$('.stat-milestone').find('span').eq(1).text(project.MILESTONECOUNT);
			$('.stat-milestone').find('span').eq(2).text(project.OPENMILESTONE);
			$('.stat-milestone').find('span').eq(3).text(project.MILESTONECOUNT-project.OPENMILESTONE);
			
			// 이슈 통계 출력
			$('.stat-issue').find('span').eq(1).text(project.ISSUECOUNT);
			$('.stat-issue').find('span').eq(2).text(project.OPENISSUE);
			$('.stat-issue').find('span').eq(3).text(project.ISSUECOUNT-project.OPENISSUE);
			
			// 이슈 히스토리, 라벨, 멤버 역할 갯수 출력
			$('.stat-issue-history').find('span').eq(1).text(project.ISSUEHISCOUNT);
			$('.stat-label').find('span').eq(1).text(project.LABELCOUNT);
			$('.stat-role').find('span').eq(1).text(project.ROLECOUNT);
			
			// 칸반 컬럼, 카드, 뉴스, 댓글, 위키 갯수 출력
			$('.stat-col').find('span').eq(1).text(project.COLUMNCOUNT);
			$('.stat-card').find('span').eq(1).text(project.CARDCOUNT);
			$('.stat-news').find('span').eq(1).text(project.NEWSCOUNT);
			$('.stat-news-com').find('span').eq(1).text(project.NEWSCOMCOUNT);
			$('.stat-wiki').find('span').eq(1).text(project.WIKICOUNT);
			
			let memBoxArea = $('#mem-stat-area');
			memBoxArea.empty();
			$.each(members, function(i, member) {
				let memBox = $('#statTemplate').find('.mem-stat-box').clone();
				memBox.find('img').attr('src', getProfilePath(member.MEM_PIC_FILE_NAME));
				let spanList = memBox.find('span');
				spanList.eq(0).text(member.PROJ_USER_NICK);
				spanList.eq(1).text(moment(member.PROJ_JOIN_DATE).format('YYYY-MM-DD'));
				spanList.eq(2).text(member.MEM_ROLE_NM);
				spanList.eq(3).text(member.MILESTONECOUNT);
				spanList.eq(4).text(member.ISSUECOUNT);
				spanList.eq(5).text(member.ISSUECOMCOUNT);
				spanList.eq(6).text(member.TASKCOUNT);
				spanList.eq(7).text(member.WIKICOUNT);
				spanList.eq(8).text(member.NEWSCOUNT);
				spanList.eq(9).text(member.NEWSCOMCOUNT);
				
				memBoxArea.append(memBox);
			})
		},
		error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg);

		},
		dataType : 'json'
	})
}











