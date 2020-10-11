<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.sun.corba.se.impl.protocol.RequestDispatcherRegistryImpl" %>
<%@ page import="cn.forage.model.FoodItem" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="cn.forage.model.Address" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
  <link href="/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
  <!--<link href="css/global.css" rel="stylesheet"/>-->
  <link href="/static/css/non-responsive.css" rel="stylesheet">
  <link href="/static/css/global.css" rel="stylesheet">
  <link href="/static/css/placeorder.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
<%--导航栏--%>
<%@ include file="component/nav.jsp" %>
  <div class="cantainer main">
    <div class="orders-wrap">
    	<div class="detial-warp tag-left">
	      <div class="order-detail">
	        <div class="order-header">
	        	<span class="tag-left">菜品</span><span class="tag-right">价格/份数</span>
	        </div>
	        <ul class="item-list menu-ul clear">
                <%
                    int restaurantId = (int)request.getAttribute("restaurantId");
                    ArrayList<FoodItem> foods = (ArrayList<FoodItem>)request.getAttribute("foodItems");
                    double cost = 0;
                    for(FoodItem item: foods){
                        cost += item.getPrice();
                %>
						<li><span class="tag-left"><%= item.getName() %></span><span class="tag-right">¥<%= item.getPrice() %></span></li>
                <%
                    }
                %>
	        </ul>
	        <div class="order-cost">
						<span class="tag-left">总计</span><span class="tag-right">￥<%= cost %></span>
	        </div>
	      </div>
      	<img src="/static/img/order-bot-bg1.png" />
     	</div>
      <div class="address-area">
        <div class="address-header">
					<span class="tag-left">送餐详情</span><span class="tag-right"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加新地址</span>
        </div>
        <div class="address-list">
                    <%
                      ArrayList<Address> addrs = (ArrayList<Address>)request.getAttribute("addresses");
                      int addressId = -1;
                      if(addrs.size() > 0){
                        addressId = addrs.get(0).getId(); // 默认使用第一个地址
                      }
                      for(Address item : addrs ){
                    %>
					<div class="address checked">
						<div class="base-info"><%= item.getName() %> : <%= item.getPhoneNum() %></div>
						<div class="location"><%= item.getLocation() %></div>
					</div>
                    <%
                        }
                    %>
					<div class="address-bottom">
						<a href="javascript:;">显示所有地址<span class="glyphicon glyphicon-chevron-down"></span></a>
					</div>
        </div>
        <div class="pay">
        	<span class="tag-left">你需要付<span class="cost">￥<%= cost %></span></span><button type="button" class="tag-right"><a href="/order/confirm?restaurantId=<%= restaurantId %>&addressId=<%= addressId %>">确定下单</a></button>
        </div>
      </div>
    </div>
  </div>
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
    <p>&copy;2020 开发者：吕继明</p>
</div>
</body>
<script src="/static/js/jquery-2.1.4.min.js"></script>
<script src="/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="/static/js/scrollbar.js"></script>
</html>