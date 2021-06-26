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
	keyword += "*";
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
			
			// 검색 결과가 존재하지 않을 경우 검색결과가 없습니다 출력하기.
			if(res.hits.hits.length == 0){
				searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("div").clone()
				searchResult.children("a").html('<i class="mdi mdi-alert-circle-outline pr-2"></i>검색 결과가 없습니다.')
				$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
			}
			
			// issue_history 거르기.
			console.log(res.hits.hits.length)
			searchResultLoopDelete(res, "issue_his_no",copyList);
			
			// issue > milestone > news > proj > mem 순서로 걸러야 함.
			console.log(res.hits.hits.length)
			if(res.hits.hits.length != 0){
				
				searchResultLoop(res, "kb_card_no",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "issue_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "milest_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "news_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "wiki_sid",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "proj_no",copyList);
				console.log(res.hits.hits.length)
				searchResultLoop(res, "mem_no",copyList);
				console.log(res.hits.hits.length)
			}
			// 검색 후 처리 결과가 0일 경우
			dropdown_a =$(".dropdown .dropdown-menu.total-search-dropdown").children('a')
			if(res.hits.hits.length == 0 && CheckNullUndefined(dropdown_a) ){
				$(".dropdown .dropdown-menu.total-search-dropdown").empty();
				searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("div").clone()
				searchResult.children("a").html('<i class="mdi mdi-alert-circle-outline pr-2"></i>검색 결과가 없습니다.')
				$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
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
			searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("div").clone()
			if(key == "kb_card_no"){
				searchResult.children("a").html('<i class="icon-cursor-move pr-2"></i>'+hit._source.kb_card_cont)
			}else if(key == "issue_sid"){
				searchResult.children("a").html('<i class="icon-fire pr-2"></i>'+hit._source.issue_title)
			}else if(key == "milest_sid"){
				searchResult.children("a").html('<i class="icon-direction pr-2"></i>'+hit._source.milest_title)
			}else if(key == "news_sid"){
				searchResult.children("a").html('<i class="icon-book-open pr-2"></i>'+hit._source.news_title)
			}else if(key == "wiki_sid"){
				searchResult.children("a").html('<i class="icon-graduation pr-2"></i>'+hit._source.wiki_title)
			}else if(key == "proj_no"){
				searchResult.children("a").html('<i class="icon-doc pr-2"></i>'+hit._source.proj_title)
			}else if(key == "mem_no"){
				searchResult.children("a").html('<i class="icon-user pr-2"></i>'+hit._source.mem_id)
			}
			var index = copyList.indexOf(hit);
			if (index !== -1) {
				console.log(copyList.splice(index, 1));
				cnt++;
			}
			$(".dropdown .dropdown-menu.total-search-dropdown").prepend(searchResult);
		}
		res.hits.hits = [...copyList]
	})
}

const searchResultLoopDelete = function(res, key, copyList){
	console.log(res.hits.hits)
	console.log(copyList)
	console.log(key)
	$.each(res.hits.hits, function(i, hit){
		console.log(i)
		console.log(key in hit["_source"])
		if(key in hit["_source"]){
			var index = copyList.indexOf(hit);
			if (index !== -1) {
				console.log(copyList.splice(index, 1));
			}
		}
		res.hits.hits = [...copyList]
	})
}
