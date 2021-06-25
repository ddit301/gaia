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
	$('body').on("keyup", "#dropdownMenuSearchInput",function(e){
		let keyword = $(this).val()
		console.log($(this).val())
		elasticTotalSearch(keyword);
	})
});

const elasticTotalSearch = function(keyword){
	$.ajax({
		url : "http://222.114.124.74:9200/gaia/_search?q="+keyword,
		method : 'get',
		success : function(res) {
			console.log(res)	
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}
