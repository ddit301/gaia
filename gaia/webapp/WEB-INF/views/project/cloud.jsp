<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 27.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${cPath }/resources/assets/plugins/nestable/css/nestable.css" rel="stylesheet">
        <!--**********************************
            Content body start
        ***********************************-->


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
            
    <script src="${cPath }/resources/assets/plugins/nestable/js/jquery.nestable.js"></script>
    <script src="${cPath }/resources/assets/plugins/nestable/js/nestable.init.js"></script>

        <script>
            (function($) {
            "use strict"
    
                new quixSettings({
                    version: "light", //2 options "light" and "dark"
                    layout: "vertical", //2 options, "vertical" and "horizontal"
                    navheaderBg: "color_1", //have 10 options, "color_1" to "color_10"
                    headerBg: "color_1", //have 10 options, "color_1" to "color_10"
                    sidebarStyle: "full", //defines how sidebar should look like, options are: "full", "compact", "mini" and "overlay". If layout is "horizontal", sidebarStyle won't take "overlay" argument anymore, this will turn into "full" automatically!
                    sidebarBg: "color_1", //have 10 options, "color_1" to "color_10"
                    sidebarPosition: "fixed", //have two options, "static" and "fixed"
                    headerPosition: "fixed", //have two options, "static" and "fixed"
                    containerLayout: "wide",  //"boxed" and  "wide". If layout "vertical" and containerLayout "boxed", sidebarStyle will automatically turn into "overlay".
                    direction: "ltr" //"ltr" = Left to Right; "rtl" = Right to Left
                });
    
    
            })(jQuery);
     </script>