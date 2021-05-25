<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* May 18, 2021   Eisen      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-end">
	<div class="col col-md-3">
		<ol class="breadcrumb">
		    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
		    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
		</ol>
	</div>
</div>
            <div class="card">
                <div class="card-body">
<div class="container-fluid">
                <div class="row">
                    <div class="basic-list-group col-dm-4"><a href="email-compose.html" class="btn btn-primary btn-block">Compose</a>
                        <div class="list-group">
                        	<a href="email-inbox.html" class="list-group-item text-primary p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>Inbox</b> <span class="badge badge-primary badge-sm float-right m-t-5">198</span> </a>
                            <a href="#" class="list-group-item p-r-0"><i class="fa fa-paper-plane font-18 align-middle mr-2"></i>Sent</a>  
                            <a href="#" class="list-group-item p-r-0"><i class="fa fa-star-o font-18 align-middle mr-2"></i>Important <span class="badge badge-danger badge-sm float-right m-t-5">47</span> </a>
                            <a href="#" class="list-group-item p-r-0"><i class="mdi mdi-file-document-box font-18 align-middle mr-2"></i>Draft</a>
                            <a href="#" class="list-group-item p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>Trash</a>
                        </div>
                        <div class="list-group">
                        	<a href="#" class="list-group-item "><span class="fa fa-briefcase f-s-14 mr-2"></span>Work</a>  
                        	<a href="#" class="list-group-item "><span class="fa fa-sellsy f-s-14 mr-2"></span>Private</a>  
                        	<a href="#" class="list-group-item "><span class="fa fa-ticket f-s-14 mr-2"></span>Support</a>  
                        	<a href="#" class="list-group-item "><span class="fa fa-tags f-s-14 mr-2"></span>Social</a>
                        </div>
                    </div>
                    <div class="col">
                        <div class="toolbar" role="toolbar">
                            <div class="btn-group m-b-20">
                                <button type="button" class="btn btn-light"><i class="fa fa-archive"></i>
                                </button>
                                <button type="button" class="btn btn-light"><i class="fa fa-exclamation-circle"></i>
                                </button>
                                <button type="button" class="btn btn-light"><i class="fa fa-trash"></i>
                                </button>
                            </div>
                            <div class="btn-group m-b-20">
                                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown"><i class="fa fa-folder"></i>  <b class="caret m-l-5"></b>
                                </button>
                                <div class="dropdown-menu"><a class="dropdown-item" href="javascript: void(0);">Social</a>  <a class="dropdown-item" href="javascript: void(0);">Promotions</a>  <a class="dropdown-item" href="javascript: void(0);">Updates</a> 
                                    <a class="dropdown-item" href="javascript: void(0);">Forums</a>
                                </div>
                            </div>
                            <div class="btn-group m-b-20">
                                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown"><i class="fa fa-tag"></i>  <b class="caret m-l-5"></b>
                                </button>
                                <div class="dropdown-menu"><a class="dropdown-item" href="javascript: void(0);">Updates</a>  <a class="dropdown-item" href="javascript: void(0);">Promotions</a> 
                                    <a class="dropdown-item" href="javascript: void(0);">Forums</a>
                                </div>
                            </div>
                            <div class="btn-group m-b-20">
                                <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">More <span class="caret m-l-5"></span>
                                </button>
                                <div class="dropdown-menu"><a class="dropdown-item" href="javascript: void(0);">Mark as Unread</a>  <a class="dropdown-item" href="javascript: void(0);">Add to Tasks</a>  <a class="dropdown-item"
                                    href="javascript: void(0);">Add Star</a>  <a class="dropdown-item" href="javascript: void(0);">Mute</a>
                                </div>
                            </div>
                        </div>
                        <div class="read-content">
                            <div class="media pt-5">
                                <img class="mr-3 rounded-circle" src="images/avatar/1.jpg">
                                <div class="media-body">
                                    <h5 class="m-b-3">Ingredia Nutrisha</h5>
                                    <p class="m-b-2">20 May 2018</p>
                                </div>
                                
                            </div>
                            <hr>
                            <div class="media mb-4 mt-1">
                                <div class="media-body"><span class="float-right">07:23 AM</span>
                                    <h4 class="m-0 text-primary">A collection of textile samples lay spread</h4><small class="text-muted">To:Me,invernessmckenzie@example.com</small>
                                </div>
                            </div>
                            <h5 class="m-b-15">Hi,Ingredia,</h5>
                            <p><strong>Ingredia Nutrisha,</strong> A collection of textile samples lay spread out on the table - Samsa was a travelling salesman - and above it there hung a picture</p>
                            <p>Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of
                                Grammar.
                            </p>
                            <p>Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.
                                Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero,
                                sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar,</p>
                            <h5 class="m-b-5 p-t-15">Kind Regards</h5>
                            <p>Mr Smith</p>
                            <hr>
                            <h6 class="p-t-15"><i class="fa fa-download mb-2"></i> Attachments <span>(3)</span></h6>
                            <div class="row m-b-30">
                                <div class="col-auto"><a href="#" class="text-muted">My-Photo.png</a>
                                </div>
                                <div class="col-auto"><a href="#" class="text-muted">My-File.docx</a>
                                </div>
                                <div class="col-auto"><a href="#" class="text-muted">My-Resume.pdf</a>
                                </div>
                            </div>
                            <hr>
                            <div class="form-group p-t-15">
                                <textarea class="w-100 p-20 l-border-1" name="" id="" cols="30" rows="5" placeholder="It's really an amazing.I want to know more about it..!"></textarea>
                            </div>
                        </div>
                        <div class="text-right">
                            <button class="btn btn-primaryw-md m-b-30" type="button">Send</button>
                        </div>
                    </div>
                   </div>
                </div>
            </div>
</div>
<!-- #/ container -->
</div>