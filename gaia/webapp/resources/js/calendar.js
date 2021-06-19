/**
 * @author Eisen
 * @since Jun 19, 2021
 * @version 1.0
 * @see javax.servlet.http.HttpServlet
 * <pre>
 * [[개정이력(Modification Information)]]
 * Date         Modifier     Modification
 * --------     --------    ----------------------
 * Jun 19, 2021  Eisen    Initial Commit
 * Copyright (c) 2021 by Team Gaia All right reserved
 * </pre>
 */
const issueMilestoneInfoForCalendar = function(){
	$.ajax({
		url : getContextPath()+"/restapi/project/calendar",
		method : 'get',
		success : function(res) {
			console.log(res);
			let arr=addCalendarArray(res);
			console.log(arr);
			calendar(arr);
		},
		async : false,
		error : function(xhr) {
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
const addCalendarArray = function(res){
	let arr = [];
	$.each(res.milestoneList, function(i, milestone){
		  if(!CheckNullUndefined(milestone.milest_end_date)){
	  		  arr.push({
	  			  title: milestone.milest_cont,
	  			  start: milestone.milest_start_date
	  		  })
		  }
	  })
	return arr;
}

const calendar = function(arr){
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: '2021-09-12',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
     
      select: function(arg) {
        var title = prompt('Event Title:');
        if (title) {
          calendar.addEvent({
            title: title,
            start: arg.start,
            end: arg.end,
            allDay: arg.allDay
          })
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
        if (confirm('Are you sure you want to delete this event?')) {
          arg.event.remove()
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: arr
//       [
//         {
//           title: 'All Day Event',
//           start: '2021-09-01'
//         },
//         {
//           title: 'Long Event',
//           start: '2021-09-07',
//           end: '2021-09-10'
//         },
//         {
//           groupId: 999,
//           title: 'Repeating Event',
//           start: '2021-09-09T16:00:00'
//         },
//         {
//           groupId: 999,
//           title: 'Repeating Event',
//           start: '2021-09-16T16:00:00'
//         },
//         {
//           title: 'Conference',
//           start: '2021-09-11',
//           end: '2021-09-13'
//         },
//         {
//           title: 'Meeting',
//           start: '2021-09-12T10:30:00',
//           end: '2021-09-12T12:30:00'
//         },
//         {
//           title: 'Lunch',
//           start: '2021-09-12T12:00:00'
//         },
//         {
//           title: 'Meeting',
//           start: '2021-09-12T14:30:00'
//         },
//         {
//           title: 'Happy Hour',
//           start: '2021-09-12T17:30:00'
//         },
//         {
//           title: 'Dinner',
//           start: '2021-09-12T20:00:00'
//         },
//         {
//           title: 'Birthday Party',
//           start: '2021-09-13T07:00:00'
//         },
//         {
//           title: 'Click for Google',
//           url: 'http://google.com/',
//           start: '2021-09-28'
//         }
//       ]
    });
    calendar.render();
}

