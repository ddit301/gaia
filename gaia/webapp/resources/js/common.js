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
		  "timeOut": "2500",
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
		console.log($(this).val())
		clearTimeout(timer);
		let keyword = $(this).val()
		timer = setTimeout("elasticTotalSearch('"+keyword+"')", 500)
	})
});

const elasticTotalSearch = function(keyword){
	keyword = encodeURI(keyword)
	$.ajax({
		url : getContextPath() + "/restapi/project/projects/",
		method : 'get',
		data : {"need" : "totalSearch",
				"keyword" : keyword},
		success : function(res) {
			console.log(res)
			// 시작하기 전에 비워주기.
			$(".dropdown .dropdown-menu.total-search-dropdown").empty();
			
			// copyList를 생성해서 issue, milestone 등을빼내기
			let copyList = [...res.hits.hits];
			console.log(copyList)			
			
			if(res.hits.hits.length == 0){
				searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("a").clone()
				searchResult.html('<i class="mdi mdi-alert-circle-outline"></i>검색 결과가 없습니다.')
				$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
			}
			// issue를 거르기.
			console.log(res.hits.hits.length)
			if(res.hits.hits.length != 0){
				searchResultLoop(res, "issue_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "milest_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "proj_no",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "news_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "mem_no",copyList);
				console.log(res.hits.hits.length)
			}
		},
		async : false
		, error : function(xhr, error, msg) {
			ajaxError(xhr, error, msg)
		},
		dataType : 'json'
	})
}
const searchResultLoop = function(res, key, copyList){
	console.log(res.hits.hits)
	console.log(copyList)
	console.log(key)
	cnt = 0;
	$.each(res.hits.hits, function(i, hit){
		console.log(i)
		if(key in hit["_source"]){
			searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("a").clone()
			if(key == "issue_sid"){
				searchResult.html('<i class="icon-fire"></i>'+hit._source.issue_his_cont)
			}else if(key == "milest_sid"){
				searchResult.html('<i class="icon-direction"></i>'+hit._source.milest_title)
			}else if(key == "proj_no"){
				searchResult.html('<i class="mdi file-document-outlinee"></i>'+hit._source.proj_title)
			}else if(key == "news_sid"){
				searchResult.html('<i class="icon-book-open"></i>'+hit._source.news_title)
			}else if(key == "mem_no"){
				searchResult.html('<i class="icon-user"></i>'+hit._source.mem_no)
			}
			var index = copyList.indexOf(hit);
			if (index !== -1) {
				console.log(copyList.splice(index-cnt, 1));
				cnt++;
			}
			$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
		}
		res.hits.hits = [...copyList]
	})
}
