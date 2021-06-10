<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/wiki.css" rel="stylesheet">
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container">
            	<div class = "wiki-head row">
            		<div class = "title-wiki col-md-5">
            			<span></span>
            		</div> 
            		<div class = "col-md-1"></div>
            			<button type = "button" class="delete-wiki btn col-md-2 btn-sm btn-flat" data-toggle="modal" data-target="#basicModal">Delete</button>
            			<button type = "button" class="edit-wiki btn col-md-2 btn-sm btn-flat">Edit</button>
            			<button type = "button" class="new-wiki btn col-md-2 btn-sm btn-flat" data-toggle="modal" data-target="#wikiModal">New</button>
           			
           			
					<!--Delete Wiki Modal -->
           				<div class="bootstrap-modal">
		                    <div class="modal fade" id="basicModal" style="display: none;" aria-hidden="true">
		                        <div class="modal-dialog" role="document">
		                            <div class="modal-content">
		                                <div class="modal-header">
		                                    <h5 class="modal-title">Delete wiki</h5>
		                                    <button type="button" class="close" data-dismiss="modal"><span>×</span>
		                                    </button>
		                                </div>
		                                <div class="modal-body">
		                                	<div class = "wiki-title-modal">
		                                	[ <span></span> ] 을/를 삭제 하시겠습니까?
		                                	</div>
		                                </div>
		                                <div class="modal-footer">
		                                    <button type="button" class="btn btn-secondary " data-dismiss="modal">Close</button>
		                                    <button type="button" id = "delete-wiki-btn" class="btn btn-danger" data-dismiss="modal" >Delete wiki</button>
		                                </div>
		                            </div>
		                        </div>
		                    </div>
               			 </div>
           			
           			
           			<!-- new wiki modal -->
           			<div class="modal fade" id="wikiModal" tabindex="-1" aria-labelledby="wikiModal" aria-hidden="true">
					  <div class="modal-dialog modal-lg modal-dialog-scrollable" >
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title" id="wikiModal">wiki 추가</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">
					        <form>
					          <div class="form-group">
					            <label for="wiki-title-input" class="col-form-label">wiki 제목</label>
					            <input type="text" class="form-control" id="wiki-title-input">
					          </div>
					          <div id="editorArea" class="form-group">
					            <label class="col-form-label">wiki 내용</label>
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
					        <button id="saveWikiBtn" type="button" class="btn btn-success" disabled>Save</button>
					      </div>
					    </div>
					  </div>
					</div>
           			<div id="editor"></div>
    				
           			<div class = "wiki-writer">
           				<span></span>
           				open this page
           				<span></span>
           				 
           			</div>
            	</div>
            	<div class = "wiki-body row">
            		<div class = "wiki-content col-md-8">
            			<span></span>
            		</div>
            		<div class = "wiki-right row col-md-4">
            				
							<div id="wiki-list"></div>

            		</div>
            	</div>
            </div>
         
			<div id ="wiki-template" hidden = "hidden">
				<div class ="wikiBox">
					<div class ="row">
						<div class = "wiki-title">
							<input type = "hidden" value="" class = "wiki-link-no">
								<a class ="wiki-btn" href="javascript:void(0)"></a> 
						</div>
					</div>
				</div>
			</div>
            
            <script>
              var scopeWikiNo = '${wiki_no}';
            // project 내 첫번째 wiki 출력 
            	$.ajax({
            		url : getContextPath() + '/restapi/project/wikis/'
					,type : 'get'
					, data : {
					},
					success : function(res) {
						if(!!scopeWikiNo){
							$.each(res.dataList, function(i,v){
								if(v.wiki_no == '${wiki_no}'){
									$('.title-wiki').children('span').text(v.wiki_title);
								}
							})
						}else{ // requestScope에 wiki_no가 존재하지 않을 시 가장 처음 작성된 kiki를 불러옴.
							$('.title-wiki').children('span').text(res.dataList[0].wiki_title);
						}
						
							$('.wiki-writer').children('span:first').text(res.dataList[0].proj_user_nick);
							$('.wiki-writer').children('span:last').text(moment(res.dataList[0].wiki_write_date).fromNow());
							$('.wiki-content').children('span').text(res.dataList[0].wiki_cont);
							
							$('#wiki-list').empty();
							
							$.each(res.dataList, function(i,v){
								
								let wikiBox = $('#wiki-template').children('.wikiBox').clone();
								wikiBox.attr('data-wiki_no',v.wiki_no);
								wikiBox.find('.wiki-title').children('a').text(v.wiki_title);
								wikiBox.find('.wiki-title').children('input').val(v.wiki_no);
								
								$('#wiki-list').append(wikiBox);
							})
					},
					error : function(xhr, error, msg) {
						// 조회중인 프로젝트 번호를 세션에서 못 받아 올 경우, 메인 홈페이지로 보낸다.
						if(xhr.status == 400){
							window.location.href = getContextPath();
						}
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'

				})
				
				// wiki edit
				$(function(){
		
			// toastUI 설정 초기화
			 editor = new toastui.Editor({
				  el: document.querySelector('#editor'),
				  height: '400px',
				  initialEditType: 'markdown',
				  previewStyle: 'tab',
				  placeholder : 'markdown 문법을 지원합니다'
			});
			 
// 			viewer = toastui.Editor.factory({
// 		         el: document.querySelector('.newsContent')
// 		         ,height : 'auto'
// 		         ,viewer : true
// 		       });
			
			// 위키 글 작성할때 제목, 내용 둘다 있는지 확인	
			var checkValidation = function(){
				let titleLength = $('#wiki-title-input').val().length;
				let contLength = editor.getMarkdown().length;
				if( titleLength * contLength > 0 ){
					$('#saveWikiBtn').prop('disabled', false);
				}else{
					$('#saveWikiBtn').prop('disabled', true);
				}
			}	
			
			// 에디터를 modal 안에서 생성했더니 에러가 발생해서 modal 밖에서 생성 후 modal 에 넣어줍니다.
			$('#editor').appendTo('#editorArea');
			
			$('#saveWikiBtn').on('click', function(){
				wiki_title = $('#wiki-title-input').val();
				wiki_cont = editor.getMarkdown();
				// 위키 insert 하기
				$.ajax({
					url : getContextPath()+'/restapi/project/wikis',
					method : 'post',
					data : {
						'wiki_title' : wiki_title
						,'wiki_cont' : wiki_cont
						
					},
					success : function(res) {
						
						console.log(res.wiki.wiki_no);
						// toastr 알람
						toastr.success('새로운 위키 등록에 성공했습니다.')
						
						wikiView(res.wiki.wiki_no);
						
						// 에디터 비우기
						$('#wiki-title-input').val('');
						editor.reset();
						// 모달 닫기
						$('#wikiModal').modal('hide');
						
// 						// 비동기로 새로운 뉴스 생성해 위에 붙여주기
// 						let news = getNewsObectWithJson(res.news);
// 						$('#newsContainer').prepend(news);
						
					},
					error : function(xhr, error, msg) {
						ajaxError(xhr, error, msg);
					},
					dataType : 'json'
				})
				
			})
			
			// title과 editor의 내용이 있을 때만 save 버튼 활성화
			editor.on('change', function(){
				checkValidation();
			});
			$('#wiki-title-input').on('input', function(){
				checkValidation();
			});
			
				})
			
            </script>
