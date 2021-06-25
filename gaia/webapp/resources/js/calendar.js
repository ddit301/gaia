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
$(function(){
	$(".body").on("click","button.fc-prev-button",function() {
	    var date = jQuery("#calendar").fullCalendar("getDate");
	    convertDate(date);
	});	
	
	$('body').on('click', '.fc-button-group:eq(1) button', function(){
		$('.fc-button-group:eq(1) button').removeClass('fc-button-active');
		$(this).addClass('fc-button-active');
	});
})
const issueMilestoneInfoForCalendar = function(status){
	status = CheckNullUndefined(status) ? 1 : status;
	$.ajax({
		url : getContextPath()+"/restapi/project/calendar",
		method : 'get',
		success : function(res) {
			scrollUp();
			$("calendar").empty()
			// open / close;
			reCal(res, status);
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
	console.log(status)
	// open, close, all 별로 출력할 item들 걸러주기
	$.each(res.milestoneList, function(i, milest){
		!CheckNullUndefined(status) ? 
				(milest.milest_status==status ? printChart(milest, arr,status) : null) :  printChart(milest, arr);
	});
	$.each(res.issueList, function(i, issue){
		!CheckNullUndefined(status) ? 
				(issue.issue_status==status ? printChart(issue, arr,status) : null) :  printChart(issue, arr);
	});
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
	  			start: name.milest_start_date,
				isStart : 1,
				id : name.milest_sid
	  		})
	  		arr.push({
				total_status : total_status,
				menu: menu,
				sid: name.milest_sid,
				self_status: name.milest_status,
				borderColor: "#d83737",
	  			title: name.milest_title,
	  			start: name.milest_end_date,
				isStart : 0,
				id : name.milest_sid
	  		})
		}
	}
}
// 출력 함수
const reCal = function(res, status){
	console.log(status)
	let arr;
	CheckNullUndefined(status) ? arr=addCalendarArray(res, ) : arr=addCalendarArray(res, status);
	showCalendar(arr, res);
}
const showCalendar = function(arr, res){
	let isChanged = false;
	let currentTime = new Date();
	currentTime = moment(currentTime).format('YYYY-MM-DD');
    let calendarEl = document.getElementById('calendar');
    let calendar = new FullCalendar.Calendar(calendarEl, {
	  customButtons: {
	    openBtn: {
	      text: 'open',
	      click: function() {
			// 값이 변경 했을 경우만 ajax 호출 변경하지 않을 경우 기존의 결과로출력(퍼포먼스)
			isChanged ? issueMilestoneInfoForCalendar(1) : reCal(res, 1);
	      }
	    },
	    closedBtn: {
	      text: 'closed',
	      click: function() {
			isChanged ? issueMilestoneInfoForCalendar(0) : reCal(res, 0);
	      }
	    },
	    allBtn: {
	      text: 'all',
	      click: function() {
	        isChanged ? issueMilestoneInfoForCalendar() : reCal(res, );
	      }
	    }
	  },
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'openBtn,closedBtn,allBtn dayGridMonth,timeGridWeek,timeGridDay'
      },
      initialDate: currentTime,
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
     
      select: function(arg) {
        calendar.unselect()
      },
      eventClick: function(arg) {
		isChanged = true;
		if(CheckNullUndefined(arg.event.extendedProps.total_status)){
    		closeOrOpenAlert(calendar, arg, );
		}else{
			closeOrOpenAlert(calendar, arg, arg.event.extendedProps.total_status);
		}
      },
	  eventDrop: function (arg) {
		isChanged = true;
		updateStatus(arg,null, "yes");
		
      },
      eventResize: function (arg) {
		isChanged = true;
		updateStatus(arg,null, "yes");
      },
      editable: true,
	  droppable : true, 
      dayMaxEvents: true, // allow "more" link when too many events
      events: arr
    });
    calendar.render();
	let buttons = $('.fc-button-group').find('button');
	for(i=0; i<buttons.length; i++){
		let text = buttons.eq(i).text();
		if(text == 'open'){
			buttons.eq(i).addClass('fc-button-active');
			break;
		}
	}
}

// 클릭 시 해당 메뉴를 닫을지 열것인지 알러트
const closeOrOpenAlert = function(calendar, arg, isShowAll){
	
	// self_status 가 1이면 0으로 0 이면 1로 변경
	let toBeStatus = Number(arg.event.extendedProps.self_status) ? 0 : 1;
	
	// self_status 가 1(open)이면 closed할거냐 묻고 0(closed)이면 open할거냐고 묻기 
	let status_value = 
			Number(arg.event.extendedProps.self_status) ? "CLOSED" : "OPEN"; 
	  
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
			// update 실행시키기.
			let result = updateStatus(arg,toBeStatus, null);
			if(result != 0){
				// false면 open/close. true는 undefined
				if(!CheckNullUndefined(isShowAll)){
					if(arg.event.extendedProps.menu =="MILESTONE"){
						for(i=0; i<2; i++){
							calendar.getEventById(arg.event.id).remove()
						}
					}else{
						arg.event.remove()
					}
				} 
				swal.success();
				toastr.success("["+arg.event.extendedProps.menu+"] '"+arg.event.title+"'가 "+status_value+" 되었습니다.")
				// 동일한 id를 가지고 있는 item(마일스톤) 삭제하기
				
			}else{
				toastr.error('Update에 실패했습니다.')
			}
		}
	})
}



// update
const updateStatus = function(arg, toBeStatus, isChangeDate){
	let data = {};
	let start = CheckNullUndefined(arg.event.start) ? null : YYYYMMDD(arg.event.start)
	let end =  CheckNullUndefined(arg.event.end) ? null : YYYYMMDD(arg.event.end)
	console.log(end)
	if(!CheckNullUndefined(arg.event.extendedProps.isStart)){
		if(!arg.event.extendedProps.isStart){
			end = start
			start = null
		}
	}
	console.log(end)
	data["_method"] = "put";
	data["need"] =  arg.event.extendedProps.menu.toLowerCase();
	data["sid"] = arg.event.extendedProps.sid;
	CheckNullUndefined(isChangeDate) ?  
			(data["status"]=toBeStatus) : 
				(data["isChangeDate"]=isChangeDate, 
				data["start_date"]=start,
				data["end_date"]=end);
	$.ajax({
		url : getContextPath()+"/restapi/project/calendar",
		method : "post",
		data : data,
		success : function(res) {
			console.log("Update success")
			toastr.success('Update에 성공했습니다.')
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
