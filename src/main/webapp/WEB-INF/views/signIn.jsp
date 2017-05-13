<%--
  Created by IntelliJ IDEA.
  User: Mr丶周
  Date: 2017/5/13
  Time: 0:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>签到信息</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%@include file="/WEB-INF/views/common/css.jsp" %>
</head>

<body>
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>
<div class="main-container container-fluid">
    <a class="menu-toggler" id="menu-toggler" href="#">
        <span class="menu-text"></span>
    </a>
    <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
    <div class="main-content">

        <div class="page-content">
            <div class="page-header position-relative">
                <h1>
                    <small>
                        <i class="icon-tag "></i>
                        签到信息
                    </small>
                </h1>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <!--PAGE CONTENT BEGINS-->
                    <form class="form-inline" method="get" action="<%=request.getContextPath() %>/manager/getSignInNum">
                        <input type="hidden" name="pagenum" value="${pagenum}">
                        &nbsp;&nbsp;签到码：<input type="text" name="signInNum" value="${signnum}"  class="input-medium search-query" readonly>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button  type="submit" class="btn btn-purple btn-small" id="buttonsign">
                            生成签到码
                            <i class=" icon-refresh icon-on-right bigger-110"></i>
                        </button>
                        <%--<a href="#myModal"  role="button"  class="btn btn-purple btn-small" data-toggle="modal"><i class="icon-plus-sign icon-on-right bigger-110"></i>添加考试</a>--%>

                    </form>
                    <%--<div class="page-header position-relative">--%>
                       <%--<h5>--%>
                            <%--<small>  &nbsp; &nbsp;&nbsp;&nbsp;--%>
                                <%--<i class="icon-user "></i>--%>
                                <%--学生签到情况--%>
                            <%--</small>--%>
                        <%--</h5>--%>
                    <%--</div>--%>

                    <!--PAGE CONTENT ENDS-->
                </div><!--/.span-->
            </div><!--/.row-fluid-->
        </div><!--/.page-content-->
    </div><!--/.main-content-->
</div><!--/.main-container-->

<%@include file="/WEB-INF/views/common/js.jsp" %>
<%--<script type="application/javascript">--%>

<%--//    $("#buttonsign").bind(click,function () {--%>
<%--//        console.log("我进来了");--%>
<%--//        alert(this.class);--%>
<%--//    })--%>
<%--&lt;%&ndash;var num="${signnum}";&ndash;%&gt;--%>
  <%--&lt;%&ndash;console.log(num);&ndash;%&gt;--%>
<%--</script>--%>
</body>
</html>
