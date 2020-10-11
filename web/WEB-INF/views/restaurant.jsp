<%@page import="com.sun.corba.se.impl.protocol.RequestDispatcherRegistryImpl" %>
<%@ page language="java" import="java.util.Date" import="java.util.*" import="java.sql.*" import="java.text.*"
         import="java.security.MessageDigest"
         pageEncoding="utf-8" %>
<%@ page import="cn.forage.model.FoodItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico"/>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
    <!--<link href="css/global.css" rel="stylesheet"/>-->
    <link href="${pageContext.request.contextPath}/static/css/non-responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/global.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/restaurant.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet">
    <title>觅食</title>
</head>
<body>
<%@ include file="component/nav.jsp" %>
<div class="cantainer main" id="app">
    <div class="cantainer">
        <!-- 商家信息 -->
        <%
            int restaurantId = (Integer)request.getAttribute("restaurantId");
        %>
        <div class="row shop-info" id="restaurant" data-id="<%= restaurantId %>">
            <div class="shop-descript">
                <div class="shop-img tag-left">
                    <img src="${pageContext.request.contextPath}/img/chicken.jpg" height="90px"/>
                </div>
                <div class="tag-left shop-detial">
                    <p class="shop-name"><a href="#">窑鸡王（桂庙店）</a></p>
                    <p class="shop-location">商家地址：粤海街道书山路3011-2号（学府小学门口）</p>
                    <p class="shop-phone">商家电话：121323223</p>
                </div>
            </div>
        </div>
        <!-- 菜品列表 -->
        <div class="cantainer foods-view">
            <!-- 菜品类别 -->
            <div class="row foodsmenu">
                <div class="menu-header">
                    <span>菜单</span>
                </div>
                <div class="menu-list">
                    <ul>
                        <li><a class="active" href="#">热销</a></li>
                        <li><a href="#">热销</a></li>
                        <li><a href="#">热销</a></li>
                        <li><a href="#">热销</a></li>
                        <li><a href="#">热销</a></li>
                        <li><a href="#">热销</a></li>
                    </ul>
                </div>
            </div>

            <%

                //属性名称需要进行修改"foodItems"
                ArrayList<FoodItem> food_list = (ArrayList<FoodItem>)request.getAttribute("foodItems");
                for (int index = 0; index < food_list.size();index++) {
                    FoodItem foodItem = food_list.get(index);
                    if (index+1==1) {
                        //System.out.println("before--" + index);
            %>

            <div class="row food-list-row">
                <%
                    }
                %>
                <div class="col-xs-4 card-food" id="<%=foodItem.getId()%>">
                    <div class="preview">
                        <img src="${pageContext.request.contextPath}/<%=foodItem.getPicture()%>"/>
                    </div>
                    <div class="content">
                        <div class="sellnum">月售<%=foodItem.getSaleNum()%>份</div>
                    </div>
                    <div class="sell">
                        <div class="price tag-left"><%=foodItem.getPrice()%>元/份</div>
                        <div class="operater tag-right">
                            <button data-id="<%=foodItem.getId()%>" data-price="12" data-name="<%=foodItem.getName()%>" type="button"
                                    class="add-btn">+
                            </button>
                        </div>
                    </div>
                </div>
                <%if (index+1!=1&&(index+1) % 3 == 0) {
                //System.out.println("after--" + index);%>
            </div>

            <%if(index+1!=food_list.size())%>
            <div class="row food-list-row">
            <%
                    }
                }
            %>
        </div>
    </div><!--container main-->
    <div class="container footer">
        <div class="row">
            <div class="col-xs-5 border-right">
                <ul class="tag-left">
                    <li><a href="#">我要开店</a></li>
                    <li><a href="#">配送加盟</a></li>
                    <li><a href="#">城市代理</a></li>
                </ul>
                <ul class="tag-left">
                    <li><a href="#">开放平台</a></li>
                    <li><a href="#">关于觅食</a></li>
                    <li><a href="#">媒体报道</a></li>
                </ul>
                <ul class="tag-left">
                    <li><a href="#">常见问题</a></li>
                    <li><a href="#">用户反馈</a></li>
                    <li><a href="#">加入我们</a></li>
                </ul>
            </div>
            <div class="col-xs-3 border-right">
                <div class="service-phone-number">1010-9777</div>
                <div class="service-detail">
                    <p>周一至周日 9:00-23:00</p>
                    <p>客服不受理商务合作</p>
                </div>
            </div>
            <div class="col-xs-4">
            </div>
        </div>
    </div>
    <div class="container copyright">
        <p>&copy;2017 forage.cn 开发者：杨观荣 | 刘基雄 | 姜剑辉 | 徐荣钦 | 吴超均</p>
    </div>
    <form class="cart" id="cart" action="#" method="post">
        <div class="cart-detial">
            <div class="title">
                <div class="tag-left title-name">菜品<a href="javascript:;" class="clearcart">[清空]</a></div>
                <div class="tag-left title-num">份数</div>
                <div class="tag-left title-price">价格</div>
            </div>
            <ul class="foods clear">
            </ul>
            <div class="cost clear">
                <span class="tag-right">共&nbsp;<span class="cost-num">0</span>&nbsp;份，总计<span class="cost-amount">￥<span
                        class="amount">0</span></span></span>
            </div>
        </div>
        <div class="placeorder">
            <div class="cart-img"><span class="glyphicon glyphicon-shopping-cart"></span></div>
            <button class="tag-right" type="buttom"><a href="/order/preview?restaurantId=<%= restaurantId %>">下订单</a></button>
        </div>
    </form>
</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="${pageContext.request.contextPath}/static/js/scrollbar.js"></script>

<script src="${pageContext.request.contextPath}/static/js/cart.js"></script>
</html>