<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container-fluid">
  <div class="row menu">
    <div class="col-lg-12 col-xl-12">
      <div class="row justify-content-end">
        <div class="col col-md-3">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a class="moveButton" data-menu="overview"
                href="javascript:void(0)">Member</a>
            </li>
            <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}"
                href="javascript:void(0)">${menuname}</a></li>
          </ol>
        </div>
      </div>
    </div>
    <div class="col-lg-4 col-xl-3">
      <div class="card">
        <div class="card-body">
          <div class="media align-items-center mb-4">
            <img class="mr-3 rounded-circle profile_img" height="80" width="80" src="${mem_pic_file_name}">
            <div class="media-body">
              <h3 class="m-b-3">${mem_id }</h3>
              <p class="text-muted mb-0">Deutch</p>
            </div>
          </div>
          <p class="color-text-tertiary">Your personal account</p>
          <div class="card">
            <div class="list-group mem-setting-side-bar">
              <span class="list-group-item menu-heading p-r-0">Account setting</span>
              <a href="javascript:void()" class="list-group-item text-primary p-r-0 moveButton" data-menu="setting">
                Profile</a>
              <a href="javascript:void()" class="list-group-item text-primary p-r-2 moveButton"
                data-menu="setting/account">Account</a>
              <a href="javascript:void()" class="list-group-item text-primary p-r-0 moveButton"
                data-menu="setting/securityLog">Security log</a>
              <a href="javascript:void()" class="list-group-item text-primary p-r-0 moveButton"
                data-menu="setting/help">Help</a>
            </div>
          </div>
        </div>
      </div>

    </div>
    <div class="col-lg-8 col-xl-9">
      <div class="card">
        <div class="card-body">
          <h4 class="card-title">Help - Inquiry</h4>
          <div class="form-validation">
            <form id="inquiryForm" class="form-valide" action="#" method="post">
              <div class="form-group row">
                <label class="col-lg-4 col-form-label" for="inq_sort">Sort <span class="text-danger">*</span>
                </label>
                <div class="col-lg-8">
                  <select class="form-control" id="inq_sort" name="inq_sort">
                    <option value="">Please select</option>
                    <option value="html">결제 오류</option>
                    <option value="css">버그</option>
                    <option value="javascript">운영 문의</option>
                  </select>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-lg-4 col-form-label" for="inq_date">Occurred Date</label>
                <div class="col-lg-8">
                  <input type="text" id="date-format" class="form-control " placeholder="">
                </div>
              </div>
              <div class="form-group row">
                <label class="col-lg-4 col-form-label" for="inq_title">Title <span class="text-danger">*</span>
                </label>
                <div class="col-lg-8">
                  <input type="text" class="form-control" id="inq_title" name="inq_title" placeholder="Title">
                </div>
              </div>
              <div class="form-group row">
                <label class="col-lg-4 col-form-label" for="inq_cont">Contents <span class="text-danger">*</span>
                </label>
                <div class="col-lg-8">
                  <textarea class="form-control" id="inq_cont" name="inq_cont" rows="5"
                    placeholder="Contents"></textarea>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-lg-4 col-form-label" for="atch_file_sid">Attachments
                </label>
                <div class="col-lg-8">
                  <div class="input-group">
                    <div class="custom-file">
                      <input type="file" class="custom-file-input" name="file1" id="file1">
                      <label class="form-control custom-file-label" for="file1">Choose file</label>
                    </div>
                    <div class="input-group-append">
                      <button class="btn btn-outline-gray adder" type="button">＋</button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-lg-4 col-form-label">답변 알림
                </label>
                <div class="col-lg-8">
                  <label class="css-control css-control-primary css-checkbox" for="val-terms">
                    <input type="checkbox" class="css-control-input" id="val-terms" name="val-terms" value="1"> <span
                      class="css-control-indicator"></span>
                    I agree to the terms</label>
                </div>
              </div>
              <div class="form-group row">
                <div class="col-lg-8 ml-auto">
                  <button type="submit" id="submitter" class="btn btn-primary">Submit</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="/gaia/resources/assets/plugins/clockpicker/dist/jquery-clockpicker.min.js"></script>
