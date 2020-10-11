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

<!--显示菜品列表的表格-->
<table id="food_data_grid">
    <!-- 表格中的数据由JavaScript生成 -->
</table>

<!-- 操作菜品的对话框 -->
<div id="dialog"
     class="easyui-window"
     title=""
     style="width:400px;height:400px"
     data-options="iconCls:'icon-save',modal:true,collapsible:false,minimizable:false,maximizable:false,closed:true">

    <form id="form_submit_food"
          enctype="multipart/form-data"
          method="post" >

        <table align="center" style="width: 300px">

            <!---------id------------------>
            <tr>

                <td>
                    <input name="id"
                           type="text"
                           id="id"
                           style="visibility: hidden">
                </td>
            </tr>
            <!---------name------------------>
            <tr>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">名称</span>
                        <input name="name"
                               type="text"
                               class="form-control"
                               id="name"
                               aris-describedby="basic-addon3">
                    </div>
                </td>
            </tr>

            <tr><td><br></td></tr>

            <!----------price----------------->
            <tr>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">价格</span>
                        <input name="price"
                               type="text"
                               class="form-control"
                               id="price"
                               aris-describedby="basic-addon3">
                    </div>
                </td>
            </tr>

            <tr><td><br></td></tr>


            <!---------unit------------------>
            <tr>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">单位</span>
                        <input name="unit"
                               type="text"
                               class="form-control"
                               id="unit"
                               aris-describedby="basic-addon3">
                    </div>

                </td>
            </tr>

            <tr><td><br></td></tr>

            <!---------type------------------>
            <tr>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">种类</span>
                        <input name="type"
                               type="text"
                               class="form-control"
                               id="type"
                               aris-describedby="basic-addon3">
                    </div>

                </td>
            </tr>

            <tr><td><br></td></tr>


            <!---------picture------------------>
            <tr>
                <td>
                    <div class="input-group">
                        <span class="input-group-addon">图片</span>
                        <input name="picture"
                               type="file"
                               class="form-control"
                               id="picture"
                               aris-describedby="basic-addon3">
                    </div>

                </td>
            </tr>

            <tr><td><br><br></td></tr>

            <!---------- 按钮 ----------------->
            <tr>
                <td colspan="2" align="center" style="text-align: center">
                    <a id="confirmBtn"
                       class="easyui-linkbutton"
                       icon="icon-save"
                       href="javascript:void(0)"
                       style="margin-right: 10px;width: 100px"
                       onclick="btn_submit();">提交</a>

                    <a class="easyui-linkbutton"
                       icon="icon-cancel"
                       href="javascript:void(0)"
                       style="width: 100px"
                       onclick="btn_cancel();">取消</a>
                </td>
            </tr>
        </table>
    </form>
</div>

<!--鼠标弹出菜单：放置一个隐藏的菜单Div,点击鼠标右键时显示-->
<div id="menu" class="easyui-menu" style="width: 30px; display: none;">

    <!--具体的菜单事件请自行添加，跟toolbar的方法是基本一样的-->

    <div id="btn_Add" data-options="iconCls:'icon-add'" onclick="showAddItemDialog()">添加</div>

    <div id="btn_Delete" data-options="iconCls:'icon-remove'" onclick="showRemoveItemDialog()">删除</div>

    <div id="btn_Modify" data-options="iconCls:'icon-edit'" onclick="showModifyItemDialog()">修改</div>
</div>

</body>

