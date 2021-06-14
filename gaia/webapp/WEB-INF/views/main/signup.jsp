<!--  [[개정이력(Modification Information)]]				-->
<!--  Date         Modifier		Modification			-->
<!--  ===========  ========     =============			-->
<!--  2021. 5. 13.  Robin		Initial Commit			-->
<!--  Copyright (c) 2021 by Team SEED All right reserved-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <div class="main">
        <section class="module bg-dark-30" data-background="resources/main/images/section-4.jpg">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h1 class="module-title font-alt mb-0">Login-Register</h1>
              </div>
            </div>
          </div>
        </section>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3 mb-sm-40">
                <h4 class="font-alt">Register</h4>
                <hr class="divider-w mb-10">
                <form class="form" method="post" action="${pageContext.request.contextPath }/signup/register">
                  <div class="form-group">
                    <input class="form-control" id="E-mail" type="text" name="mem_id" placeholder="Id"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="username" type="text" name="mem_nick" placeholder="Full Name"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="password" type="password" name="mem_pass" placeholder="Password"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="re-password" type="password" name="re_pass" placeholder="Re-enter Password"/>
                  </div>
                  <div class="form-group">
                    <button type="submit" class="btn btn-block btn-round btn-b">Register</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
       </div>
  