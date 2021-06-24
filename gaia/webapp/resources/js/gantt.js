const loadMilestoneIssueList = function(){
	let result;
	$.ajax({
		url : getContextPath()+"/restapi/project/milestones",
		method : 'get',
		data : {"need" : "milestoneIssueList"}, 
		success : function(res) {
			result = res.list;
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
	return result;
}
// issue 담당자들 이름 이어 붙이기.
const calIssueAssignees = function(mems){
	let result = "";
	if(mems.length == 0){
		result = "";
	}else{
		$.each(mems, function(i, v){
			result += v.mem_id;
		});
	}
	return result;
}
// 공정률 계산하기 
const calComp = function(start_date, end_date, title){
	let currentTime = new Date();
	let today = moment(YYYYMMDD(currentTime));
	let process
	let total
	let result;
	if(CheckNullUndefined(start_date)){
		start_date = today
	}
	if(CheckNullUndefined(end_date)){
		return "0";	
	}else{
		end_date = moment(end_date);
		start_date = moment(start_date);
		total = end_date.diff(start_date, 'days');
		process = today < start_date ?  0 : today.diff(start_date, 'days');
		result = process<=total ? Math.round((process / total) * 100) : "100";
	}
	return result;
}

const loadGanttPage = function(){
	let list = loadMilestoneIssueList();
	let cnt =0;
	var g = new JSGantt.GanttChart(document.getElementById('GanttChartDIV'), 'day');

g.setOptions({
  vCaptionType: 'Complete',  // Set to Show Caption : None,Caption,Resource,Duration,Complete,     
  vQuarterColWidth: 36,
  vDateTaskDisplayFormat: 'day dd month yyyy', // Shown in tool tip box
  vDayMajorDateDisplayFormat: 'mon yyyy - Week ww',// Set format to dates in the "Major" header of the "Day" view
  vWeekMinorDateDisplayFormat: 'dd mon', // Set format to display dates in the "Minor" header of the "Week" view
  vLang: 'en',
  vShowTaskInfoLink: 1, // Show link in tool tip (0/1)
  vShowEndWeekDate: 0,  // Show/Hide the date for the last day of the week in header for daily
  vUseSingleCell: 10000, // Set the threshold cell per table row (Helps performance for large data.
  vFormatArr: ['Day', 'Week', 'Month'], // Even with setUseSingleCell using Hour format on such a large chart can cause issues in some browsers,
});
$.each(list, function(i, milestone){
	g.AddTaskItem(new JSGantt.TaskItem(
			milestone.milest_sid 
			, CheckNullUndefined(milestone.milest_title) ? "독립적인 이슈 목록" : milestone.milest_title 
			, milestone.milest_start_date
			, milestone.milest_end_date
			, "ggroupblack"
			, ''
			, 0
			, ""
			, Number(milestone.milest_status) ? "100" : calComp(milestone.milest_start_date,milestone.milest_end_date)
			, 1
				, 0
			, Number(milestone.milest_status) ? "0" : "1"
			, ''
			, ''
			, milestone.milest_cont
			, g 
	));
	$.each(milestone.issueList, function(l, issue){
		if(CheckNullUndefined(issue)){
			return true;
		}
		g.AddTaskItem(new JSGantt.TaskItem(
			cnt++
			, issue.issue_title
			, issue.issue_start_date
			, issue.issue_end_date
			, Number(issue.issue_status) ? "gtaskred" : "gtaskblue"
			, ''
			, 0
			, CheckNullUndefined(issue.assigneeList) ? "" : calIssueAssignees(issue.assigneeList)
			, Number(issue.issue_status) ? "100" : calComp(issue.issue_start_date,issue.issue_end_date, issue.issue_title)
			, 0
				, milestone.milest_sid
			, 2
			, milestone.milest_sid
			, ''
			, Number(issue.issue_status) ? "Closed" : "Open"
			, g 
		));
	})
});

g.Draw();

}
