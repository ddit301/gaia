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
		if(title =="장비점검"){
			console.log(result)
		}  
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
	console.log("milestone")
	console.log(i)
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
		console.log(cnt)
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
	//g.AddTaskItemObject({
//	  <pID>25</pID>
//    <pName>WCF Changes</pName>
//    <pStart></pStart>
//    <pEnd></pEnd>
//    <pClass>gtaskred</pClass>
//    <pLink></pLink>
//    <pMile>0</pMile>
//    <pRes></pRes>
//    <pComp>0</pComp>
//    <pGroup>1</pGroup>
	//    <pParent>2</pParent>
//    <pOpen>1</pOpen>
//    <pDepend>2,24</pDepend>
//    <pCaption>A caption</pCaption>
//    <pNotes>Text - can include limited HTML</pNotes>
//																																		   Gp Pt  Op  Dp
//g.AddTaskItem(new JSGantt.TaskItem(1,   'Define Chart API',     '',           '',          'ggroupblack',  '',       0, 'Brian',    0,   1, 0,  1, '',      '',      'Some Notes text', g ));
//g.AddTaskItem(new JSGantt.TaskItem(11,  'Chart Object',         '2016-02-20','2016-02-20', 'gmilestone',   '',       1, 'Shlomy',   100, 0, 1,  1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(12,  'Task Objects',         '',           '',          'ggroupblack',  '',       0, 'Shlomy',   40,  1, 1,  1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(121, 'Constructor Proc',     '2016-02-21','2016-03-09', 'gtaskblue',    '',       0, 'Brian T.', 60,  0, 12, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(122, 'Task Variables',       '2016-03-06','2016-03-11', 'gtaskred',     '',       0, 'Brian',    60,  0, 12, 1, 121,     '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(123, 'Task by Minute/Hour',  '2016-03-09','2016-03-14 12:00', 'gtaskyellow', '',  0, 'Ilan',     60,  0, 12, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(124, 'Task Functions',       '2016-03-09','2016-03-29', 'gtaskred',     '',       0, 'Anyone',   60,  0, 12, 1, '123SS', 'This is a caption', null, g));
//g.AddTaskItem(new JSGantt.TaskItem(2,   'Create HTML Shell',    '2016-03-24','2016-03-24', 'gtaskyellow',  '',       0, 'Brian',    20,  0, 0,  1, 122,     '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(3,   'Code Javascript',      '',           '',          'ggroupblack',  '',       0, 'Brian',    0,   1, 0,  1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(31,  'Define Variables',     '2016-02-25','2016-03-17', 'gtaskpurple',  '',       0, 'Brian',    30,  0, 3,  1, '',      'Caption 1','',   g));
//g.AddTaskItem(new JSGantt.TaskItem(32,  'Calculate Chart Size', '2016-03-15','2016-03-24', 'gtaskgreen',   '',       0, 'Shlomy',   40,  0, 3,  1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(33,  'Draw Task Items',      '',           '',          'ggroupblack',  '',       0, 'Someone',  40,  2, 3,  1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(332, 'Task Label Table',     '2016-03-06','2016-03-09', 'gtaskblue',    '',       0, 'Brian',    60,  0, 33, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(333, 'Task Scrolling Grid',  '2016-03-11','2016-03-20', 'gtaskblue',    '',       0, 'Brian',    0,   0, 33, 1, '332',   '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(34,  'Draw Task Bars',       '',           '',          'ggroupblack',  '',       0, 'Anybody',  60,  1, 3,  0, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(341, 'Loop each Task',       '2016-03-26','2016-04-11', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(342, 'Calculate Start/Stop', '2016-04-12','2016-05-18', 'gtaskpink',    '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(343, 'Draw Task Div',        '2016-05-13','2016-05-17', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(344, 'Draw Completion Div',  '2016-05-17','2016-06-04', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, "342,343",'',     '',      g));
//g.AddTaskItem(new JSGantt.TaskItem(35,  'Make Updates',         '2016-07-17','2017-09-04', 'gtaskpurple',  '',       0, 'Brian',    30,  0, 3,  1, '333',   '',      '',      g));

g.Draw();
//let ganttDom = document.getElementById('GanttChartDIV')
//let tableDom = ganttDom.querySelector('.gmainleft')
//let ganttChartDom = ganttDom.querySelector('.gmainright')
//tableDom.style = 'width:20%'
//ganttChartDom.style = 'flex:90%'


}
