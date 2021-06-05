<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 12 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/tlds/myFunctions.tld" prefix="my"%>
<div id="preloader">
    <div class="loader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
        </svg>
    </div>
</div>
    <!-- modal -->

    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">New Project</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                    </button>
                </div>
                <form class="form-valide" action="#" method="post">
                    <div class="modal-body">


                        <div class="form-validation">
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="val-username">Project Name <span
                                        class="text-danger">*</span>
                                </label>
                                <div class="col-lg-6">
                                    <input type="text" class="form-control" id="val-username" name="val-username"
                                        placeholder="Enter a Project name">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="val-suggestions">Project Detail <span
                                        class="text-danger">*</span>
                                </label>
                                <div class="col-lg-6">
                                    <textarea class="form-control" id="val-suggestions" name="val-suggestions" rows="5"
                                        placeholder="What would you like to see?"></textarea>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label" for="val-skill">Best Skill <span
                                        class="text-danger">*</span>
                                </label>
                                <div class="col-lg-6">
                                    <select class="form-control" id="val-skill" name="val-skill">
                                        <option value="">Please select</option>
                                        <option value="html">HTML</option>
                                        <option value="css">CSS</option>
                                        <option value="javascript">JavaScript</option>
                                        <option value="angular">Angular</option>
                                        <option value="angular">React</option>
                                        <option value="vuejs">Vue.js</option>
                                        <option value="ruby">Ruby</option>
                                        <option value="php">PHP</option>
                                        <option value="asp">ASP.NET</option>
                                        <option value="python">Python</option>
                                        <option value="mysql">MySQL</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-lg-4 col-form-label"><a href="#">Module set</a> <span
                                        class="text-danger">*</span>
                                </label>
                                <div class="col-lg-8">
                                    <label class="css-control css-control-primary css-checkbox" for="val-Kanban">
                                        <input type="checkbox" class="css-control-input" id="val-Kanban" name="val-Kanban"
                                            value="1"> <span class="css-control-indicator"></span> Kanban</label>
                                    <label class="css-control css-control-primary css-checkbox" for="val-News">
                                    <input type="checkbox" class="css-control-input" id="val-News" name="val-News"
                                        value="1"> <span class="css-control-indicator"></span> News</label>
                                    <label class="css-control css-control-primary css-checkbox" for="val-Wiki">
                                    <input type="checkbox" class="css-control-input" id="val-Wiki" name="val-Wiki"
                                        value="1"> <span class="css-control-indicator"></span> Wiki</label>
                                </div>
                            </div>
                        </div>

                    </div>


                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Discard</button>
                        <button type="submit" class="btn btn-primary">Launch</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

<div id="main-list">
	<div id="project__list">
	<c:if test="${not empty member.projectList }">
		<c:forEach items="${member.projectList }" var="project">
		<c:set var = "title" value = "${my:initializeName(project.proj_title)}" />
		<div class="square__box img-rounded">
	  			${title }
	    </div>
			
		</c:forEach>
	</c:if>
    
    <div class="square__box">
        <div class="img-rounded">
            <button type="button" class="btn btn-adder" data-toggle="modal"
                data-target=".bd-example-modal-lg">+</button>
        </div>
    </div>
</div>
</div>

