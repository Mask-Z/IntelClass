<%--
  Created by IntelliJ IDEA.
  User: Mr丶周
  Date: 2017/5/13
  Time: 0:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>签到信息</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
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
                    <%--<form class="form-inline" method="get" action="<%=request.getContextPath() %>/manager/getSignInNum">--%>
                    <%--<form class="form-inline" >--%>
                    <%--<input type="hidden" name="pagenum" value="${pagenum}">--%>
                    &nbsp;&nbsp;签到码：<input type="text" id="signInNum" class="input-medium search-query" readonly>&nbsp;&nbsp;&nbsp;&nbsp;
                    <button class="btn btn-purple btn-small" id="buttonsign" onclick="test()"
                            style="width: 108.25px;height: 32px">
                        生成签到码
                        <i class=" icon-refresh icon-on-right bigger-110"></i>
                    </button>
                    <%--</form>--%>

                    <!--PAGE CONTENT ENDS-->
                </div><!--/.span-->
            </div><!--/.row-fluid-->
        </div><!--/.page-content-->
    </div><!--/.main-content-->
</div><!--/.main-container-->

<%@include file="/WEB-INF/views/common/js.jsp" %>
<script>
    var path = "<%=request.getContextPath() %>";
    var c = 60;
    var t;
    var button = $("#buttonsign");
    function timedCount() {
        c = c - 1;
        button.html(c + "s");
        t = setTimeout("timedCount()", 1000);
        if (c === 0) {
            clearTimeout(t);
            button.removeAttr("disabled");
            button.html("生成签到码");
            c = 60;
        }
    }

    function test() {
        $.ajax({
            //提交数据的类型 POST GET
            type: "GET",
            //提交的网址
            url: path + "/manager/getOnlySignInNum",
            //提交的数据
            <%--data:{signInNum:"${signInNum}"},--%>
            //返回数据的格式
            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
            //在请求之前调用的函数
//           beforeSend:function(){alert(path);},
            //成功返回之后调用的函数
            success: function (data) {
                $("#signInNum").val(data);
                $("#buttonsign").attr({"disabled": "disabled"});
                timedCount();
            },
            //调用出错执行的函数
            error: function () {
                //请求出错处理
                alert("出错了");
            }
        });

    }
</script>
</body>
</html>
