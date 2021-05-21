<%--
* [[개정이력(Modification Information)]]
* Date         Modifier		Modification
* ----------  ---------  -----------------
* 17 May 2021   Shane      Initial Commit
* Copyright (c) 2021 by Team Gaia All right reserved
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<h4>milestone :  ${manager_nick } / ${project_title }</h4>
			</div>
	
			<div class="btn-body">
				<a href="#" class="label label-info" style="float: right; margin-right: 5px;">New issue</a>
				<a href="#"	class="label label-info" style="float: right; margin-right: 5px;">Edit milestone</a>
			</div>
			<br><br>
		
			<div id="milestone-list">
				
			</div>
			
			<script>
				$.ajax({
					url : '${cPath}/restapi/project/milestone',
					type : 'get',
					data : {
					},
					success : function(res) {
						$.each(res, function(i, v) {
							let milestone = 
							'<div class="table-list-cell milestone-title" style="background: white; padding: 10px; margin: 10px;">'
							+'	<div class="milestone-title" style="width: 50%; float: left; box-sizing: border-box">              '
							+'		<h2 class="milestone-title-link">                                                              '
							+'			<a class="moveButton" data-menu="milestoneview" href="#">'+v.milest_title+'</a>                                                         '
							+'		</h2>                                                                                          '
							+'	</div>                                                                                             '
							+'	<div class="milestone-bar" style="width: 50%; float: right; box-sizing: border-box">               '
							+'		<div class="progress mb-3" style="height: 7px">                                                '
							+'			<div class="progress-bar gradient-1" style="width: 80%;" role="progressbar"></div>         '
							+'		</div>                                                                                         '
							+'	</div>                                                                                             '
							+'	<br>                                                                                               '
							+'	<div class="mt-4">                                                                                 '
							+'		<div class="milestone-date">                                                                   '
							+'			<span class="milestone-start">'+v.milest_start_date+'</span>                               '
							+'			~                                                                                          '
							+'			<span class="milestone-end">'+v.milest_end_date+'</span>                                   '
							+'		</div>                                                                                         '
							+'		<div class="milestone-percent">                                                                '
							+'			<span class="pull-right">완성률 80%</span> <br>                                            '
							+'		</div>                                                                                         '
							+'	</div>                                                                                             '
							+'</div>                                                                                               '
							$('#milestone-list').append(milestone);                                                                                                       
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
			