<script>
    var operation;


    // 加载菜品列表
    $(function () {
        $("#food_data_grid").datagrid({
            url: '/admin/FoodManage/getFoodList',
            iconCls: 'icon-save',
            striped: "true",
            pagination: 'true',
            pageSize: 4,
            pageList: [4, 8, 12, 16, 20, 24, 28, 32, 36, 40],
            fit: true,
            fitColumns: true,
            nowrap: false,
            border: false,
            isField: 'id',
            sortName: 'id',
            toolbar: [{
                iconCls: 'icon-add',
                text: '添加',
                handler: function () {
                    showAddItemDialog();
                }
            }, '-', {
                iconCls: 'icon-remove',
                text: '删除',
                handler: function () {
                    showRemoveItemDialog();
                }
            }, '-', {
                iconCls: 'icon-edit',
                text: '修改',
                handler: function () {
                    showModifyItemDialog();
                }
            }],
            sortOrder: 'asc',
            columns: [[
                {
                    title: '美食图片',
                    field: 'picture',
                    align: 'center',
                    width: 30,
                    formatter: function (value, row, index) {
                        return '<img width="90px" height="90px" src="' + row.picture + '" />';
                    }
                },
                {title: '编号', field: 'id', width: 50, sortable: 'true'},
                {title: '名称', field: 'name', width: 100, sortable: 'true'},
                {title: '价格', field: 'price', width: 20, sortable: 'true'},
                {title:'单位',field:'unit',width:20,sortable:'true'},
                {title:'种类',field:'type',width:30,sortable:'true'},
            ]]

        });
    });

    // 显示右键菜单
    $("#food_data_grid").datagrid({
        onRowContextMenu: function (e, rowIndex, rowData) { //右键时触发事件
            // 三个参数：
            // e里面的内容很多，真心不明白
            // rowIndex就是当前点击时所在行的索引
            // rowData当前行的数据

            //阻止浏览器捕获右键事件
            e.preventDefault();

            //取消所有选中项
            $(this).datagrid("clearSelections");

            //根据索引选中该行
            $(this).datagrid("selectRow", rowIndex);

            //显示右键菜单
            $('#menu').menu('show', {
                //在鼠标点击处显示菜单
                left: e.pageX,
                top: e.pageY
            });
            e.preventDefault();  //阻止浏览器自带的右键菜单弹出
        }
    });


    // 显示添加菜品对话框
    function showAddItemDialog() {
        operation = "addFood";
        $("#dialog").window({
            title: '添加美食'
        });
        $("#fid").val(0);
        $('#dialog').window('open');
    }

    // 显示删除菜品对话框
    function showRemoveItemDialog() {
        operation = "deleteFood";

        var selections = $("#food_data_grid").datagrid("getSelections");
        var ids = '';
        if (selections.length == 0) {
            $.messager.alert("提示", "请选择要删除的数据!");
            return;
        }
        $.each(selections, function (index, ele) {
            ids += ele.id + ',';
        });
//        ids = ids.substr(0,ids.length-1);
        $.messager.confirm("提示", "确定删除" + selections.length + "条数据?", function (r) {
            if (r) {
                $.ajax({
                    url: '/admin/FoodManage/deleteFood',
                    type: 'post',
                    data: {ids: ids},
                    success: function (msg) {
                        $.messager.alert("提示", msg.message, null, function () {
                            if (msg.status == 1) {
                                $('#food_data_grid').datagrid('reload');
                            }
                        });
                    }
                });
            }
        })
    }

    // 显示修改菜品对话框
    function showModifyItemDialog() {
        operation = "updateFood";

        var selections = $("#food_data_grid").datagrid("getSelections");
        if (selections.length == 0) {
            $.messager.alert("提示", "请选中一个美食进行修改");
        } else if (selections.length > 1) {
            $.messager.alert("提示", "一次只能修改一个条目");
        } else {
            $("#dialog").window({
                title: '修改美食'
            });
            $('#dialog').window('open');
            var selection = selections[0];
            $("#id  ").val(selection.id);
            $("#name ").val(selection.name);
            $("#price").val(selection.price);
            $("#type").val(selection.type);
            $("#unit").val(selection.unit);
        }
    }

    // 保存菜品
    function btn_submit() {

        $('#form_submit_food').form('submit', {
            url: '/admin/FoodManage/'+operation,
            onSubmit: function () {
                if ($("#name").val().length < 1
                    || $("#price").val().length < 1
                    || $("#unit").val().length < 1
                    || $("#type").val().length < 1
                    || $("#picture").val().length < 1) {
                    $.messager.alert("提示", "所有字段都为必填项");
                    return false;
                }
            },
            success: function (data) {
                var response = JSON.parse(data);
                $.messager.alert("提示", response.message, null, function () {
                    console.log(response);
                    if (response.status == 1) {
                        $('#dialog').window('close');
                        $('#food_data_grid').datagrid('reload');
                    }
                });
            }
        });
    }

    // 取消菜品
    function btn_cancel() {
        $('#dialog').window('close');
    }


    //
    //    // 右键鼠标弹出菜单的删除按钮的点击事件
    //    $("#btn_Delete").click(function () {
    //        removeItem();
    //    });
    //
    //    // 右键鼠标弹出菜单的修改按钮的点击事件
    //    $("#btn_Modify").click(function () {
    //        modifyItem();
    //    });
</script>



</html>