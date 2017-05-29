<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>问题列表</title>
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
                        问题详情
                    </small>
                </h1>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <!--PAGE CONTENT BEGINS-->
                    <form class="form-inline" method="get" action="<%=request.getContextPath() %>/manager/questions">
                        <input type="hidden" name="pagenum" value="${pagenum}">
                        &nbsp;&nbsp;题目标题：<input type="text" name="title" value="${question.title}"  class="input-medium search-query">&nbsp;&nbsp;&nbsp;&nbsp;
                        <select name="classid">
                            <option value="0">选择班级</option>
                            <c:forEach items="${clsList}"  var="cls"  >
                                <option <c:if test="${question.classid == cls.id}">selected="selected"</c:if> value="${cls.id}">${cls.name}</option>
                            </c:forEach>
                        </select>&nbsp;&nbsp;
                        <button  type="submit" class="btn btn-purple btn-small">
                            查找
                            <i class="icon-search icon-on-right bigger-110"></i>
                        </button>
                        <a href="#myModal"  role="button"  class="btn btn-purple btn-small" data-toggle="modal"><i class="icon-plus-sign icon-on-right bigger-110"></i>添加题目</a>

                    </form>
                    <table id="sample-table-1" class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th width="10%">题目编号</th>
                            <th width="10%">出题班级</th>
                            <th width="20%">题目标题</th>
                            <th width="20%">题目内容</th>
                            <th width="20%">提问时间</th>
                            <th width="20%" >操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${questionList}"  var="question"  >
                            <tr>
                                <td>${question.id}</td>
                                <td>${question.classid}</td>
                                <td>${question.title}</td>
                                <td>${question.content}</td>
                                <td><fmt:formatDate value="${question.inserttime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td >
                                    <button class="btn btn-mini btn-purple"  onclick="location.href='<%=request.getContextPath() %>/manager/viewquestions?questionid=${question.id}'" ><i class="icon-file"></i>答题详情</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="dataTables_paginate paging_bootstrap pagination">
                        <button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/students?pagenum=${pagenum-1}'" <c:if test="${pagenum <= 1}">disabled="disabled"</c:if>    >&laquo;</button>
                        <button class="btn btn-success btn-mini" disabled="disabled">第 ${pagenum} 页</button>
                        <button class="btn btn-success btn-mini" onclick="location.href='<%=request.getContextPath() %>/manager/students?pagenum=${pagenum+1}'" <c:if test="${length < 10}">disabled="disabled"</c:if> >&raquo;</button>
                    </div>

                    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h3 id="myModalLabel">添加题目</h3>
                        </div>
                        <form action="addQuestion" id="addQuestion" method="post"  class="form-inline">
                            <div class="modal-body">
                             <label class="control-label"   >班级:&nbsp;&nbsp;</label>
                                <select name="classid">
                                    <c:forEach items="${clsList}"  var="cls"  >
                                        <option   value="${cls.id}">${cls.name}</option>
                                    </c:forEach>
                                </select>
                                <br><br>
                                <label class="control-label"   >题目标题:&nbsp;&nbsp;</label>
                                <input type="text" name="title" class="input-medium"  id="addtitle"  >
                                <br><br>
                                <label class="control-label"    >题目内容:&nbsp;&nbsp;</label>
                                <input type="text" name="content" id="addcontent"  class="input-xlarge" >
                            </div>
                            <div class="modal-footer">
                                <button  type="button" id="add" class="btn btn-small btn-primary">完成</button>
                            </div>
                        </form>
                    </div>

                    <!--PAGE CONTENT ENDS-->
                </div><!--/.span-->
            </div><!--/.row-fluid-->
        </div><!--/.page-content-->
    </div><!--/.main-content-->
</div><!--/.main-container-->

<%@include file="/WEB-INF/views/common/js.jsp" %>
<script type="text/javascript">
    $(function() {
        $('#add').on('click', function() {
            if($.trim($("#addtitle").val())==''){
                alert('请输入题目标题！');
                return;
            }else if($.trim($("#addcontent").val())==''){
                alert('请输入题目内容！');
                return;
            }else{
                $("#addQuestion").submit();
            }
        });
    });
</script>
</body>
</html>