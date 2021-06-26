//////////////////////////////////////////////////////////////////////////////
//
//	 각종 설정
//
//////////////////////////////////////////////////////////////////////////////


$(function(){
	$('body').on('click', '.searchedMem', function(){
		let mem_no = $(this).data('mem_no');
		loadPersonalPage(mem_no);
	})
})

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
		timer = setTimeout("elasticTotalSearch('"+keyword+"')", 200)
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
			
			// issue_history 거르기.
			searchResultLoopDelete(res, "issue_his_no",copyList);
			
			// issue > milestone > news > proj > mem 순서로 걸러야 함.
			if(res.hits.hits.length != 0){
				
				searchResultLoop(res, "kb_card_no",copyList);
				searchResultLoop(res, "issue_sid",copyList);
				searchResultLoop(res, "milest_sid",copyList);
				searchResultLoop(res, "news_sid",copyList);
				searchResultLoop(res, "wiki_sid",copyList);
				searchResultLoop(res, "proj_no",copyList);
				searchResultLoop(res, "mem_no",copyList);
			}
			// 검색 결과가 존재하지 않을 경우 검색결과가 없습니다 출력하기.
			dropdown_isEmpty =$(".dropdown .dropdown-menu.total-search-dropdown").find("a").text();
			console.log(CheckNullUndefined(dropdown_isEmpty))
			if(res.hits.hits.length == 0 && CheckNullUndefined(dropdown_isEmpty) ){
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
	existH6 = false;
	cnt = 0;
	$.each(res.hits.hits, function(i, hit){
		
		if(key in hit["_source"]){
			searchResult = $("#headerTemplate .dropdown-menu.total-search-dropdown").children("div").clone()
			
			if(key == "kb_card_no"){
				if(!existH6){
					checkdropdonwh6(searchResult, "Kanban", "icon-cursor-move")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.kb_card_cont)
				
			}else if(key == "issue_sid"){
				if(!existH6){
					checkdropdonwh6(searchResult, "Issue", "icon-fire")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.issue_title)
			}else if(key == "milest_sid"){
				if(!existH6){
					checkdropdonwh6(searchResult, "Milestone", "icon-direction")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.milest_title)
			}else if(key == "news_sid"){
				if(!existH6){
					checkdropdonwh6(searchResult, "News", "icon-book-open")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.news_title)
			}else if(key == "wiki_sid"){
				if(!existH6){
					checkdropdonwh6(searchResult, "Wiki", "icon-graduation")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.wiki_title)
			}else if(key == "proj_no"){
				if(!existH6){
					checkdropdonwh6(searchResult, "Project", "icon-doc")
					existH6 = true
				}
				searchResult.children("a").html(hit._source.proj_title)
			}else if(key == "mem_no"){
				profileImg = '<img class="profile searchProfile mr-3" onerror="imgOnErr()" height="40" width="40" src="'+getProfilePath(hit._source.mem_pic_file_name)+'">'
				if(!existH6){
					checkdropdonwh6(searchResult, "Member", "icon-user")
					existH6 = true
				}
				bar = '<span class="vertical-separator"></span>'
				
				city = CheckNullUndefined(hit._source.mem_working_city) ? "" : hit._source.mem_working_city;
						
				searchResult.children("a").removeClass("pl-5").addClass("pl-4").addClass('searchedMem').attr('data-mem_no',hit._source.mem_no).html(profileImg + hit._source.mem_nick+bar+city)
			}
			var index = copyList.indexOf(hit);
			if (index !== -1) {
				console.log(copyList.splice(index, 1));
			}
			$(".dropdown .dropdown-menu.total-search-dropdown").append(searchResult);
		}
		
		res.hits.hits = [...copyList]
	})
}
// 한번 돌때마다 해당되는 데이터가 있다면 리스트에 해당 데이터 삭제하기 
const searchResultLoopDelete = function(res, key, copyList){
	$.each(res.hits.hits, function(i, hit){
		if(key in hit["_source"]){
			var index = copyList.indexOf(hit);
			if (index !== -1) {
				console.log(copyList.splice(index, 1));
			}
		}
		res.hits.hits = [...copyList]
	})
}
// 메뉴 출력하기 kanban, menu...
const checkdropdonwh6 = function(searchResult, key, icon){
	console.log("in")
	console.log(CheckNullUndefined(searchResult.children("h6")))
	if(CheckNullUndefined(searchResult.children("h6").text())){
	console.log("in2")
		drop_down_h6 = '<h6 class="dropdown-header"><i class="'+icon+' pr-2"></i>'+key+'</h6>'
		searchResult.prepend(drop_down_h6)
	}
}

