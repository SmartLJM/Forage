<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <link rel="stylesheet" href="../../static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" href="../../static/easyui/themes/icon.css">
    <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.css">
    <script src="../../static/jquery-3.2.0.js"></script>
    <script src="../../static/easyui/jquery.easyui.min.js"></script>
    <script src="../../static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="../../static/bootstrap/js/bootstrap.js"></script>
</head>


<body>

<div id="tabs"
     class="easyui-tabs"
     fit="true"
     border="false"
     style="overflow: hidden;width: 100%;height: 100%">

    <!--存放订单的表格-->
    <table id="data_grid"
           style="margin: 0px; padding: 0px;width: 100%;height: 100%"
           fit="true">
        <!--表中的数据由JavaScript动态生成-->
    </table>
</div>

</body>


<script>
    $(function () {
        $("#data_grid").datagrid({
            url: '/admin/OrderManage/getOrderList',
            striped: "true",
            pagination: 'true',
            pageSize: 10,
            pageList: [10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
            fit: true,
            fitColumns: true,
            nowrap: false,
            border: false,
            isField: 'id',
            sortName: 'id',
            sortOrder: 'asc',
            columns: [[{title: '编号', field: 'code', width: 100, sortable: 'true'},
                {title: '订餐人', field: 'buyerName', width: 100, sortable: 'true'},
                {title: '总价', field: 'totalMoney', width: 100, sortable: 'true'},
                {title: '下单时间', field: 'orderTime', width: 100, sortable: 'true'},
                {title: '订单状态', field: 'status', width: 100, sortable: 'true'}]]
        });
    });
</script>


</html>


