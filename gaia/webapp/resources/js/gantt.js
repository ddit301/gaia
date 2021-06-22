


const loadGanttPage = function(){
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


//// Or Adding  Manually
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
//});

g.AddTaskItem(new JSGantt.TaskItem(1,   'Define Chart API',     '',           '',          'ggroupblack',  '',       0, 'Brian',    0,   1, 0,  1, '',      '',      'Some Notes text', g ));
g.AddTaskItem(new JSGantt.TaskItem(11,  'Chart Object',         '2017-02-20','2017-02-20', 'gmilestone',   '',       1, 'Shlomy',   100, 0, 1,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(12,  'Task Objects',         '',           '',          'ggroupblack',  '',       0, 'Shlomy',   40,  1, 1,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(121, 'Constructor Proc',     '2017-02-21','2017-03-09', 'gtaskblue',    '',       0, 'Brian T.', 60,  0, 12, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(1,   'Define Chart API',     '',           '',          'ggroupblack',  '',       0, 'Brian',    0,   1, 0,  1, '',      '',      'Some Notes text', g ));
g.AddTaskItem(new JSGantt.TaskItem(11,  'Chart Object',         '2017-02-20','2017-02-20', 'gmilestone',   '',       1, 'Shlomy',   100, 0, 1,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(12,  'Task Objects',         '',           '',          'ggroupblack',  '',       0, 'Shlomy',   40,  1, 1,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(121, 'Constructor Proc',     '2017-02-21','2017-03-09', 'gtaskblue',    '',       0, 'Brian T.', 60,  0, 12, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(122, 'Task Variables',       '2017-03-06','2017-03-11', 'gtaskred',     '',       0, 'Brian',    60,  0, 12, 1, 121,     '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(123, 'Task by Minute/Hour',  '2017-03-09','2017-03-14 12:00', 'gtaskyellow', '',  0, 'Ilan',     60,  0, 12, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(124, 'Task Functions',       '2017-03-09','2017-03-29', 'gtaskred',     '',       0, 'Anyone',   60,  0, 12, 1, '123SS', 'This is a caption', null, g));
g.AddTaskItem(new JSGantt.TaskItem(2,   'Create HTML Shell',    '2017-03-24','2017-03-24', 'gtaskyellow',  '',       0, 'Brian',    20,  0, 0,  1, 122,     '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(3,   'Code Javascript',      '',           '',          'ggroupblack',  '',       0, 'Brian',    0,   1, 0,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(31,  'Define Variables',     '2017-02-25','2017-03-17', 'gtaskpurple',  '',       0, 'Brian',    30,  0, 3,  1, '',      'Caption 1','',   g));
g.AddTaskItem(new JSGantt.TaskItem(32,  'Calculate Chart Size', '2017-03-15','2017-03-24', 'gtaskgreen',   '',       0, 'Shlomy',   40,  0, 3,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(33,  'Draw Task Items',      '',           '',          'ggroupblack',  '',       0, 'Someone',  40,  2, 3,  1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(332, 'Task Label Table',     '2017-03-06','2017-03-09', 'gtaskblue',    '',       0, 'Brian',    60,  0, 33, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(333, 'Task Scrolling Grid',  '2017-03-11','2017-03-20', 'gtaskblue',    '',       0, 'Brian',    0,   0, 33, 1, '332',   '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(34,  'Draw Task Bars',       '',           '',          'ggroupblack',  '',       0, 'Anybody',  60,  1, 3,  0, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(341, 'Loop each Task',       '2017-03-26','2017-04-11', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(342, 'Calculate Start/Stop', '2017-04-12','2017-05-18', 'gtaskpink',    '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(343, 'Draw Task Div',        '2017-05-13','2017-05-17', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, '',      '',      '',      g));
g.AddTaskItem(new JSGantt.TaskItem(344, 'Draw Completion Div',  '2017-05-17','2017-06-04', 'gtaskred',     '',       0, 'Brian',    60,  0, 34, 1, "342,343",'',     '',      g));
g.AddTaskItem(new JSGantt.TaskItem(35,  'Make Updates',         '2017-07-17','2017-09-04', 'gtaskpurple',  '',       0, 'Brian',    30,  0, 3,  1, '333',   '',      '',      g));

g.Draw();
//let ganttDom = document.getElementById('GanttChartDIV')
//let tableDom = ganttDom.querySelector('.gmainleft')
//let ganttChartDom = ganttDom.querySelector('.gmainright')
//tableDom.style = 'width:20%'
//ganttChartDom.style = 'flex:90%'


}
