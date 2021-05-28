<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link href="${cPath }/resources/assets/css/newmilestone.css" rel="stylesheet">
    	<div class="container"> 
	            <div class="row page-titles mx-0">
	                <div class="col p-md-0">
	                    <ol class="breadcrumb">
	                        <li class="breadcrumb-item"><a class="moveButton" href="#">${project_title }</a></li>
	                        <li class="breadcrumb-item active"><a href="javascript:void(0)">${menuname }</a></li>
	                    </ol>
	                </div>
	            </div>
	            <!-- row -->
			
   
            
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="newmilestonebox">
                                    <div class="compose-content mt-5">                                  
	                                    <div class="milestonehead">
											  <div class="milestonehead-heading">New milestone</div>
										  <div class="milestonehead-description">Create a new milestone to help organize your issues and pull requests.</div>
										</div>
                                        <form action="#">
                                            <div class="form-title-group">
                                            	<div class="input-label">
									           		<label for="milestone_title">Title</label>
									          	</div>
                                                	<input type="text" class="form-control bg-transparent" placeholder=" Title">
                                            </div>
                                            
											<div class="form-date-group row">
									  			<div class ="date-box">
									          		<div class="input-label">
									          			<label for="milestone_start_on">Start date (optional)</label>
									         		</div>
									      	 		<div>
									            		<input type="date" pattern="\d\d\d\d-\d\d-\d\d" placeholder="yyyy-mm-dd" class="form-control" id="milestone_due_on" name="milestone[due_on]">
									          		</div>
									          	</div>
									          	<div class ="date-box">
									          		<div class="input-label">
									          			<label for="milestone_due_on">Due date (optional)</label>
									         		</div>
									      	 		<div>
									            		<input type="date" pattern="\d\d\d\d-\d\d-\d\d" placeholder="yyyy-mm-dd" class="form-control" id="milestone_due_on" name="milestone[due_on]">
									            	</div>
									          	</div>
											</div>
                                            <div class="form-text-group">
                                            	<div class="input-label">
									          		<label for="milestone_description">Description</label>
									         	</div>
                                                <textarea class="textarea_editor form-control bg-light" rows="1" placeholder="Enter text"></textarea>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="button m-t-15">
                                        <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button"><i class="fa fa-check m-r-5"></i> create milestone</button>
                                        <button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button"><i class="ti-close m-r-5 f-s-12"></i> close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          </div>
            
            
          
		