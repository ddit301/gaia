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
// overview.jsp
// 페이지 로딩 시 retrieveMemberProjectIssue(mem_no) 요청 
var loadMemberInfo = function(){
	let need = "MemberProjectIssue";
	$.ajax({
		url : getContextPath()+"/restapi/member/members" ,
		type : 'get',
		data : {"need" : need},
		success : function(res) {
			let memberInfo = res.search;
			let projectList="";
			let length;
			let proj_manager ="";
			let profile_img =$("#profile_img").attr("src", getProfilePath(memberInfo.mem_pic_file_name));
			$.each(memberInfo.projectList, function(i, v){
				let url = v.url;
				proj_manager = v.projectManager.mem_id;
				projectList += "<li>"
							+'		<a class="projectName" data-manager_id="'+v.projectManager.mem_id+'" data-project_title="'+v.proj_title+'" href="'+getContextPath()+"/"+ v.url+'">'+ v.proj_title
							+"		</a>"
							+"	</li>";
				
				$.each(v.issueList, function(j, iss){
					let issue = $("#issueTemplate").children(".issue").clone();
					let timeUploaded = iss.historyList[0].issue_his_date;
					let timeAgo = moment(timeUploaded, "YYYYMMDD").fromNow();
					let proj_manager_link = "<a href="+getContextPath()+"/"+proj_manager+">"+proj_manager+"</a>"; 
					let proj_link = "<a href="+getContextPath()+"/"+url+">"+"/"+v.proj_title+"</a>";
					let issue_link = "<a href="+getContextPath()+"/"+iss.url+">"+"/"+iss.issue_sid+"</a>";
					
					issue.attr("data-issue_sid", iss.issue_sid);
					issue.find(".issue-card-top").children().first().html(proj_manager_link + proj_link + issue_link);
					
					issue.find(".issue-card-top").children().last().text(iss.issue_title);
					issue.find(".issue-card-mid").find(".issue_date").text(timeAgo);
					issue.find(".issue-card-mid").find(".fixer_id").text("by "+iss.historyList[0].historyWriter.mem_nick);
					issue.find('.issue-card-bot').text(iss.historyList[0].issue_his_cont);
						
					issue.appendTo("#issues");
				})
				length = v.issueList.length
				if(length%2){
					$("#issueTemplate").children(".issue").clone().appendTo("#issues");
				}
			})
			$("#projectList").html(projectList);
			$("#mem_bio").text(memberInfo.mem_bio);
		},
		async : false
		,error : function(xhr) {
			console.log(xhr);
			// 해당 404 는 뜨면 안되는 에러지만, 충분한 테스팅 후 아래 alert 모두 적절한 예외 처리 필요
			if(xhr.status == '404'){
				alert("실패");				
			}else{
				alert("status : " + xhr.status);
			}
		},
		dataType : 'json'
	})
}