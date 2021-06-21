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
			scrollUp();
			console.log(res);
			// "0", "1", 공백  으로 status를 표시할 수 있다.
			let arr=addCalendarArray(res, );
			
			console.log(arr);
			// "0", "1", 공백  으로 status를 표시할 수 있다.
			calendar(arr, );
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}
// 2021-01-11 
const YYYYMMDD = function(time){
	time = moment(time).format('YYYY-MM-DD');
	return time; 
}
// 클릭 시 해당 메뉴를 닫을지 열것인지 알러트
const closeOrOpenAlert = function(arg, isShowAll){
	let status = "CLOSE";
	arg.event.extendedProps.status == 0 ? status : status="OPEN"; 
	  
	swalWithBootstrapButtons = Swal.mixin({
		customClass: {
			confirmButton: 'btn btn-success',
			cancelButton: 'btn btn-danger'
		},
		buttonsStyling: false
	})
	swalWithBootstrapButtons.fire({
		title: status,
		text: "해당 "+ arg.event.extendedProps.menu + "를 "+status+" 하시겠습니까?",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonText: '네',
		cancelButtonText: '아니오',
		reverseButtons: false
	}).then((result) => {
		if (result.isConfirmed) {
			// update
			
			// false면 값이존재한다.  true는 undefined
			CheckNullUndefined(isShowAll) ?  null : arg.event.remove();
			swal.success();
		}
	})
}
// arr에 모든 마일스톤과 이슈 담기.
const printChart = function(name, arr){
	let currentTime = new Date();
	currentTime = moment(currentTime).format('YYYY-MM-DD');
	let menu = "ISSUE";
	let status = "";
	if("issue_sid" in name){
		if(!CheckNullUndefined(name.issue_end_date)){
			arr.push({
				menu: menu,
				sid: name.issue_sid,
				status: name.issue_status,
	  			title: name.issue_title,
	  			start: YYYYMMDD(name.issue_start_date) ? YYYYMMDD(name.issue_start_date) : currentTime,
				end : YYYYMMDD(name.issue_end_date)
	  		})
		}
	}else{
		if(!CheckNullUndefined(name.milest_end_date)){
			menu="MILESTONE"
	  		arr.push({
				menu: menu,
				sid: name.milest_sid,
				status: name.milest_status,
	  			title: name.milest_title,
	  			start: name.milest_start_date
	  		})
	  		arr.push({
				menu: menu,
				sid: name.milest_sid,
				status: name.milest_status,
				borderColor: "#d83737",
	  			title: name.milest_title,
	  			start: name.milest_end_date
	  		})
		}
	}
}
// 조건 부여하기.
const addCalendarArray = function(res, status){
	let arr = [];
	// open, close, all
	$.each(res.milestoneList, function(i, milest){
		status ? (milest.milest_status==status ? printChart(milest, arr,status) : null) :  printChart(milest, arr,status);
	})
	$.each(res.issueList, function(i, issue){
		status ? (issue.issue_status==status ? printChart(issue, arr,status) : null) :  printChart(issue, arr,status);
	})
	return arr;
}

const calendar = function(arr, isShowAll){
	let currentTime = new Date();
	currentTime = moment(currentTime).format('YYYY-MM-DD');
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: currentTime,
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
      eventClick: function(arg, status) {
		console.log(arg)
		if(arg.event.extendedProps.status == 0){
			closeOrOpenAlert(arg);
		}else if(arg.event.extendedProps.status == 1){
			closeOrOpenAlert(arg);
		}
		// status 가 공백이면 (모두 보여주기)
		if(CheckNullUndefined(isShowAll)){
			if(arg.event.extendedProps.status == 0){
        		closeOrOpenAlert(arg, status);
			}else if(ar.event.extendedProps.status == 1){
				if (confirm('Are you sure you want to open this event?')) {
				// todo update
				}
			}
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



