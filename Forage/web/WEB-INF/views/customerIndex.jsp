<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />
  <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.0/css/bootstrap.min.css" rel="stylesheet"/>
  <!--<link href="css/global.css" rel="stylesheet"/>-->
  <link href="${pageContext.request.contextPath}/static/css/non-responsive.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/global.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/static/css/order.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
  <%@include file="component/nav.jsp"%>
  <div class="cantainer main">
    <div class="orders-wrap">
      <div class="order-menu tag-left">
        <div class="menu-btn item active-item">
          <span class="glyphicon glyphicon-list-alt"></span><span>三个月订单<span>
        </div>
        <div class="myaccount item">
          <span class="glyphicon glyphicon-user"></span><span>我的账号<span>
        </div>
        <div class="mystore item">
          <span class="glyphicon glyphicon-star-empty"></span><span>我的收藏<span>
        </div>
      </div>
      <div class="order-area">
        <div class="orders-head">
          <div class="title-contain tag-left">内容</div>
          <div class="title-phone tag-left">商家电话</div>
          <div class="title-cost tag-left">总价</div>
          <div class="title-operate tag-left">操作</div>
        </div>
        <div class="order-list">
          <div class="order-item-wrap">
            <div class="order-item">
              <div class="order-contain">
                <div class="food-img">
                  <img src="${pageContext.request.contextPath}/img/chicken.jpg"/>
                </div>
                <div class="food-detial">
                  <a href="#">烤鸡</a>
                  <p>2017-05-17 18:00 订单号：1850070424040454</p>
                </div>
              </div>
              <div class="order-phone">344434334343</div>
              <div class="order-cost">￥88</div>
              <div class="order-operate">
                <button type="button" class="sure-btn">确定收货</button><button type="button" class="cancel-btn">取消订单</button>
              </div>
            </div>
          </div>
        </div>
        <div class="order-list">
          <div class="order-item-wrap">
            <div class="order-item">
              <div class="order-contain">
                <div class="food-img">
                  <img src="${pageContext.request.contextPath}/img/chicken.jpg"/>
                </div>
                <div class="food-detial">
                  <a href="#">烤鸡</a>
                  <p>2017-05-17 18:00 订单号：1850070424040454</p>
                </div>
              </div>
              <div class="order-phone">344434334343</div>
              <div class="order-cost">￥88</div>
              <div class="order-operate">
                <button type="button" class="sure-btn">确定收货</button><button type="button" class="cancel-btn">取消订单</button>
              </div>
            </div>
          </div>
        </div>
        <div class="order-list">
          <div class="order-item-wrap">
            <div class="order-item">
              <div class="order-contain">
                <div class="food-img">
                  <img src="${pageContext.request.contextPath}/img/chicken.jpg"/>
                </div>
                <div class="food-detial">
                  <a href="#">烤鸡</a>
                  <p>2017-05-17 18:00 订单号：1850070424040454</p>
                </div>
              </div>
              <div class="order-phone">344434334343</div>
              <div class="order-cost">￥88</div>
              <div class="order-operate">
                <button type="button" class="sure-btn">确定收货</button><button type="button" class="cancel-btn">取消订单</button>
              </div>
            </div>
          </div>
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
<script src="${pageContext.request.contextPath}/static/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<!-- scrollbar 必须在jquery和bootstrap后面 -->
<script src="${pageContext.request.contextPath}/static/js/scrollbar.js"></script>
</html>