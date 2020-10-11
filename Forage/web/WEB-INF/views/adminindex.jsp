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
<body class="easyui-layout" style="overflow: hidden">

<!--顶部栏-->
<div data-options="region:'north',split:false,border:false"
     style="height:40px;overflow: hidden;padding-top: 5px"
     align="center">
    <span style="font-size: 24px">美食天下</span>
</div>

<!--底部栏-->
<div data-options="region:'south',split:false,border:false"
     style="height:30px;overflow: hidden"
     align="center">
    <span style="font-size: 10px;padding-bottom: 5px">@版权归扎哇分队所有，盗版必究@</span>
</div>

<!--左边导航栏-->
<div data-options="region:'west',title:'系统菜单',split:true,collapsible:false" style="width:200px;">
    <ul id="tt" class="easyui-tree">
    </ul>
</div>
<!--<div data-options="region:'center',title:'首页'" fit="true" style="overflow: hidden;padding: 0px">-->
<!--<div id="tabs" class="easyui-tabs" fit="true">-->

<!--中间内容区-->
<div id="centerPanel" data-options="region:'center',title:'首页',href:'/admin/center'"
     style="padding:0px;background:#eee;overflow: hidden"></div>
<script>
    $('#tt').tree({
        cascadeCheck: false,
        lines: true,
        data: [{
            id: 1,
            text: "订单管理",
            state: closed,
            attributes: {
                url: "/admin/orderManage"
            },
        }, {
            id: 2,
            text: "菜品管理",
            state: closed,
            attributes: {
                url: "/admin/foodManage"
            }
        }, {
            id: 3,
            text: "用户中心",
            state: closed,
            attributes: {
                url: "/admin/userCenter"
            }
        }]
        ,
        onClick: function (node) {
            if ($('#tabs').tabs('exists', node.text)) {
                // 当前选中的tab标签页已存在，则更新它
                $('#tabs').tabs('select', node.text);
                var tab = $('#tt1').tabs('getSelected');
                $('#tt1').tabs('update',{
                    tab:tab,
                    options:{
                        title:node.text,
                        content:'<iframe frameborder="0" src=" '+ node.attributes.url + '" width="100%" height="100%"></iframe>',
                        closable:true,
                        tools:[{
                            iconCls:'icon-mini-refresh',
                            handler:function () {
                                alert('refresh');
                            }
                        }]
                    }
                })
            } else {
                // 当前选中的tab标签页不存在，则添加它
                $('#tabs').tabs('add', {
                    fit: true,
                    border: false,
                    title: node.text,
                    content: '<iframe  scrolling="no" src="' + node.attributes.url + '"style="border: 0; width: 100%; height: 100%;" frameBorder="0"></iframe>',
                    closable: true,
                    tools:[{
                        iconCls:'icon-mini-refresh',
                        handler:function () {
                            alert('refresh');
                        }
                    }]
                });
            }
        }
    });
</script>
</body>
</html>