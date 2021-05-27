<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 27.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <!--**********************************
            Content body start
        ***********************************-->

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
                    <div class="col-lg-3">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Nestedable</h4>
                                <div class="card-content">
                                    <div class="nestable">
                                        <div class="dd" id="nestable">
                                            <ol class="dd-list">
                                                <li class="dd-item" data-id="1">
                                                    <div class="dd-handle">Item 1</div>
                                                </li>
                                                <li class="dd-item" data-id="2">
                                                    <div class="dd-handle">Item 2</div>
                                                    <ol class="dd-list">
                                                        <li class="dd-item" data-id="3">
                                                            <div class="dd-handle">Item 3</div>
                                                        </li>
                                                        <li class="dd-item" data-id="4">
                                                            <div class="dd-handle">Item 4</div>
                                                        </li>
                                                        <li class="dd-item" data-id="5">
                                                            <div class="dd-handle">Item 5</div>
                                                            <ol class="dd-list">
                                                                <li class="dd-item" data-id="6">
                                                                    <div class="dd-handle">Item 6</div>
                                                                </li>
                                                                <li class="dd-item" data-id="7">
                                                                    <div class="dd-handle">Item 7</div>
                                                                </li>
                                                                <li class="dd-item" data-id="8">
                                                                    <div class="dd-handle">Item 8</div>
                                                                </li>
                                                            </ol>
                                                        </li>
                                                        <li class="dd-item" data-id="9">
                                                            <div class="dd-handle">Item 9</div>
                                                        </li>
                                                        <li class="dd-item" data-id="10">
                                                            <div class="dd-handle">Item 10</div>
                                                        </li>
                                                    </ol>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
	                    <div class="card">
                            <div class="card-body">
                            	 <h4 class="card-title">Nestedable</h4>
                                <div class="card-content">
                                content
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Nestedable</h4>
                                <div class="card-content">
                                    <div class="nestable">
                                        <div class="dd" id="nestable2">
                                            <ol class="dd-list">
                                                <li class="dd-item" data-id="13">
                                                    <div class="dd-handle">Item 13</div>
                                                </li>
                                                <li class="dd-item" data-id="13">
                                                    <div class="dd-handle">Item 13</div>
                                                </li>
                                                <li class="dd-item" data-id="14">
                                                    <div class="dd-handle">Item 14</div>
                                                </li>
                                                <li class="dd-item" data-id="15">
                                                    <div class="dd-handle">Item 15</div>
                                                    <ol class="dd-list">
                                                        <li class="dd-item" data-id="16">
                                                            <div class="dd-handle">Item 16</div>
                                                        </li>
                                                        <li class="dd-item" data-id="17">
                                                            <div class="dd-handle">Item 17</div>
                                                        </li>
                                                        <li class="dd-item" data-id="18">
                                                            <div class="dd-handle">Item 18</div>
                                                        </li>
                                                        <li class="dd-item" data-id="18">
                                                            <div class="dd-handle">Item 19</div>
                                                        </li>
                                                        <li class="dd-item" data-id="18">
                                                            <div class="dd-handle">Item 20</div>
                                                        </li>
                                                        <li class="dd-item" data-id="18">
                                                            <div class="dd-handle">Item 21</div>
                                                        </li>
                                                    </ol>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Nestedable</h4>
                                <div class="card-content">
                                    <div class="nestable">
                                        <div class="dd" id="nestable3">
                                            <ol class="dd-list">
                                                <li class="dd-item dd3-item" data-id="13">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 13</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="14">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 14</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="14">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 16</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="14">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 17</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="14">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 18</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="14">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 19</div>
                                                </li>
                                                <li class="dd-item dd3-item" data-id="15">
                                                    <div class="dd-handle dd3-handle"></div>
                                                    <div class="dd3-content">Item 15</div>
                                                    <ol class="dd-list">
                                                        <li class="dd-item dd3-item" data-id="16">
                                                            <div class="dd-handle dd3-handle"></div>
                                                            <div class="dd3-content">Item 16</div>
                                                        </li>
                                                        <li class="dd-item dd3-item" data-id="17">
                                                            <div class="dd-handle dd3-handle"></div>
                                                            <div class="dd3-content">Item 17</div>
                                                        </li>
                                                        <li class="dd-item dd3-item" data-id="18">
                                                            <div class="dd-handle dd3-handle"></div>
                                                            <div class="dd3-content">Item 18</div>
                                                        </li>
                                                    </ol>
                                                </li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #/ container -->
        <!--**********************************
            Content body end
        ***********************************-->
        
        
        <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->
