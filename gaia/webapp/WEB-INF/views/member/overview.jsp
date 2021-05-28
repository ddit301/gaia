<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row justify-content-end">
	<div class="col col-md-3">
		<ol class="breadcrumb">
		    <li class="breadcrumb-item"><a class="moveButton" data-menu="overview" href="javascript:void(0)">Member</a></li>
		    <li class="breadcrumb-item active"><a class="moveButton" data-menu="${menuname}" href="javascript:void(0)">${menuname}</a></li>
		</ol>
	</div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-xl-3">
            <div class="card"> 
                <div class="card-body">
                <div class="card">
	                <form action="#" class="form-profile">
	                	<div class="form-group">
	                    	<ul>
                    			<li id="projectList" hidden="hidden">
                    				<strong class="text-dark mr-4">
                    					<i class="fa fa-check text-info"></i>
                    				</strong>
                    				<a href="javascript:void(0)">project list1</a>
                    			</li>
	                    	</ul>
	                    </div>
                    </form>
	            </div>
                    <div class="media align-items-center mb-4">
                        <img class="mr-3" src="${cPath}/resources/assets/images/member/profile.png" width="80" height="80" alt="">
                        <div class="media-body">
                            <h3 class="mb-0">${mem_nick }</h3>
                            <p class="text-muted mb-0">Deutch</p>
                        </div>
                    </div>
                    <h4>About Me</h4>
                    <p class="text-muted" id="mem_bio">${model.mem_bio }</p>
                    <ul class="card-profile__info">
                        <li class="mb-1"><strong class="text-dark mr-4"><i class="fa fa-star gradient-1-text"></i></strong> <span>ddit301</span></li>
                        <li><strong class="text-dark mr-4"><i class="mdi mdi-email-outline"></i></strong> <span>name@domain.com</span></li>
                    </ul>
                    <div class="d-flex align-items-center">
                        <ul class="mb-0 form-profile__icons">
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-user"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-paper-plane"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-camera"></i></button>
                            </li>
                            <li class="d-inline-block">
                                <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-smile"></i></button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>  
        </div>
		<div class="col-lg-8 col-xl-9">
			<div class="card">
		    	<div class="container-fluid">
			        <div class="row">
			            <div class="col">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">by ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
			            <div class="col">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">by ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
			        </div>
				    <div class="row">
				        <div class="col">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">by ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
				        <div class="col">
			                <div class="card">
			                    <div class="card-body">
				                    <div>
				                    	<div>
					                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue </h5>
				                       	</div> 
				                        <div class="row">
				                        	<div class="col-md-7">
						                        <small class="text-muted">about 3 days ago</small>
				                        	</div>
				                        	<div class="col-md-5 media-reply__link">
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
					                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
					                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold"><small>by</small> ${mem_nick }</button>
				                        	</div>
				                        </div>
				                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Asperiores repellendus molestiae exercitationem voluptatem tempora quo dolore nostrum dolor consequuntur itaque, alias fugit. Architecto rerum animi velit, beatae corrupti quos nam saepe asperiores aliquid quae culpa ea reiciendis ipsam numquam laborum aperiam. Id tempore consequuntur velit vitae corporis, aspernatur praesentium ratione!</p>
				                    </div>
			                	</div>
			                </div>
			            </div>
				    </div>
			    </div>
            </div> <!-- End first card -->
            
            <div class="card">
	            <div class="media media-reply">
	            	<div class="col-md-1">
		                <img class="mr-3 circle-rounded" src="${cPath}/resources/assets/images/avatar/2.jpg" width="50" height="50" alt="Generic placeholder image">
	            	</div>
	            	<div class="col-md-11">
		                <div class="media-body">
		                    <div class="d-sm-flex justify-content-between mb-2">
		                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue <small class="text-muted ml-3">about 3 days ago</small></h5>
		                        <div class="media-reply__link">
		                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
		                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
		                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">Reply</button>
		                        </div>
		                    </div>
		                    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
		                </div>
	            	</div>
	            </div>
	             <!-- first issue end -->
	            <div class="media media-reply">
	            	<div class="col-md-1">
		                <img class="mr-3 circle-rounded" src="${cPath}/resources/assets/images/avatar/2.jpg" width="50" height="50" alt="Generic placeholder image">
	            	</div>
	            	<div class="col-md-11">
		                <div class="media-body">
		                    <div class="d-sm-flex justify-content-between mb-2">
		                        <h5 class="mb-sm-0">Gaia > Project > MileStone > Issue <small class="text-muted ml-3">about 3 days ago</small></h5>
		                        <div class="media-reply__link">
		                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-up"></i></button>
		                            <button class="btn btn-transparent p-0 mr-3"><i class="fa fa-thumbs-down"></i></button>
		                            <button class="btn btn-transparent p-0 ml-3 font-weight-bold">Reply</button>
		                        </div>
		                    </div>
		                    <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.</p>
		                </div>
	            	</div>
	            </div>
           </div>
        </div>
    </div>
</div>
