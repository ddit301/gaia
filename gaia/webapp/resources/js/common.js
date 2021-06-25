//////////////////////////////////////////////////////////////////////////////
//
//	 각종 설정
//
//////////////////////////////////////////////////////////////////////////////

// toastr 알람 설정
toastr.options = {
		  "closeButton": false,
		  "debug": false,
		  "newestOnTop": false,
		  "progressBar": true,
		  "positionClass": "toast-top-right",
		  "preventDuplicates": false,
		  "onclick": null,
		  "showDuration": "100",
		  "hideDuration": "1000",
		  "timeOut": "2000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
		}
		
// Swal Alert 설정
var swal = {
	error : function(data){
		if(!data){data = { };}
		Swal.fire({
			icon: 'error',
			title: typeof data.title !=='undefined' ? data.title : 'Oops...', 
			text: !!data.text ? data.text : 'Something went wrong!',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	},
	success : function(data){
		if(!data){data = { };}
			Swal.fire({
				icon: 'success',
				title: !!data.title ? data.title : 'Success!!',
				text: !!data.text ? data.text : 'Your work has been saved!',
				showConfirmButton : !!data.confirm ? true : false,
				timer: 1500
			})
	},
	warning : function(data){
		if(!data){data = { };}
		Swal.fire({
			icon: 'warning',
			title: !!data.title ? data.title : 'Oops...', 
			text: !!data.text ? data.text : 'You should do someting first!',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	},
	info : function(data){
		if(!data){data = { };}
		Swal.fire({
			icon: 'info',
			title: !!data.title ? data.title : 'Have to know!', 
			text: !!data.text ? data.text : 'blablabla',
			showConfirmButton : !!data.confirm ? true : false,
			timer: 1500
		})
	}
}

//////////////////////////////////////////////////////////////////////////////
//
//	 total_search
//
//////////////////////////////////////////////////////////////////////////////

$(function(){
	var timer;
	$('body').on("keyup", "#dropdownMenuSearchInput",function(e){
		
		clearTimeout(timer);
		let keyword = $(this).val()
		console.log($(this).val())
		timer = setTimeout("elasticTotalSearch('"+keyword+"')", 500)
	})
	function alertTest(){
		alert("heyyyyyy")
	}
});

const elasticTotalSearch = function(keyword){
	
	keyword = encodeURI(keyword)
	let list;
	$.ajax({
		url : getContextPath() + "/restapi/project/projects/",
		method : 'get',
		data : {"need" : "totalSearch",
				"keyword" : keyword},
		success : function(res) {
			$(".dropdown .dropdown-menu.total-search-dropdown").empty();
			
			// issue를 거르기.
			$.each(res.hits.hits, function(i, hit){
				if("issue_sid" in hit._source){
					searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("a").clone()
					searchResult.html('<i class="icon-fire"></i>'+hit._source.issue_his_cont)
					console.log(searchResult.text())
//					var index = res.hits.hits.indexOf(hit);
//					if (index !== -1) {
//						console.log(res.hits.hits.splice(index, 1));
//					}
				}
				$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
			})
			
			
			
			$.each(res.hits.hits, function(i, hit){
				
			})
			console.log(list)
			console.log(res.hits.hits)
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}
