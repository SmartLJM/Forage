<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cn.forage.model.User" %>
<!--顶上小导航栏-->
<div class="header-slim">
    <nav class="navbar">
        <div class="container">
            <div class="tag-left">
                <a href="#"></a>
            </div>
            <div class="tag-right header-slim-link">
            <span>
                <%
                    User user = (User)session.getAttribute("user");
                    if(user == null){
                %>
              <a href="${pageContext.request.contextPath}/signin">登录</a>&nbsp;|&nbsp;<a href="${pageContext.request.contextPath}/signup">注册</a>
                <%
                    }else{
                %>
                <a href="${pageContext.request.contextPath}/customer/orders"><%= user.getName() %></a>
                <%
                    }
                %>
            </span>
                <a href="#">帮助中心</a>
                <a href="#">问题反馈</a>
                <a href="#">联系客服</a>
            </div>
        </div>
    </nav>
</div>
<!--主要导航栏-->
<div class="header-bar-container">
    <nav class="navbar">
        <div class="container">
            <div class="row">
                <div class="navbar-header col-xs-3 header-bar-item">
                    <a href="${pageContext.request.contextPath}/index" class="navbar-brand">
                        <img src="${pageContext.request.contextPath}/static/img/logo.png" />
                    </a>
                </div>
                <div class="col-xs-2 header-bar-item">
                    <a href="${pageContext.request.contextPath}/index">首页</a>
                </div>
                <div class="col-xs-2 header-bar-item">
                    <%
                        if(user == null){
                    %>
                    <a href="${pageContext.request.contextPath}/signin">我的订单</a>
                    <%
                    }else{
                    %>
                    <a href="${pageContext.request.contextPath}/customer/orders">我的订单</a>
                    <%}%>
                </div>
                <div class="col-xs-2 header-bar-item">
                    <a href="#">入驻加盟</a>
                </div>
                <div class="col-xs-3 header-bar-item">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
                <button class="btn btn-default" type="button">Go!</button>
              </span>
                    </div><!-- /input-group -->
                </div>
            </div>
        </div>
    </nav>
</div>