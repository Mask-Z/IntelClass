<%--
  Created by IntelliJ IDEA.
  User: Mr丶周
  Date: 2017/5/13
  Time: 23:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>签到学生列表</title>
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
                        <i class="icon-user"></i>
                        签到学生列表
                    </small>
                </h1>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <!--PAGE CONTENT BEGINS-->
                    <form class="form-inline" method="get" action="<%=request.getContextPath() %>/manager/signInStudents">
                        <%--<input type="hidden" name="pagenum" value="${pagenum}">--%>
                        &nbsp;&nbsp;签到码：<input type="text" name="signnumkey" value="${signnumkey}"  class="input-medium search-query">&nbsp;&nbsp;&nbsp;&nbsp;
                        <select name="classid" id="selectId">
                            <option value="0">选择班级</option>
                            <c:forEach items="${clsList}"  var="cls"  >
                                <option <c:if test="${classid == cls.id}">selected="selected"</c:if> value="${cls.id}">${cls.name}</option>
                            </c:forEach>
                        </select>&nbsp;&nbsp;
                        <button  type="submit" class="btn btn-purple btn-small">
                            查找
                            <i class="icon-search icon-on-right bigger-110"></i>
                        </button>
                    </form>
                    <table id="sample-table-1" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th width="15%">学生编号</th>
                            <th width="15%">学生姓名</th>
                            <th width="15%">所属班级</th>
                            <th width="15%">签到码</th>
                            <th>签到时间</th>
                            <th width="20%" >签到成功</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${infoList}"  var="info"  >
                            <tr>
                                <td>${info["studentid"]}</td>
                                <td>${info["studentname"]}</td>
                                <td>${info["classname"]}</td>
                                <td>${info["signnum"]}</td>
                                <td><fmt:formatDate value="${info['signindetail'].signtime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                                <td>
                                    <c:if test="${info['signindetail'].flag == 1}">是</c:if>
                                    <c:if test="${info['signindetail'].flag !=1 }">否</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="dataTables_paginate paging_bootstrap pagination">
                        <button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/signInStudents?pagenum=${pagenum-1}&classid=${classid}'" <c:if test="${pagenum <= 1}">disabled="disabled"</c:if>    >&laquo;</button>
                        <button class="btn btn-success btn-mini" disabled="disabled">第 ${pagenum} 页</button>
                        <button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/signInStudents?pagenum=${pagenum+1}&classid=${classid}'" <c:if test="${length < 8}">disabled="disabled"</c:if> >&raquo;</button>
                    </div>

                    <!--PAGE CONTENT ENDS-->
                </div><!--/.span-->
            </div><!--/.row-fluid-->
        </div><!--/.page-content-->
    </div><!--/.main-content-->
</div><!--/.main-container-->

<%@include file="/WEB-INF/views/common/js.jsp" %>

</body>
</html>
