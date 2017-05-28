<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/10 0010
  Time: 15:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>成绩柱状图</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
    <script src="<%=request.getContextPath()%>/assets/js/echarts.common.min.js"></script>
</head>
<style>
    body{ text-align:center}
    div{
        margin:0 auto;
        /*top: 10%;*/
    }
</style>
<body>


<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 100%;height:100%;"></div>
<%--<div id="main" style="width: 600px;height:400px;"></div>--%>
<script>
    var myChart = echarts.init(document.getElementById('main'));
    // 显示标题，图例和空的坐标轴
    myChart.setOption({
        title: {
            text: '成绩展示'
        },
        tooltip: {},
        legend: {
            data:['分数']
        },
        xAxis: {
            data: []
        },
        yAxis: {},
        series: [{
            name: '分数',
            type: 'bar',
            data: []
        }]
    });

    // 异步加载数据
    var name="${listName}";
//    alert(name.split(",")+":"+typeof name.split(","));
    var mark="${listMark}";
    myChart.setOption({
        xAxis:{data:name.slice(1,name.length-1).split(",")},
        series:[{
            name:'分数',
            center:'50%',
            data:mark.slice(1,mark.length-1).split(",")
        }]

    })

</script>
</body>
</html>
