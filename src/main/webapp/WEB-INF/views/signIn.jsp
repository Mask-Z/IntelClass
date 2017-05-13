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
                        <%--<select name="classid">--%>
                            <%--<option value="0">选择班级</option>--%>
                            <%--<c:forEach items="${clsList}"  var="cls"  >--%>
                                <%--<option <c:if test="${exam.classid == cls.id}">selected="selected"</c:if> value="${cls.id}">${cls.name}</option>--%>
                            <%--</c:forEach>--%>
                        <%--</select>&nbsp;&nbsp;--%>
                        <button  type="submit" class="btn btn-purple btn-small">
                            生成签到码
                            <i class=" icon-refresh icon-on-right bigger-110"></i>
                        </button>
                        <%--<a href="#myModal"  role="button"  class="btn btn-purple btn-small" data-toggle="modal"><i class="icon-plus-sign icon-on-right bigger-110"></i>添加考试</a>--%>

                    </form>
                    <div class="page-header position-relative">
<%--<hr/>--%>
                       <h5>
                            <small>  &nbsp; &nbsp;&nbsp;&nbsp;
                                <i class="icon-user "></i>
                                学生签到情况
                            </small>
                        </h5>
                    </div>


                    <div id="myIframe" style="height: 50%;position: relative;background-color: #0b6cbc">
                        <iframe id="about-dialog-button-bar">
                          <p>  hello world!</p>
                        </iframe>
                    </div>
                    <%--<table id="sample-table-1" class="table table-striped table-bordered table-hover">--%>
                        <%--<thead>--%>
                        <%--<tr>--%>
                            <%--<th width="15%">学生编号</th>--%>
                            <%--<th width="15%">学生姓名</th>--%>
                            <%--<th width="15%">所属班级</th>--%>
                            <%--<th>签到成功</th>--%>
                            <%--<th width="20%" >操作</th>--%>
                        <%--</tr>--%>
                        <%--</thead>--%>
                        <%--<tbody>--%>
                        <%--<c:forEach items="${studentList}"  var="student"  >--%>
                            <%--<tr>--%>
                                <%--<td><a href="#">${student.id}</a></td>--%>
                                <%--<td>${student.name}</td>--%>
                                <%--<td>${student.classid}</td>--%>
                                <%--<td>${student.remark}</td>--%>
                                <%--<td >--%>
                                    <%--<button class="btn btn-mini btn-primary" onclick="location.href='<%=request.getContextPath() %>/manager/leavemessage?studentid=${student.id}'" ><i class="icon-comment"></i>微信留言</button>--%>
                                    <%--<button class="btn btn-mini btn-primary" onclick="location.href='<%=request.getContextPath() %>/manager/examdetail?studentid=${student.id}'"><i class="icon-file"></i>考试情况</button>--%>
                                <%--</td>--%>
                            <%--</tr>--%>
                        <%--</c:forEach>--%>
                        <%--</tbody>--%>
                    <%--</table>--%>

                    <%--<div class="dataTables_paginate paging_bootstrap pagination">--%>
                        <%--<button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/students?pagenum=${pagenum-1}'" <c:if test="${pagenum <= 1}">disabled="disabled"</c:if>    >&laquo;</button>--%>
                        <%--<button class="btn btn-success btn-mini" disabled="disabled">第 ${pagenum} 页</button>--%>
                        <%--<button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/students?pagenum=${pagenum+1}'" <c:if test="${length < 8}">disabled="disabled"</c:if> >&raquo;</button>--%>
                    <%--</div>--%>

                    <!--PAGE CONTENT ENDS-->
                </div><!--/.span-->
            </div><!--/.row-fluid-->
        </div><!--/.page-content-->
    </div><!--/.main-content-->
</div><!--/.main-container-->

<%@include file="/WEB-INF/views/common/js.jsp" %>

</body>
</html>
