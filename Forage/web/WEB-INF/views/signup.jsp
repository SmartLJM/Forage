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
  <link href="${pageContext.request.contextPath}/static/css/signin.css" rel="stylesheet">
  <title>觅食</title>
</head>
<body>
	<div class="header">
		<img class="logo" src="${pageContext.request.contextPath}/static/img/logo_login.png"/>
  </div>
  <div class="header-divider"></div>
  <div class="cantainer main">
   	<div class="signin-section">
   		<form class="sign-form" action="${pageContext.request.contextPath}/signup" method="post">
            <%@ include file="component/alertDiv.jsp" %>
            <div class="form-g">
              <span class="input-tip">用户名</span>
              <input class="form-input" type="text"  name="name"/>
              <span class="sign-comment">注册成功后，全美团通用</span>
            </div>
            <div class="form-g">
              <span class="input-tip">手机号码</span>
              <input class="form-input" type="text" name="phoneNum" />
            </div>
            <div class="form-g">
              <span class="input-tip">短信动态码</span>
              <input class="form-input msg-input" text="text"/>
              <input class="msg-btn" value="发送动态码" />
            </div>
            <div class="form-g">
              <span class="input-tip">创建密码</span>
              <input class="form-input" type="password" name="password"/>
            </div>
            <div class="form-g">
              <span class="input-tip">确认密码</span>
              <input class="form-input" type="password" name="repassword" />
            </div>
            <button class="sign-btn" type="submit">同意以下协议并注册</button>
            <a href="http://www.meituan.com/about/terms">《美团网用户协议》</a>
        </form>
   	</div>
  </div><!--container main-->
  <div class="container footer">
    
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