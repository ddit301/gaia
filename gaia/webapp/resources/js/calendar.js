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
	let arr;
	$.ajax({
		url : getContextPath()+"/restapi/project/calendar",
		method : 'get',
		success : function(res) {
			scrollUp();
			console.log(res);
			// closed"0", open"1", 공백  으로 status를 표시할 수 있다.
			CheckNullUndefined(status) ? arr=addCalendarArray(res, ) : arr=addCalendarArray(res, status);
			
			console.log(arr);
			calendar(arr, status);
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}

// 조건 부여하기.
const addCalendarArray = function(res, status){
	let arr = [];
	console.log(status);
	// open, close, all
	// status 가 undefined이면 모두 보여주기 - param을 넘기지 않으면 됨.
	// 0이면 0인 녀석들만 보여주기 1이면 1인 녀석들만 보여주기.
	$.each(res.milestoneList, function(i, milest){
		!CheckNullUndefined(status) ? 
				(milest.milest_status==status ? printChart(milest, arr,status) : null) :  printChart(milest, arr);
	})
	$.each(res.issueList, function(i, issue){
		!CheckNullUndefined(status) ? 
				(issue.issue_status==status ? printChart(issue, arr,status) : null) :  printChart(issue, arr);
	})
	return arr;
}

// arr에 모든 마일스톤과 이슈 담기. 
const printChart = function(name, arr, total_status){
	let currentTime = new Date();
	currentTime = moment(currentTime).format('YYYY-MM-DD');
	let menu = "ISSUE";
	if("issue_sid" in name){
		if(!CheckNullUndefined(name.issue_end_date)){
			arr.push({
				total_status : total_status,
				menu: menu,
				sid: name.issue_sid,
				self_status: name.issue_status,
	  			title: name.issue_title,
	  			start: YYYYMMDD(name.issue_start_date) ? YYYYMMDD(name.issue_start_date) : currentTime,
				end : YYYYMMDD(name.issue_end_date)
	  		})
		}
	}else{
		if(!CheckNullUndefined(name.milest_end_date)){
			menu="MILESTONE"
	  		arr.push({
				total_status : total_status,
				menu: menu,
				sid: name.milest_sid,
				self_status: name.milest_status,
	  			title: name.milest_title,
	  			start: name.milest_start_date
	  		})
	  		arr.push({
				total_status : total_status,
				menu: menu,
				sid: name.milest_sid,
				self_status: name.milest_status,
				borderColor: "#d83737",
	  			title: name.milest_title,
	  			start: name.milest_end_date
	  		})
		}
	}
}
const calendar = function(arr){
	let currentTime = new Date();
	currentTime = moment(currentTime).format('YYYY-MM-DD');
    var calendarEl = document.getElementById('calendar');
    let calendar = new FullCalendar.Calendar(calendarEl, {
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
      eventClick: function(arg) {
		console.log(arg)
		if(CheckNullUndefined(arg.event.extendedProps.total_status)){
			console.log("show All")
    		closeOrOpenAlert(arg, );
		}else{
			console.log("show open/close")
			closeOrOpenAlert(arg, arg.event.extendedProps.total_status);
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
//           title: 'Click for Google',
//           url: 'http://google.com/',
//           start: '2021-09-28'
//         }
//       ]
    });
    calendar.render();
}

// 클릭 시 해당 메뉴를 닫을지 열것인지 알러트
const closeOrOpenAlert = function(arg, isShowAll){
	let status_value = "CLOSE";
	// self_status 가 1이면 0으로 0 이면 1로 변경
	let toBeStatus = Number(arg.event.extendedProps.self_status) ? 0 : 1;
	
	arg.event.extendedProps.self_status == 0 ? status_value : status_value="OPEN"; 
	  
	swalWithBootstrapButtons = Swal.mixin({
		customClass: {
			confirmButton: 'btn btn-success',
			cancelButton: 'btn btn-danger'
		},
		buttonsStyling: false
	})
	swalWithBootstrapButtons.fire({
		title: status_value,
		text: "해당 "+ arg.event.extendedProps.menu + "를 "+status_value+" 하시겠습니까?",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonText: '네',
		cancelButtonText: '아니오',
		reverseButtons: false
	}).then((result) => {
		if (result.isConfirmed) {
			// update
			let result = updateStatus(arg.event.extendedProps.menu, arg.event.extendedProps.sid, 
									toBeStatus);
			if(result != 0){
				// false면 open/close.  true는 undefined
				CheckNullUndefined(isShowAll) ?  null : arg.event.remove();
				swal.success();
			}
		}
	})
}


const updateStatus = function(menu, sid, status){
	menu = menu.toLowerCase();
	console.log(menu);
	
	$.ajax({
		url : getContextPath()+"/restapi/project/calendar",
		method : "post",
		data : {
			"_method" : "put",
			"need" : menu,
			"sid" : sid,
			"status" : status
		},
		success : function(res) {
			console.log(res);
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
