<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>用户中心</title>
    <link rel="stylesheet" href="../../static/easyui/themes/default/easyui.css">
    <link rel="stylesheet" href="../../static/easyui/themes/icon.css">
    <link rel="stylesheet" href="../../static/bootstrap/css/bootstrap.css">
    <script src="../../static/jquery-3.2.0.js"></script>
    <script src="../../static/easyui/jquery.easyui.min.js"></script>
    <script src="../../static/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="../../static/bootstrap/js/bootstrap.js"></script>
</head>

<body>
<!--页面主体-->
<div id="main_window" style="padding:50px;">
    <table align="center">

        <!--图片-->
        <tr height="100px">
            <td width="60px">店铺图片</td>
            <td width="120px" id="restaurantImg"></td>
            <td>
                <button class="btn btn-primary btn-xs" role="button" onclick="showModifyUserMsgDialog('restaurantImg');">修改</button>
            </td>
        </tr>

        <!--名称-->
        <tr height="40px">
            <td width="60px">店铺名称</td>
            <td style="color: #ff030a" width="120px"><strong id="name"></strong></td>
            <td>
                <button class="btn btn-primary btn-xs" role="button" onclick="showModifyUserMsgDialog('name');">修改</button>
            </td>
        </tr>

        <!--手机号码-->
        <tr height="40px">
            <td width="60px">手机号码</td>
            <td style="color: #ff030a" width="120px"><strong id="phoneNum"></strong></td>
            <td>
                <button class="btn btn-primary btn-xs" role="button" onclick="showModifyUserMsgDialog('phoneNum');">修改
                </button>
            </td>
        </tr>

        <!--注销账户按钮-->
        <tr height="80px">
            <td colspan="2" align="center">
                <button type="button" class="btn btn-danger" onclick="showModifyUserMsgDialog('logout_account');">注销账户</button>
            </td>
        </tr>
    </table>
</div>

<!--点击修改按钮后弹出的对话框-->
<div id="update_dialog" class="easyui-window" title="修改" style="width:450px;height:200px"
     data-options="modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true">
    <form method="post" id="ff">
        <div align="center">

            <strong id="item_name"></strong>

            <input id="item_value" type="text">
            <br><br><br>
            <!--确认修改按钮-->
            <a id="confirmBtn"
               class="easyui-linkbutton"
               icon="icon-save"
               href="javascript:void(0)"
               onclick="updateItem();">
                提交
            </a>
            <!--取消修改按钮-->
            <a class="easyui-linkbutton"
               icon="icon-cancel"
               href="javascript:void(0)"
               onclick="cancelUpdate();">
                取消
            </a>
        </div>
    </form>
</div>

<script>
    // 当前执行的操作
    var currentOperation;

    // 更新当前选择的操作项
    function updateItem() {
        var item_value = $("#item_value").val();
        var tipMsg = "";
        if(currentOperation=="restaurantImg"){
            tipMsg = "图片不可以为空";
            $("#item_value").attr("name", "restaurantImg");
        }else if(currentOperation=="name"){
            tipMsg = "店铺名不能为空"
            $("#item_value").attr("name", "name");
        }else if (currentOperation=="phoneNum"){
            tipMsg = "请输入正确的手机号码"
            $("#item_value").attr("name", "phoneNum");
        }

        $('#ff').form('submit', {
            url:'/admin/UserCenter/'+currentOperation,
            onSubmit: function () {
                if (currentOperation == 'phoneNum') {
                    if (item_value == '' || item_value.length != 11) {
                        $.messager.alert('提示', tipMsg);
                        return false;
                    }
                } else {
                    if (item_value == '') {
                        $.messager.alert('提示', tipMsg);
                        return false;
                    }
                }
            },
            success: function (data) {
                var response = JSON.parse(data);
                $.messager.alert("提示", response.message, null, function () {
                    if (response.status == 1) {
                        initSellerMsg();
                    }
                    $("#update_dialog").window("close");
                })
            }
        });
    }

    // 取消更新
    function cancelUpdate() {
        $("#update_dialog").window("close");
    }

    // 显示修改用户信息的对话框
    function showModifyUserMsgDialog(flag) {

        // 清楚上次输入的内容
        $("#item_value").val('');

        if (flag == 'phoneNum') {
            // 修改电话号码
            currentOperation = 'phoneNum';
            $("#ff").removeAttr("enctype");
            $("#item_value").attr("type", "text");
            $("#item_name").html('请输入新的手机号码:');

        } else if (flag == 'name') {
            // 修改店铺名称
            currentOperation = 'name';
            $("#ff").removeAttr("enctype");
            $("#item_value").attr("type", "text");
            $("#item_name").html('请输入新的店铺名称:');

        } else if (flag == 'restaurantImg') {
            // 修改窗口图片
            currentOperation = 'restaurantImg';
            $("#ff").attr("enctype", "multipart/form-data");
            $("#item_value").attr("type", "file");
            $("#item_name").html('请选择新的图片:');

        } else if (flag == 'logoutAccount') {
            // 注销账户
            $.messager.confirm('提示', '账户注销后将不能再使用，确定注销账户吗?', function (r) {
                if (r) {
                    $.ajax({
                        url: '/admin/UserCenter/logoutAccount',
                        success: function (msg) {
                            $.messager.alert("提示", msg.msg, null, function () {
                                if (msg.state == 'ok') {
                                    top.location.href = '/login.html'
                                }
                            })
                        }
                    });
                }
            });
            return;
        }
        $("#update_dialog").window("open");
    }

    $('#main_window').panel({
        width: 500,
        height: 400,
        title: '店铺信息'
    });
    function initSellerMsg() {

        $.ajax({
            url: '/admin/UserCenter/getRestaurant',
            success: function (msg) {
                $("#name").html(msg.name);
                $("#phoneNum").html(msg.phoneNum);
                $("#restaurantImg").html('<img src="' + msg.restaurantImg + '" width="100px" height="100px"/>');
            }
        });
    }
    initSellerMsg();


</script>
</body>
</html>