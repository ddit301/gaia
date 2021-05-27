<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 19 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="${cPath }/resources/assets/css/news.css" rel="stylesheet">
    
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
                    </ol>
                </div>
            </div>

            <div class="container-fluid">
            	<div id="newsmenu" class="row">
            		<div class="col-md-10">
            		</div>
            		<div class="col-md-2">
	            		<button type="button" class="btn mb-1 btn-rounded btn-outline-dark">뉴스추가</button>
            		</div>
            	</div>
            	<div id="newsContainer">
            	</div>
            </div>

<div id="news-template" hidden="hidden" >

	<!-- news template start -->
	 	<div class="news">
       		<div class="newsheader row">
       			<div class="newsWriter col-md-2">
       				<img src="/gaia/resources/assets/images/user/1.png" alt="">
       				<span></span>
       			</div>
       			<div class="newsTitle col-md-6">
       				<p></p> 
       			</div>
       			<div class="newsTime col-md-3">
       				<span></span>
       			</div>
       			<div class="col-md-1">
       				<i class="icon-options menu-icon"></i>
       			</div>
       		</div>
       		<div class="newsBody row">
       			<div class="news-left col-md-6">
       				<img src="/gaia/resources/assets/images/big/about-2.png" alt="">
       			</div>
       			<div class="news-right col-md-6">

       				<div class="newsReplyArea">
       				</div>
      					<div class="news-writebox row">
      						<div class="col-md-10">
      							<input type="text">
      						</div>
      						<div class="col-md-2">
      							<button type="button" class="btn">등록</button>
      						</div>
      					</div>
       			</div>
       		</div>
       	</div>
	<!-- news template end -->

	<!-- news reply template start-->
	<div class="news-reply row">
		<div class="col-md-2">
			<div class="repwriter row">
				<img src="/gaia/resources/assets/images/user/1.png" alt="">
			</div>
			<span>Josh</span>
		</div>
		<div class="repcont col-md-10">
			<p>댓글 내용은 여기에 들어갑니다<br/>한줄 더 써봅니다.</p>
		</div>
	</div>
	<!-- news reply template end-->
	
</div>

            <script>
            	manager_nick = '${manager_nick }';
            	project_title = '${project_title }';
           	
	            $.ajax({
					url : '${cPath}/restapi/project/news',
					type : 'get',
					data : {
					},
					success : function(res) {
						$.each(res, function(i,v){
							let news = $('#news-template').children('.news').clone();
							
							news.find('.newsTitle').children('p').text(v.news_title);
							news.find('.newsWriter').children('span').text(v.writer.mem_nick);
							news.find('.newsTime').children('span').text(v.news_write_date);
							news.attr('data-news_sid',v.news_sid);
							
							let newsContent = '<div class="newsContent"><p>'+v.news_cont+'</p></div>';
							if(v.atch_file_sid!=null){
								news.find('.news-right').prepend(newsContent);
							}else{
								news.find('.news-left').html(newsContent);
							}
							
							$.each(v.commentList, function(j, comm){
								let newsComm = $('#news-template').children('.news-reply').clone();
								newsComm.children('.repcont').children('p').text(comm.news_com_cont);
								newsComm.find('span').text(comm.commenterNickname);
								newsComm.attr('data-com_no',comm.news_com_no);
								newsComm.attr('data-commenter_no',comm.commenterMemno);
								
								news.find('.newsReplyArea').append(newsComm);
							})
							
							$('#newsContainer').append(news);
						})
					},
					error : function(xhr, error, msg) {
						console.log(xhr);
						console.log(error);
						console.log(msg);
					},
					dataType : 'json'
				})
				
            </script>
            
            
            
            
            
            
            
            