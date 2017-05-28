<%--
  Created by IntelliJ IDEA.
  User: Mr丶周
  Date: 2017/5/14
  Time: 22:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人签到饼状图</title>
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
<%--<div id="main" style="width: 650px;height:400px;"></div>--%>
<script>
    var myChart = echarts.init(document.getElementById('main'));
    var succeed="${succeed}";
    var failure="${failure}";
    option = {
        title : {
            text: '个人签到情况',
//            subtext: '纯属虚构',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient : 'vertical',
            x : 'left',
            data:['签到成功','未签到']
        },
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {
                    show: true,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 150
                        }
                    }
                },
//                restore : {show: true},
//                saveAsImage : {show: true}
            }
        },
        calculable : true,
        series : [
            {
                name:'签到状态',
                type:'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[
                    {value:succeed, name:'签到成功'},
                    {value:failure, name:'未签到'}
                ]
            }
        ]
    };

    myChart.setOption(option);
</script>
</body>
</html>