<script src="/gaia/resources/assets/plugins/jquery-asColorPicker-master/libs/jquery-asColor.js"></script>
<script src="/gaia/resources/assets/plugins/jquery-asColorPicker-master/libs/jquery-asGradient.js"></script>
<script src="/gaia/resources/assets/plugins/jquery-asColorPicker-master/dist/jquery-asColorPicker.min.js"></script>
<script src="/gaia/resources/assets/plugins/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/gaia/resources/assets/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="/gaia/resources/assets/js/plugins-init/form-pickers-init.js"></script>
<script>

  $(".list-group .mem-setting-side-bar .moveButton").on('click', function () {
    event.preventDefault();
    let menuName = $(this).data('menu');
    memberMovePageHistory(menuName);
  })

  loadMemberInfo_account();

  const dayName = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const monthName = ["January", "February", "March", "April", "May", "June",
	  "July", "August", "September", "October", "November", "December"
	];
  let today = new Date();

  let year = today.getFullYear();
  let month = monthName[today.getMonth()];
  let date = today.getDate();
  let day = dayName[today.getDay()];
  let hour = today.getHours();
  let min = today.getMinutes();

  let dayPlaceholder = day +' '+ date +' '+ month+ ' '+ year+ ' - '+ hour+ ':'+ min;
$('#date-format').attr('placeholder',dayPlaceholder);

  $(function () {
  
  	$(".form-group").on("change", "[type=file]",function () {
        var file = this.files[0].name;
        var dflt = $(this).attr("placeholder");
        if ($(this).val() != "") {
          $(this).next().text(file);
        } else {
          $(this).next().text(dflt);
        }
      });
    $(".form-group").on("click", ".adder", function () {
      let bt_class = $(this).attr("class"); //btn btn-outline-gray adder
      let input_id = Number($(this).parents(".input-group").find(".custom-file-input").attr("id").substring(4)) + 1 //1
      let code = '<div class="input-group"><div class="custom-file">'
        + '<input type="file" class="custom-file-input" name="file' + input_id + '" id="file' + input_id + '">'
        + '<label class="form-control custom-file-label" for="file' + input_id + '">Choose file</label>'
        + '</div><div class="input-group-append">'
        + '<button class="btn btn-outline-gray adder" type="button">＋</button>'
        + '</div></div>'
      $(this).html("－");
      $(this).attr("class", "btn btn-outline-gray deleter");
      $(".input-group").last().after(code);

      $(".deleter").on("click", function () {
        console.log("deleter", $(this).parents(".input-group"));
        $(this).parents(".input-group").remove();
      })

     
    })
    
    $("#submitter").on("click",function(e){
    	e.preventDefault();
    	let formContent = $("#inquiryForm");
    	thisFormSubmit(formContent);
    })

  })
  
  function thisFormSubmit(f) { 
	  /** * 입력 필드 validattion check 로직 */ 
	  /** * ajax로 다른 페이지를 처리 후에 결과가 성공일 때 전송 처리를 한다. */ 
	  // 전송 여부 boolean 값 
	  // 초기값은 false로 셋팅을 한다. 
	  var isSubmit = false; 
// 	  console.log(f.find('input'));
// 	  $.each(f.find('input'), function(index, item){
		  
// 		  console.log('inputs',index, item)
// 	  });

// 	  var inputId=$("input[name=id]").val();
// 	  let data = $('form').serialize();
	  let sort = '[' + $('#inq_sort').val() + ']';
	  let occur = $('#date-format').val();
	  let title = '[' + $('#inq_title').val() + ']';
	  let cont = $('#inq_cont').val();
// 	console.log(data); //inq_sort=&inq_title=title&inq_cont=contents
	console.log($('#inq_title'));
	console.log(sort + occur + title + cont);
	alert("stop");
// 	  $.ajax({ 
// 		  url:'[주소]', 
// 		  type:'post', 
// 		  data:$('form').serialize(), 
// 		  dataType:'json', 
// 		  // 다른 페이지를 처리 후에 결과가 성공일 때 
// 		  // 비동기식으로 처리를 함 
// 		  async: false, 
// 		  success:function(data) {
// 			  var message = data.message;
// 			  // 결과값이 성공이면 전송 여부는 
// 			  true if ( message == 'Success' ) { 
// 				  isSubmit = true; 
// 				  } else {
// 				  // 결과값이 실패이면 전송 여부는 false 
// 				  // 앞서 초기값을 false로 해 놓았지만 한번 더 선언을 한다. 
// 				  isSubmit = false; }
// 		  }, 
// 		  error:function(request, status, error) { 
// 			  // 오류가 발생했을 때 호출된다. 
// 			  console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
// 			  // ajax 처리가 결과가 에러이면 전송 여부는 false 
// 			  // 앞서 초기값을 false로 해 놓았지만 한번 더 선언을 한다. 
// 			  isSubmit = false; 
// 		  },
// 		  beforeSend:function() { 
// 			  // 로딩바를 보여준다. 
// 			  }, 
// 		  complete:function() { 
// 			  // 로딩바를 해제한다. 
// 			  } 
// 		  }); 
// 	  if ( !isSubmit ) return false;
	}

</script>