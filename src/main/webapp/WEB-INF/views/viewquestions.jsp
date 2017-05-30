<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>答题详情</title>
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
                        <i class="icon-file"></i>
                        答题详情
                    </small>
                </h1>
            </div>
            <div class="row-fluid">

                <div class="span12">
                    <!--PAGE CONTENT BEGINS-->
                    <form action="addexammark" id="addexammark" class="form-horizontal" method="post">
                        <%--<input type="hidden" name="classid" value="${exam.classid }" />--%>
                        <%--<input type="hidden" name="course" value="${exam.course }" />--%>
                        <%--<input type="hidden" name="fullmarks" value="${exam.fullmarks }" />--%>
                        <%--<input type="hidden" name="remark" value="${exam.remark }" />--%>
                        <label for="form-field-8"> &nbsp;&nbsp;&nbsp;题目标题： <b>${question.title}</b><br/>
                            &nbsp;&nbsp;&nbsp;题目详情： <b>${question.content}</b>
                        </label><br>
                        <table  class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>

                                <th>题号</th>
                                <th>学生姓名</th>
                                <th>所在班级</th>
                                <th>所给答案</th>
                                <th>解答时间</th>

                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${tempList}"  var="temp" >
                                <tr>
                                    <td>${question.id}</td>
                                    <td>${temp.name}</td>
                                    <td>${question.classid}</td>
                                    <td>${temp.content}</td>
                                    <td><fmt:formatDate value="${temp.date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <button class="btn btn-info" type="button" onclick="location.href='<%=request.getContextPath() %>/manager/questions'" >
                            <i class="icon-arrow-left"></i>
                            返回
                        </button>
                    </form>
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
            var flag = true;
            $(".mark").each(function(){
                if($(this).val() == ""||isNaN($(this).val())||$(this).val() < 0||$(this).val()> ${exam.fullmarks}) {
                    alert('分数填写有误！');
                    flag = false;
                    return false;
                }
            });
            if(flag)$("#addexammark").submit();
        });
    });
</script>
</body>
</html>