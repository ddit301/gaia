<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
button.square__box{
	background-color:white; 
	border-radius: 0.4rem; 
	color:grey;
}
</style>
<div id="preloader">
</div>
    <!-- modal -->

    <div id="projCreateModal" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">프로젝트 생성</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    </button>
                </div>
<!--                 body -->
                    <div class="modal-body">
                        <div class="form-validation">
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="val-username">프로젝트 이름 
                                	<span class="text-danger">*</span>
                                </label>
                                <div class="col-lg-6">
                                    <input type="text" class="form-control" id="proj_title_input" name="val-username"
                                        placeholder="영어로만 적어주세요. 띄어쓰기 x">
                                </div>
                                <div class="col-lg-2">
                                	<i id="projTitleValidChecker"></i>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="val-suggestions">프로젝트 상세 설명 
                                	<span class="text-danger"></span>
                                </label>
                                <div class="col-lg-6">
                                    <textarea class="form-control" id="proj_cont_input" name="val-suggestions" rows="5"
                                        placeholder="만들고자 하는 프로젝트에 대한 설명을 적어주세요."></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
<!--                     footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                        <button id="createProjectBtn" type="button" class="btn btn-primary" disabled="disabled">생성</button>
                    </div>
            </div>
        </div>
    </div>

<div id="main-list">
	<div id="project__list">
<!-- 	프로젝트 목록 넣을 div -->
		<div class="proj_boxes">
		</div>
<!-- 	    프로젝트 생성 버튼 -->
	    <div class="square__box">
	        <div class="img-rounded">
	            <button type="button" class="btn btn-adder" data-toggle="modal"
	                data-target="#projCreateModal">+</button>
	        </div>
	    </div>
<!-- 	    프로젝트 생성 버튼 끝-->
	</div>
</div>


<div id="preloaderTemplate" hidden="hidden">
	<div class="projBox">
		<button class="projectBtn square__box" data-toggle="tooltip" data-html="true" data-placement="right">
	    </button>
	</div>
</div>
