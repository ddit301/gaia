<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="${cPath }/resources/assets/plugins/common/common.min.js"></script>
    <script src="${cPath }/resources/assets/js/custom.min.js"></script>
    <script src="${cPath }/resources/assets/js/settings.js"></script>
    <script src="${cPath }/resources/assets/js/gleek.js"></script>
    <script src="${cPath }/resources/assets/js/styleSwitcher.js"></script>
	<script src="${cPath }/resources/js/moment.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-material-datetimepicker/2.7.1/js/bootstrap-material-datetimepicker.min.js"></script>
	<script src="https://uicdn.toast.com/editor/2.0.0/toastui-editor-all.js"></script>	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="${cPath }/resources/js/jquery.serializejson.js"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="${cPath }/resources/js/jquery.validate.js"></script>
<!-- 	우클릭 지원을 위한 jquery contextMenu -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.2/jquery.contextMenu.js" integrity="sha512-2ABKLSEpFs5+UK1Ol+CgAVuqwBCHBA0Im0w4oRCflK/n8PUVbSv5IY7WrKIxMynss9EKLVOn1HZ8U/H2ckimWg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.9.2/jquery.ui.position.js" integrity="sha512-vBR2rismjmjzdH54bB2Gx+xSe/17U0iHpJ1gkyucuqlTeq+Q8zwL8aJDIfhQtnWMVbEKMzF00pmFjc9IPjzR7w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 	base 64 인코딩 /디코딩용 -->
	<script src="https://cdn.jsdelivr.net/npm/js-base64@3.6.1/base64.min.js"></script>
<!-- 	url에서 파일 다운받기 위한 라이브러리 -->
	<script src="${cPath }/resources/js/download.js"></script>
<!-- 	util.js 는 페이지별 js 보다 위에 위치해야 합니다. -->
	<script src="${cPath }/resources/js/util.js"></script>
<!-- 	각 페이지별로 필요한 js 파일 입니다.  -->
	<script src="${cPath }/resources/js/issue.js"></script>
	<script src="${cPath }/resources/js/milestone.js"></script>
	<script src="${cPath }/resources/js/wiki.js"></script>
	<script src="${cPath }/resources/js/alarm.js"></script>
	<script src="${cPath }/resources/js/project.js"></script>
	<script src="${cPath }/resources/js/websocket.js"></script>
	<script src="${cPath }/resources/js/member.js"></script>
	<script src="${cPath }/resources/js/code.js"></script>
	<script src="${cPath }/resources/assets/dist/jkanban.js"></script>  

<script type="text/javascript">
	let project_title = '${project_title}';
	let manager_id = '${manager_id}';
	let memberPageParam = '${memberPageParam}';
	let pageParam = '${pageParam}';
	let issue_no = '${issue_no}';
	let milest_no = '${milest_no}';
	
	// 접속 회원의 프로젝트 내 닉네임 및 정보들을 쿠키에서 받아 저장해 둡니다. 글 작성시 활용해주세요.
	let proj_user_nick = getProjNickFromCookie();
	
	// 일단 다른 페이지들에서 해당 변수 못쓰게 const 로 막고, 추후 프로필 데이터 변경 고려해 코드 완성 단계에 let 으로 풀겠습니다. 
	const mem_pic_file_name = getCookie('mem_pic_file_name');
	const mem_id = getCookie('mem_id');
	 	
 	/********************************************************************
 	*
	*	When document is ready
	*		문서가 준비되고 나서 호출되어야 하는 함수들은 아래 기재합니다.
	*	
	*********************************************************************/
	$(function(){
		// 우측 상단에 프로필 사진 넣기
		$('.user-img').children('img').attr('src', getProfilePath(mem_pic_file_name));
		
		// 처음 페이지 로드될때 알람 목록을 한번 불러옵니다.
		getAlarm();
		
		//소속된 프로젝트 목록도 불러와 왼쪽에 찍어줍니다.
		loadProjectList();
		
	})
	/********************************************************************
 	*
	*	END OF 'When document is ready '
	*	
	*********************************************************************/
</script>
    

