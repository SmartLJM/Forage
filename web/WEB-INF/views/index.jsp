<%@page import="com.sun.corba.se.impl.protocol.RequestDispatcherRegistryImpl" %>
<%@ page language="java" import="java.util.Date" import="java.util.*" import="java.sql.*" import="java.text.*"
         import="java.security.MessageDigest"
         pageEncoding="utf-8" %>
<%@ page import="cn.forage.model.FoodItem" %>
<%@ page import="cn.forage.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/favicon.ico" />
  <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
  <!--<link href="css/global.css" rel="stylesheet"/>-->
  <link href="${pageContext.request.contextPath}/static/css/non-responsive.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/global.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
  <%--- 导航栏 --%>
  <%--<jsp:include page="component/nav.jsp" >--%>
  <%@ include file="component/nav.jsp" %>

  <div class="cantainer main">
      <%
           //属性名称需要进行修改"foodItems"
          ArrayList<Restaurant> restaurant_list = (ArrayList<Restaurant>) request.getAttribute("restaurants");
          int index = 0;
          for (index = 0; index < restaurant_list.size();index++) {
              Restaurant restaurant = restaurant_list.get(index);
              if (index+1==1) {
                  //System.out.println("before--" + index);
      %>
    <div class="row shop-list-row">
        <%
            }
        %>
      <div class="col-xs-3 card-shop">
        <div class="preview">
          <a href="${pageContext.request.contextPath}/restaurant/<%= restaurant.getId() %>"><img src="${pageContext.request.contextPath}/restaurantimg/<%=restaurant.getRestaurantImg()%>"/></a>
        </div>
        <div class="content">
          <div class="name"><%=restaurant.getName()%></div>
          <div class="location"><%=restaurant.getLocation()%></div>
        </div>
      </div>





        <%if (index+1!=1&&(index+1) % 4 == 0) {
            //System.out.println("after--" + index);%>
        <div class="divider-rest clear"></div>
    </div>

              <%if(index+1!=restaurant_list.size())%>
          <div class="row shop-list-row">
              <%
                      }
                  }
              %>

          <%if (index % 4 != 0) {
              //System.out.println("after--" + index);%>
          <div class="divider-rest clear"></div>
    </div>
          <%
            }
          %>

    <div class="row add-more">
      加载更多
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
    <p>&copy;2020 开发者：吕继明</p>
  </div>
</body>
<script src="${pageContext.request.contextPath}/static/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="${pageContext.request.contextPath}/static/js/scrollbar.js"></script>
</html>