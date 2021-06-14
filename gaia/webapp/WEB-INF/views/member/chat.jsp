<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* Jun 8, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card chatRoomList-over side-position-fixed"> 
                <div class="card-body" id="chatRoomList">
                   	
                </div>
            </div>  
        </div>
		<div class="col-lg-8 col-xl-9">
			<div class="row justify-content-end">
				<div class="col col-md-3">
					<ol class="breadcrumb">
					    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
					    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
					</ol>
				</div>
			</div>
 <div class="cen chat" id="wrap">
            <div id="chatLeft">
                <div id="chatSearch">
                    <form onsubmit="chatSearch()" method="get" style="width: 80%!important; display: inline-block;">
                        <input type="text" name="chatSearchBox" placeholder="search"/>
                        <button type="submit" name="search">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                    <button type="button" id="createChat">
                        <i class="fas fa-comment-medical"></i>
                    </button>
                </div>
                <div id="chatList" class="scrollStyle">
                </div>
            </div>
            
            <div id="chatRight">
               <!--채팅방 처음 들어왔을때 또는 채팅방이 하나도 없을때 노출되는 div-->
                <!--<div id="chatStart">
                    <img src="images/message.png" />
                    <p>친구에게 메시지를 보내보세요.</p>
                </div>-->
                
                <!---->
                <div id="chatTop">
                    <a href="#" id="curChatPic" style="background-image: url(images/profile/default.png);"></a>
                    <div id="curChatInfo">
                        <h4>scarlett<span>풀스택 개발과정 6기</span></h4>
                    </div>
                    <div id="curChatBtn">
                        <i class="fas fa-ellipsis-v"></i>  
                    </div>
                    <div id="chatBack"></div>
                    <div id="chatUserBox" class="scrollNone">
                        <h3>
                            대화상대
                            <button><i class="fas fa-sign-out-alt"></i></button>
                        </h3>
                        <div id="chatUser">
                            <a href="#" id="chatUserPic" style="background-image: url(images/profile/expedition1205@gmail.com.jpg)"></a>
                            <a href="#" id="chatUserName">scarlett</a>
                            <p id="chatUserMail">chdnjs7610@gmail.com</p>
                            <div id="bar"></div>
                            <p id="chatUserIntro">
                                자기소개가 들어갑니다..자기소개 작성중.... 자기소개..자기소개..
                            </p>
                        </div>
                    </div>
                </div>
                <div id="curChatBox" class="scrollStyle">
                </div>

                <div id="commentInputBox">
                    <div class = "row">
                        <div class = "col-lg-2">
                      </div>
                      <div id="input_area" contenteditable="true" class="scrollStyle"></div>
                      <button type="button" id="commentSend"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
        
        <!--방나가기-->
        <div id="outWrap">
            <div id="outModal">
                <p id="outTxt">
                    방을 나가면 대화 내용도 삭제됩니다.<br/>
                    정말 방을 나가시겠습니까?
                </p>

                <div id="outBtn">
                    <button type="button" id="out">방 나가기</button>
                    <button type="button" id="cancel">취소</button>
                </div>
            </div>
        </div>
        
        <!--create a chat room-->
        <div id="createBack">
            <div id="createModal">
                <div class="closeBox">
                    <button type="button" class="close" style="color : #a0a0cf;">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <h5>Create a chat room</h5>
                <form onsubmit="createChat()" method="get">
                    <input type="text" name="searchBox" placeholder="대화상대 검색"/>
                    <button type="submit" name="userSearch">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
                <ul id="userList" class="scrollStyle">
                </ul>
            </div>
        </div>
        <!--컨텐츠 끝-->
        
        <script>
            $("#createChat").click(function(){
                $('body').addClass('scrollOff').on('scroll touchmove mousewheel', function(e){
                    e.preventDefault();
                });
                $("#createBack").fadeIn(200);
                $("#createModal").delay(200).animate({marginTop : "0"},400);
            });
            
            $(".close").click(function(){
                $('body').removeClass('scrollOff').off('scroll touchmove mousewheel');
                $("#createModal").animate({marginTop : "100px"},400);
                $("#createBack").delay(200).fadeOut(200);
            });
        </script>
			            
		            </div>
		        </div>
		    </div>
		</div>
    </div>
</div>
<div id="chatRoomTemplate" hidden="hidden">
	<ul class="chatRoom">
		<div class="card">
			<div class="row chatList-card-body">
			
				<div class="col-md-5 log-img-center chat-img">
					<img class="rounded-circle profile_img img-center pro_img" height="50" width="50" src="">
					<img class="rounded-circle profile_img img-left pro_img" height="50" width="50" src="">
					<img class="rounded-circle profile_img img-right pro_img" height="50" width="50" src="">
			   	</div>
		   	 	<div class="col-md-7 pr-0">
			        <div class="log-card-actor">
		            	<a class="font-bold-black">KrGil</a>
		         	</div>
		         	<div class="content">
		         		<span>hello!! my name...</span>
		         	</div>
		         	<div class="time">
		         		<span>28 days ago</span>
		         	</div>
		      	</div>
		   	</div>
		</div>
	</ul>
</div>
<script>
loadMemberInfo_chat();
</script>